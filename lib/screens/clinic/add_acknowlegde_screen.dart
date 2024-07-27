import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/models/common/form_model.dart';
import 'package:ultrasound_clinic/models/common/usg_model.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/common/custom_app_bar_text.dart';
import 'package:ultrasound_clinic/widgets/common/custom_dashed_input.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';
import 'package:ultrasound_clinic/widgets/common/generic_media_dialog.dart';

class AddAcknowlegdeScreen extends StatefulWidget {
  const AddAcknowlegdeScreen({super.key});

  @override
  State<AddAcknowlegdeScreen> createState() => _AddAcknowlegdeScreenState();
}

class _AddAcknowlegdeScreenState extends State<AddAcknowlegdeScreen> {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isUploadValid = false;
  File? _image;
  late USGModel userUSGDetails;
  late Future<bool> Function(File, String, String, String) onSaveReceipt;
  List<FormModel>? formInputs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      userUSGDetails = arguments['userUSGDetails'] as USGModel;
      onSaveReceipt = arguments['onSave'] as Future<bool> Function(
          File, String, String, String);

      setState(() {
        formInputs = [
          FormModel(
            type: 'text',
            label: userUSGDetails.patientName,
            key: 'patientName',
          ),
          FormModel(
            type: 'text',
            label: userUSGDetails.mobileNumber,
            key: 'mobileNumber',
          ),
          FormModel(
              type: 'text', label: userUSGDetails.address, key: 'address'),
          FormModel(type: 'text', label: userUSGDetails.city, key: 'city'),
          FormModel(label: 'Next', type: 'next', key: 'next', next: [
            FormModel(type: 'text', label: userUSGDetails.state, key: 'state'),
            FormModel(
                type: 'text', label: userUSGDetails.pinCode, key: 'pinCode'),
          ]),
        ];
      });
    });
  }

  void onSaveMedia(File file) {
    setState(() {
      _image = file;
      _isUploadValid = true;
    });
  }

  void _onReceiptUpload() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericMediaDialog(
          mediaHeading: Strings.receipt,
          onSaveMedia: onSaveMedia,
        );
      },
    );
  }

  Future<void> onSubmit() async {
    if (_image != null && _isUploadValid) {
      setState(() {
        _isLoading = true;
      });

      final isUploaded = await onSaveReceipt(
        _image!,
        userUSGDetails.uid,
        userUSGDetails.usgRefId,
        userUSGDetails.userId,
      );

      setState(() {
        _isLoading = false;
      });

      if (isUploaded) {
        Navigator.of(context).pop();
        showSnackbar(context, Strings.receiptUploadedSuccessfully);
      } else {
        showSnackbar(context, Strings.receiptUploadFailed);
      }
    } else {
      showSnackbar(context, Strings.invalidReceiptImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (formInputs == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: const CustomAppBarText(
        title: Strings.acknowledge,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.d),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ...formInputs!.map(
                        (input) {
                          if (input.type == 'text') {
                            return Column(
                              children: [
                                FormInput(
                                  text: input.label,
                                  hintText: input.label,
                                  readOnly: true,
                                ),
                                SizedBox(height: 20.h),
                              ],
                            );
                          }
                          if (input.type == 'next') {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...input.next!.map((nextInput) {
                                      return Flexible(
                                        key: Key(nextInput.label),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.43,
                                          child: FormInput(
                                            text: nextInput.label,
                                            hintText: nextInput.label,
                                            readOnly: true,
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                              ],
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
                CustomDashedInput(
                  text: _image == null
                      ? Strings.uploadReceipt
                      : Strings.receiptJpg,
                  onTap: _onReceiptUpload,
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: Strings.submit,
                    onPressed: onSubmit,
                    isLoading: _isLoading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
