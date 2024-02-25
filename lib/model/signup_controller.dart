import 'package:flutter/material.dart';

class SignupFieldController {
  // common field controller
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // user related controller
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // legal expert controller
  TextEditingController yearsOfExperience = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController expertiseController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController stateController = TextEditingController();
}
