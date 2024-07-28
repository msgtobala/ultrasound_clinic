/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendNotificationOnNewUsg = functions.firestore
    .document('/clinics/{clinicId}/usg/{usgId}')
    .onCreate(async (snapshot, context) => {
        const clinicId = context.params.clinicId;
        const usgId = context.params.usgId;
        const newUsgData = snapshot.data();

        // Extract the userId from the new USG document
        const userId = newUsgData.userId;

        if (!userId) {
            console.log('No userId found in the USG document. Skipping notification.');
            return;
        }

        // Fetch the user document
        const userDoc = await admin.firestore().collection('users').doc(userId).get();
        
        if (!userDoc.exists) {
            console.log(`User document ${userId} not found. Skipping notification.`);
            return;
        }

        const userData = userDoc.data();
        const fcmToken = userData.fcmToken;

        if (!fcmToken) {
            console.log(`No FCM token found for user ${userId}. Skipping notification.`);
            return;
        }

        const message = {
            notification: {
                title: 'New USG Report',
                body: `Your new USG report (${newUsgData.receiptNumber}) is ready.`,
            },
            data: {
                clinicId: clinicId,
                usgId: usgId,
                receiptNumber: newUsgData.receiptNumber || '',
                receiptUrl: newUsgData.receiptUrl || '',
                report: newUsgData.report || '',
                state: newUsgData.state || '',
                usgRefId: newUsgData.usgRefId || '',
            },
            token: fcmToken
        };

        try {
            await admin.messaging().send(message);
            console.log(`Notification sent successfully to user ${userId}`);
        } catch (error) {
            console.log(`Error sending notification to user ${userId}:`, error);
        }
    });