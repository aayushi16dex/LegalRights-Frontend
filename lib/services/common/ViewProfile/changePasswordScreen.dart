// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/api_call/userChild_api/changePasswordApi.dart';
import 'package:frontend/presentation/child_dashboard/confirmation_alert/passwordChangeConfirmation.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordMatching = true;
  bool isPasswordValid = true;
  bool hasConfirmedPasswordFieldFocus = false;

  bool showCurrentPassword = false;
  bool showNewPassword = false;
  bool showConfirmPassword = false;

  late FocusNode currentPasswordFocus;
  late FocusNode newPasswordFocus;
  late FocusNode confirmPasswordFocus;

  @override
  void initState() {
    super.initState();
    currentPasswordFocus = FocusNode();
    newPasswordFocus = FocusNode();
    confirmPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    currentPasswordFocus.dispose();
    newPasswordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.dispose();
  }

  void validatePassword() {
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;
    setState(() {
      isPasswordMatching = newPassword == confirmPassword;
      RegExp passwordPattern = RegExp(
        r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})',
      );
      isPasswordValid = passwordPattern.hasMatch(newPassword);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildPasswordField(
              controller: currentPasswordController,
              label: 'Current Password',
              focusNode: currentPasswordFocus,
              showPassword: showCurrentPassword,
              toggleVisibility: () {
                setState(() {
                  showCurrentPassword = !showCurrentPassword;
                });
              },
            ),
            const SizedBox(height: 16),
            buildPasswordField(
              controller: newPasswordController,
              label: 'New Password',
              focusNode: newPasswordFocus,
              showPassword: showNewPassword,
              toggleVisibility: () {
                setState(() {
                  showNewPassword = !showNewPassword;
                });
              },
              onChanged: (_) => validatePassword(),
              errorText: isPasswordValid ? null : buildPasswordErrorMessage(),
            ),
            const SizedBox(height: 16),
            buildPasswordField(
              controller: confirmPasswordController,
              label: 'Confirm Password',
              focusNode: confirmPasswordFocus,
              showPassword: showConfirmPassword,
              toggleVisibility: () {
                setState(() {
                  showConfirmPassword = !showConfirmPassword;
                });
              },
              onTap: () {
                setState(() {
                  hasConfirmedPasswordFieldFocus = true;
                });
              },
              onChanged: (_) {
                validatePassword();
              },
              errorText: hasConfirmedPasswordFieldFocus
                  ? isPasswordMatching
                      ? null
                      : 'Passwords do not match.'
                  : null,
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    if (!isPasswordValid || !isPasswordMatching) {
                      return;
                    }

                    String currentPassword = currentPasswordController.text;
                    String newPassword = newPasswordController.text;

                    ChangePasswordApi changePasswordApi = ChangePasswordApi();
                    var response = await changePasswordApi.changePassword(
                        context, currentPassword, newPassword);

                    if (response == 200) {
                      PasswordChangeconfirmation passwordChangeconfirmation =
                          PasswordChangeconfirmation();
                      passwordChangeconfirmation
                          .passwordChangeConfirmationAlert(context);
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    } else if (response == 400) {
                      showErrorConfirmation(context, 'Incorrect old password');
                    } else {
                      showErrorConfirmation(context, "An Error Occured!!!");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 4, 37, 97),
                ),
                child: const Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPasswordField({
    required TextEditingController controller,
    required String label,
    required FocusNode focusNode,
    required bool showPassword,
    VoidCallback? toggleVisibility,
    VoidCallback? onTap,
    ValueChanged<String>? onChanged,
    String? errorText,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !showPassword,
      focusNode: focusNode,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 4, 37, 97),
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
        errorText: errorText,
        errorStyle: const TextStyle(
          fontSize: 16,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            showPassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: toggleVisibility,
        ),
      ),
      style: const TextStyle(
        color: Color.fromARGB(255, 4, 37, 97),
        fontSize: 18,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label.';
        }
        return null;
      },
    );
  }

  String buildPasswordErrorMessage() {
    List<String> requirements = [];
    if (newPasswordController.text.length < 6) {
      requirements.add('At least 6 characters');
    }
    if (!RegExp(r'[A-Z]').hasMatch(newPasswordController.text)) {
      requirements.add('One uppercase letter');
    }
    if (!RegExp(r'[0-9]').hasMatch(newPasswordController.text)) {
      requirements.add('One number');
    }
    if (!RegExp(r'[!@#\$%\^&\*]').hasMatch(newPasswordController.text)) {
      requirements.add('One special character');
    }
    return 'Password must contain:\n- ${requirements.join('\n- ')}';
  }
}

void showErrorConfirmation(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 4, 37, 97),
          ),
        ),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 37, 97),
              ),
            ),
          ),
        ],
      );
    },
  );
}
