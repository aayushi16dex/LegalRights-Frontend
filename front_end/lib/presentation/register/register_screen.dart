// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api
import 'package:flutter/material.dart';

import 'package:frontend/api_call/register/register_apiCall.dart';
import 'package:frontend/services/register/registerForm_Service.dart';

import 'package:frontend/model/signup_controller.dart';
import 'package:frontend/presentation/signin/signin_screen.dart';
import 'package:frontend/presentation/register/widget/commonField_form.dart';
import 'package:frontend/presentation/register/widget/legalExpertField_form.dart';

class SignUpScreen extends StatefulWidget {
  final bool isAdmin;
  const SignUpScreen({super.key, required this.isAdmin});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignupFieldController signupFieldController = SignupFieldController();
  final RegisterApiCall registerApiCall = RegisterApiCall();

  @override
  void initState() {
    super.initState();
  }

  /// Reseting the form
  void resetForm() {
    setState(() {
      signupFieldController.emailController.text = '';
      signupFieldController.passwordController.text = '';
      signupFieldController.confirmPasswordController.text = '';
      signupFieldController.firstNameController.text = '';
      signupFieldController.lastNameController.text = '';
      signupFieldController.languageController.text = '';
      signupFieldController.expertiseController.text = '';
      signupFieldController.stateController.text = '';
      signupFieldController.professionController.text = '';
      signupFieldController.yearsOfExperience.text = '';
    });
  }

  /// sending data for register according to user role
  String confirmPasswordError = '';
  Future<void> signUp(SignupFieldController signupFieldController) async {
    if (signupFieldController.passwordController.text !=
        signupFieldController.confirmPasswordController.text) {
      setState(() {
        confirmPasswordError = 'Passwords do not match';
      });
      return;
    }
    RegisterFormService.registerData(
        widget.isAdmin, context, signupFieldController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Registration Page',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'PressStart2P'),
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color.fromARGB(255, 4, 37, 97),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
        body: Center(
            child: Column(children: [
          const SizedBox(height: 10.0),
          Expanded(
              child: Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      CommonFormFieldWidget(
                        commonSignupController: signupFieldController,
                        isAdmin: widget.isAdmin,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // if admin is true then only visible below code
                  if (widget.isAdmin)
                    Row(
                      children: [
                        ExpertFormFieldWidget(
                            expertSignupController: signupFieldController),
                      ],
                    ),

                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      signUp(signupFieldController);
                      resetForm();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 4, 37, 97),
                      textStyle: const TextStyle(fontSize: 18.0),
                    ),
                    child: const Text('Register'),
                  ),
                  if (!widget.isAdmin)
                    const Text(
                      'Or',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  if (!widget.isAdmin)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()),
                        );
                      },
                      child: Center(
                        child: RichText(
                          text: const TextSpan(
                            text: 'Already registered? ',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: 'Sign in',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 4, 37, 97),
                                    // decoration: TextDecoration.underline,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ))
        ])));
  }
}
