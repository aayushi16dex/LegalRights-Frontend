// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/model/header_data.dart';
import 'package:frontend/presentation/app_start/splash_screen.dart';
import 'package:frontend/presentation/child_dashboard/confirmation_alert/signOutConfirmation.dart';
import 'package:frontend/services/common/ViewProfile/accountInfoScreen.dart';
import 'package:frontend/services/common/ViewProfile/changePasswordScreen.dart';
import 'package:frontend/services/common/ViewProfile/deleteProfileScreen.dart';

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
  Map<String, bool> expandedStates = {
    'AccountInfo': false,
    'ChangePassword': false,
    'DeleteProfile': false,
  };

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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double maxFontSize = screenWidth * 0.07;
    double editIconSize = screenWidth * 0.1;
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
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
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
                  '$firstName $lastName',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Joined on $joinedDate',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0.01 * screenWidth),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 4, 37, 97),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      buildExpandableButton(
                        'AccountInfo',
                        'Account Info',
                        Icons.info_outline,
                        screenWidth,
                        AccountInfoScreen(),
                      ),
                      const SizedBox(height: 8),
                      buildExpandableButton(
                        'ChangePassword',
                        'Change Password',
                        Icons.password,
                        screenWidth,
                        const ChangePasswordScreen(),
                      ),
                      if (userRole == 'CHILD')
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            buildExpandableButton(
                              'DeleteProfile',
                              'Delete Account',
                              Icons.delete_forever,
                              screenWidth,
                              const DeleteProfileScreen(),
                            ),
                          ],
                        ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
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
                                content: const Text(
                                    "Are you sure you want to sign out?"),
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
                                        color: Color.fromARGB(255, 238, 32, 17),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 0.5 * screenWidth,
                          margin: const EdgeInsets.only(
                              top: 8, bottom: 48, right: 20, left: 20),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 238, 32, 17),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
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
        ));
  }

  Widget buildExpandableButton(
    String key,
    String buttonText,
    IconData icon,
    double screenWidth,
    Widget expandedContent,
  ) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              expandedStates.forEach((k, v) {
                if (k != key) {
                  expandedStates[k] = false;
                }
              });

              expandedStates[key] = !expandedStates[key]!;
            });
          },
          child: Container(
            width: 0.8 * screenWidth,
            margin: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 4, 37, 97),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      buttonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Icon(
                  expandedStates[key]!
                      ? Icons.keyboard_double_arrow_up
                      : Icons.keyboard_double_arrow_down,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
        if (expandedStates[key]!)
          Container(
            width: MediaQuery.of(context).size.width * 0.8, // Set width to 100%
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 4, 37, 97),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: expandedContent,
          ),
      ],
    );
  }
}
