// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/presentation/register/register_screen.dart';
import '../../services/common/forget_password_Service.dart';
import '../../api_call/sigin_api/signin_apiCall.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInApiCall signInLogic = SignInApiCall();
  final ForgetPasswordService forgetPasswordService = ForgetPasswordService();

  bool _isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? validateEmail(String? value) {
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final emailRegex = RegExp(pattern);

    return value!.isNotEmpty && !emailRegex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  void resetForm() {
    setState(() {
      emailController.text = '';
      passwordController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 37, 97),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Gif images at the top of the screen
              Image.asset(
                'assets/images/signin.gif',
                height: 250,
                width: 600,
                //fit: BoxFit.cover,
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Sign in to continue',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PressStart2P',
                    fontSize: 30),
              ),
              const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      validator: validateEmail,
                      controller: emailController,
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        // Implement forgot password functionality
                        forgetPasswordService.showForgotPasswordPopup(context);
                      },
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Color.fromARGB(255, 4, 37, 97),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        signInLogic.authenticateUserApi(context,
                            emailController.text, passwordController.text);
                        resetForm();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
                        textStyle: const TextStyle(
                            fontSize: 18.0), // Adjust the font size as needed
                      ),
                      child: const Text('Sign In'),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen(
                                    isAdmin: false,
                                  )),
                        );
                      },
                      child: Center(
                        child: RichText(
                          text: const TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text: 'Sign up',
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
            ],
          ),
        ),
      ),
    );
  }
}
