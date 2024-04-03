// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:frontend/model/header_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/services/common/ViewProfile/accountInfoScreen.dart';
import 'package:frontend/services/common/ViewProfile/changePasswordScreen.dart';
import 'package:frontend/services/common/ViewProfile/deleteProfileScreen.dart';
import 'package:frontend/services/common/ViewProfile/profileImage.dart';
import 'package:frontend/services/common/ViewProfile/signOutWidget.dart';
import 'package:frontend/services/common/ViewProfile/updateDisplayImage.dart';

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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double maxFontSize = screenWidth * 0.06;
    final userRole = hdata.getUserRole();
    String firstName = hdata.getFirstName();
    String lastName = hdata.getLastName();
    final joinedDate = hdata.getJoinedDate();
    var displayPic = hdata.getDisplayPic();

    String? cloudUrl = dotenv.env['FETCH_IMAGE_URL'];

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'My Profile',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: maxFontSize,
                color: Colors.white),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: const Color.fromARGB(255, 4, 37, 97),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                ProfileImage(cloudUrl: cloudUrl, displayPic: displayPic, firstName: firstName, initialsSize: 40),            
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    String? newDisplayPic =
                        await UpdateDisplayImage.updateDisplayPicture(context);
                        setState(() {
                          displayPic = newDisplayPic;
                        });
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 22, 0, 95),
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.edit,
                        size: 25,
                      ),
                      SizedBox(width: 5),
                      Text('Edit profile picture'),
                    ],
                  ),
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
                      SignOutWidget.signOut(context)
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
            width: MediaQuery.of(context).size.width * 0.8,
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
