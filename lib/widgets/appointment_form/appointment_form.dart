import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/models/common/form_model.dart';
import 'package:ultrasound_clinic/resources/regex.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/utils/date_time/date_time.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';

class AppointmentForm extends StatefulWidget {
  final bool isLoading;
  final void Function(Map<String, dynamic> appointment) addAppointment;

  const AppointmentForm({
    super.key,
    required this.isLoading,
    required this.addAppointment,
  });

  @override
  State<AppointmentForm> createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> formData = {
    'patientName': '',
    'mobileNumber': '',
    'date': '',
    'time': '',
  };
  final List<FormModel> formInputs = [
    FormModel(
      type: 'text',
      label: Strings.patientName,
      key: 'patientName',
      keyboardType: TextInputType.name,
    ),
    FormModel(
      type: 'text',
      label: Strings.mobileNumber,
      key: 'mobileNumber',
      keyboardType: TextInputType.phone,
    ),
    FormModel(
      type: 'date',
      label: Strings.selectDate,
      key: 'date',
      prefixIcon: const Icon(Icons.calendar_today),
    ),
    FormModel(
      type: 'time',
      label: Strings.selectTime,
      key: 'time',
      prefixIcon: const Icon(Icons.access_time),
    ),
  ];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  void resetForm() {
    _formKey.currentState?.reset();
    _dateController.clear();
    _timeController.clear();
    formData.forEach((key, value) {
      formData[key] = '';
    });
  }

  Future<void> _onSelectDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      final formattedDate = date.toString().split(" ")[0];
      _dateController.text = formattedDate;
      _onSaved('date', formattedDate);
    }
  }

  Future<void> _onSelectTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      String formattedTime = time.format(context);
      _timeController.text = formattedTime;
      _onSaved('time', formattedTime);
    }
  }

  void _handleAppointment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      widget.addAppointment({
        'patientName': formData['patientName']!,
        'mobileNumber': formData['mobileNumber']!,
        'date': parseDateTime(formData['date']!, formData['time']!),
        'requestDate': DateTime.now(),
      });
      resetForm();
    }
  }

  void _onSaved(String key, String? value) {
    formData[key] = value!;
  }

  String? validator(
    String key,
    String? value,
  ) {
    final phonePattern = RegExp(Regex.phoneRegEx);
    if (key == 'patientName' && (value == null || value.isEmpty)) {
      return Strings.invalidPatientName;
    }

    if (key == 'mobileNumber' &&
        (value == null || value.isEmpty || !phonePattern.hasMatch(value))) {
      return Strings.invalidMobileNumber;
    }

    if (key == 'date' && (value == null || value.isEmpty)) {
      return Strings.invalidDate;
    }

    if (key == 'time' && (value == null || value.isEmpty)) {
      return Strings.invalidTime;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ...formInputs.map((input) {
              if (input.type == 'text') {
                return Column(
                  key: Key(input.label),
                  children: [
                    FormInput(
                      text: input.label,
                      onSaved: (value) => _onSaved(input.key, value),
                      validator: (value) => validator(input.key, value!),
                    ),
                    SizedBox(height: 20.h),
                  ],
                );
              }

              if (input.type == 'date') {
                return Column(
                  key: Key(input.label),
                  children: [
                    FormInput(
                      text: input.label,
                      prefixIcon: input.prefixIcon,
                      readOnly: true,
                      controller: _dateController,
                      onSaved: (value) => _onSaved(input.key, value),
                      validator: (value) => validator(input.key, value!),
                      onTap: _onSelectDate,
                    ),
                    SizedBox(height: 20.h),
                  ],
                );
              }

              if (input.type == 'time') {
                return Column(
                  key: Key(input.label),
                  children: [
                    FormInput(
                      text: input.label,
                      prefixIcon: input.prefixIcon,
                      readOnly: true,
                      controller: _timeController,
                      onSaved: (value) => _onSaved(input.key, value),
                      validator: (value) => validator(input.key, value!),
                      onTap: _onSelectTime,
                    ),
                    SizedBox(height: 20.h),
                  ],
                );
              }

              if (input.type == 'next') {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      key: Key(input.label),
                      children: [
                        ...input.next!.map((nextInput) {
                          return Flexible(
                            key: Key(nextInput.label),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.43,
                              child: FormInput(
                                text: nextInput.label,
                                onSaved: (value) => _onSaved(input.key, value),
                                validator: (value) =>
                                    validator(input.key, value!),
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
            }),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: Strings.provideAnAppointmentNo,
                onPressed: _handleAppointment,
                isLoading: widget.isLoading,
              ),
            )
          ],
        ),
      ),
    );
  }
}
