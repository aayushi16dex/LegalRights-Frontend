// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:frontend/api_call/profileData_api/profileData_apiCall.dart';
import 'package:frontend/api_call/userChild_api/changeAccountInfoApi.dart';
import 'package:frontend/core/role.dart';
import 'package:frontend/model/header_data.dart';
import 'package:frontend/presentation/child_dashboard/confirmation_alert/accountInfoChangeConfirmation.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({Key? key}) : super(key: key);

  @override
  _AccountInfoScreenState createState() => _AccountInfoScreenState();
}

final HeaderData hdata = HeaderData();
late TextEditingController firstNameController;
late TextEditingController lastNameController;
String previousFirstName = '';
String previousLastName = '';
String userRole = '';

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: hdata.getFirstName());
    lastNameController = TextEditingController(text: hdata.getLastName());
    previousFirstName = hdata.getFirstName();
    previousLastName = hdata.getLastName();
    userRole = hdata.getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    bool sameNames = firstNameController.text.trim() == previousFirstName &&
        lastNameController.text.trim() == previousLastName;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: firstNameController,
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 105, 102, 102),
            ),
            onChanged: (value) {
              setState(() {});
              _formatName(firstNameController, value);
            },
            decoration: InputDecoration(
              labelText: 'First Name',
              labelStyle: const TextStyle(
                  color: Color.fromARGB(255, 4, 37, 97),
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
              errorText: firstNameController.text.trim().isEmpty
                  ? 'First name cannot be empty.'
                  : null,
            ),
            readOnly: userRole == roleAdmin,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: lastNameController,
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 105, 102, 102),
            ),
            onChanged: (value) {
              setState(() {});
              _formatName(lastNameController, value);
            },
            decoration: const InputDecoration(
              labelText: 'Last Name',
              labelStyle: TextStyle(
                  color: Color.fromARGB(255, 4, 37, 97),
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            
            readOnly: userRole == roleAdmin,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextFormField(
            initialValue: hdata.getEmailId(),
            readOnly: true,
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 105, 102, 102),
            ),
            decoration: const InputDecoration(
              labelText: 'Email ID',
              labelStyle: TextStyle(
                  color: Color.fromARGB(255, 4, 37, 97),
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
          ),
        ),
        if (!sameNames)
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 25),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (firstNameController.text.trim().isNotEmpty ||userRole == roleChild || userRole == roleLegalExpert)
                    ElevatedButton(
                      onPressed: () async {
                        updateAccountInfo(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
                      ),
                      child: const Text(
                        'Update Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  const SizedBox(width: 10),
                  if (userRole == roleLegalExpert || userRole == roleChild)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          firstNameController.text = previousFirstName;
                          lastNameController.text = previousLastName;
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 117, 113, 112),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  bool valueIsEmpty(String value) => value.trim().isEmpty;
  void _formatName(TextEditingController controller, String value) {
    final formattedValue = value.trim();
    if (formattedValue.isNotEmpty) {
      final firstLetter = formattedValue[0].toUpperCase();
      final rest = formattedValue.substring(1).toLowerCase();
      final newValue = '$firstLetter$rest';
      if (value != newValue) {
        controller.value = controller.value.copyWith(
          text: newValue,
          selection: TextSelection.collapsed(offset: newValue.length),
        );
      }
    }
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

Future<void> updateAccountInfo(BuildContext context) async {
  ChangeAccountInfoApi changeAccountInfoApi = ChangeAccountInfoApi();
  var response = await changeAccountInfoApi.changeAccountInfo(
      context,
      hdata.getId(),
      firstNameController.text,
      lastNameController.text,
      userRole);
  if (response == 200) {
    AccountInfoChangeconfirmation accountInfoChangeconfirmation =
        AccountInfoChangeconfirmation();
    accountInfoChangeconfirmation.accountInfoChangeConfirmationAlert(context);

    await ProfileHeaderDataApiCal.profileDataApi(context);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      Navigator.pop(context, 'refresh');
    });
  } else {
    showErrorConfirmation(context, "An Error Occured!!!");
  }
}
