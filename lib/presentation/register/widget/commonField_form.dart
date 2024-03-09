// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/services/register/registerForm_Service.dart';
import 'package:frontend/model/signup_controller.dart';

class CommonFormFieldWidget extends StatefulWidget {
  final SignupFieldController commonSignupController;
  final bool isAdmin;
  CommonFormFieldWidget(
      {required this.commonSignupController, required this.isAdmin});
  @override
  _CommonFormFieldWidgetState createState() => _CommonFormFieldWidgetState();
}

class _CommonFormFieldWidgetState extends State<CommonFormFieldWidget> {
  SignupFieldController get commonSignupController =>
      widget.commonSignupController;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String confirmPasswordError = '';
  void checkPasswordMatch() {
    setState(() {
      confirmPasswordError = commonSignupController.passwordController.text ==
              commonSignupController.confirmPasswordController.text
          ? ''
          : 'Passwords do not match';
    });
  }

  TextCapitalizationTextInputFormatter capitalizationFormatter =
      TextCapitalizationTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(children: [
      Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: commonSignupController.firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              inputFormatters: [capitalizationFormatter],
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: TextFormField(
              controller: commonSignupController.lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              inputFormatters: [capitalizationFormatter],
            ),
          ),
        ],
      ),
      const SizedBox(height: 16.0),
      TextFormField(
        autovalidateMode: AutovalidateMode.always,
        validator: RegisterFormService.validateEmail,
        controller: commonSignupController.emailController,
        decoration: const InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      const SizedBox(height: 16.0),
      if (!widget.isAdmin)
        TextFormField(
          controller: commonSignupController.passwordController,
          autovalidateMode: AutovalidateMode.always,
          validator: RegisterFormService.validatePassword,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),
      if (!widget.isAdmin)
        const SizedBox(
          height: 16,
        ),
      if (!widget.isAdmin)
        TextFormField(
          controller: commonSignupController.confirmPasswordController,
          onChanged: (value) {
            checkPasswordMatch();
          },
          obscureText: !_isConfirmPasswordVisible,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            labelStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
          ),
        ),
      if (widget.isAdmin)
        if (confirmPasswordError.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              confirmPasswordError,
              style: const TextStyle(color: Colors.red),
            ),
          ),
    ]));
  }
}

class TextCapitalizationTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      return TextEditingValue(
        text: newValue.text[0].toUpperCase() + newValue.text.substring(1),
        selection: newValue.selection,
      );
    }
    return newValue;
  }
}
