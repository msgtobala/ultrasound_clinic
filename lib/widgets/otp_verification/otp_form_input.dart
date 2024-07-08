import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/screens/clinic_code_screen.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/widgets/common/custom_button.dart';

class OtpFormInput extends StatefulWidget {
  const OtpFormInput({super.key});

  @override
  State<OtpFormInput> createState() => _OtpFormInputState();
}

class _OtpFormInputState extends State<OtpFormInput> {
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(() {
        if (controller.text.isEmpty) {
          // Handle the case when the text field is cleared
          print('Text field cleared');
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 20.px),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  width: 55.px,
                  height: 55.px,
                  decoration: BoxDecoration(
                    border: Border.all(color: ThemeColors.black),
                    borderRadius: BorderRadius.circular(10.px),
                  ),
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    cursorColor: ThemeColors.black,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (_controllers[index].value.text.isNotEmpty &&
                          index < 4) {
                        FocusScope.of(context)
                            .requestFocus(_focusNodes[index + 1]);
                      }
                      if (_controllers[index].value.text.isEmpty && index > 0) {
                        FocusScope.of(context)
                            .requestFocus(_focusNodes[index - 1]);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 30.px,
          ),
          CustomElevatedButton(
            text: Strings.verify,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ClinicCodeScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
