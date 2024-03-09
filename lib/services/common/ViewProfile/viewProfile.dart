// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/model/header_data.dart';
import 'package:frontend/presentation/app_start/splash_screen.dart';
import 'package:frontend/presentation/child_dashboard/confirmation_alert/deleteProfileConfirmation.dart';
import 'package:frontend/presentation/child_dashboard/confirmation_alert/signOutConfirmation.dart';
import 'package:frontend/api_call/userChild_api/deleteProfileApi.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({Key? key}) : super(key: key);

  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HeaderData hdata = HeaderData();
  bool hasFirstNameChanges = false;
  bool hasLastNameChanges = false;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: hdata.getFirstName());
    lastNameController = TextEditingController(text: hdata.getLastName());
  }

  void signOut(BuildContext context) async {
    await TokenManager.clearTokens();
    SignOutconfirmation signOutconfirmation = SignOutconfirmation();
    signOutconfirmation.signOutConfirmationAlert(context);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen()),
      );
    });
  }

  void showDeleteConfirmationDialog(String userId) async {
    bool shouldPop = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirmation",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 4, 37, 97),
            ),
          ),
          content: const Text(
            "Are you sure you want to delete your profile permanently?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                "No",
                style: TextStyle(
                  color: Color.fromARGB(255, 4, 37, 97),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                "Yes",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );

    if (shouldPop == true) {
      int? statusCode = await DeleteProfileApi.deleteProfile(context, userId);
      DeleteProfileconfirmation deleteProfileconfirmation =
          DeleteProfileconfirmation();
      if (statusCode == 200) {
        await TokenManager.clearTokens();
        deleteProfileconfirmation.deleteProfileConfirmationAlert(context);
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SplashScreen()),
          );
        });
      } else {
        showSnackBar('Failed to delete profile. Status code: $statusCode');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double maxFontSize = screenWidth * 0.07;
    double editIconSize = screenWidth * 0.1;
    final id = hdata.getId();
    final userRole = hdata.getUserRole();
    String firstName = hdata.getFirstName();
    String lastName = hdata.getLastName();
    final joinedDate = hdata.getJoinedDate();
    final displayPic = firstName[0].toUpperCase();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: maxFontSize,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
        centerTitle: true,
        actions: [
          if (userRole == 'CHILD')
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDeleteConfirmationDialog(id);
              },
            ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16),
                width: screenWidth * 0.3,
                height: screenWidth * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 219, 223, 219),
                  border: Border.all(
                    color: const Color.fromARGB(255, 4, 37, 97),
                    width: 2.0,
                  ),
                ),
                child: Center(
                  child: Text(
                    displayPic,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 4, 37, 97),
                      fontSize: screenWidth * 0.25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -8,
                bottom: -8,
                child: IconButton(
                  icon: const Icon(Icons.edit_rounded,
                      color: Color.fromARGB(255, 4, 37, 97)),
                  iconSize: editIconSize,
                  onPressed: () {
                    // edit functionality here
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Joined Date: $joinedDate',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16),
                width: screenWidth * 0.9,
                child: TextField(
                  controller: firstNameController,
                  style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 37, 97)),
                  onChanged: (value) {
                    setState(() {
                      hasFirstNameChanges = true;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 105, 102, 102),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: screenWidth * 0.9,
                child: TextField(
                  controller: lastNameController,
                  style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 37, 97)),
                  onChanged: (value) {
                    setState(() {
                      hasLastNameChanges = true;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 105, 102, 102),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (hasFirstNameChanges || hasLastNameChanges)
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print(
                              "Updated First Name: ${firstNameController.text}");
                          print(
                              "Updated Last Name: ${lastNameController.text}");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            4,
                            37,
                            97,
                          ),
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
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            firstNameController.text = firstName;
                            lastNameController.text = lastName;
                            hasFirstNameChanges = false;
                            hasLastNameChanges = false;
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            117,
                            113,
                            112,
                          ),
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
                    ),
                  ],
                ),
              ),
            ),

          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Sign Out Confirmation",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 4, 37, 97),
                          ),
                        ),
                        content:
                            const Text("Are you sure you want to sign out?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "No",
                              style: TextStyle(
                                color: Color.fromARGB(255, 4, 37, 97),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              signOut(context);
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 238, 32, 17),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                ),
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
