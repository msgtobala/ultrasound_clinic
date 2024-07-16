import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

class UsgReportListScreen extends StatelessWidget {
  const UsgReportListScreen({
    super.key,
    required this.name,
    required this.phone,
    required this.city,
    required this.pinCode,
    required this.state,
  });

  final num phone;
  final String city;
  final num pinCode;
  final String state;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.d),
        child: ListView(
          children: [
            SizedBox(height: 20.h),
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 20.h),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildDetailRow(Icons.phone, 'Phone No:', phone.toString()),
            _buildDetailRow(Icons.location_city, 'City:', city),
            _buildDetailRow(Icons.pin_drop, 'Postal Code:', pinCode.toString()),
            _buildDetailRow(Icons.map, 'State:', state),
            SizedBox(height: 20.h),
            ElevatedButton.icon(
              onPressed: () {
                // Handle download prescription action
              },
              icon: Icon(Icons.download),
              label: const Text('Download Prescription'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.h),
              ),
            ),
            SizedBox(height: 10.h),
            ElevatedButton.icon(
              onPressed: () {
                // Handle view report action
              },
              icon: Icon(Icons.report),
              label: const Text('View Report'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
