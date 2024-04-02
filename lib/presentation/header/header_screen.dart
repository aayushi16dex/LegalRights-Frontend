// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:frontend/model/header_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/services/common/ViewProfile/profileImage.dart';
import 'package:frontend/services/common/ViewProfile/viewProfile.dart';

class HeaderScreen extends StatefulWidget implements PreferredSizeWidget {
  const HeaderScreen({Key? key});

  @override
  _HeaderScreenState createState() => _HeaderScreenState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HeaderScreenState extends State<HeaderScreen> {
  String initials = '';
  HeaderData hdata = HeaderData();

  @override
  void initState() {
    showProfileDetails();
    super.initState();
  }

  fetchImage() async {
    await dotenv.load(fileName: '.env');
    String? cloudUrl = dotenv.env['FETCH_IMAGE_URL'];
    return cloudUrl;
  }

  void showProfileDetails() {
    final firstName = hdata.getFirstName();

    setState(() {
      initials = firstName[0].toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    var displayPic = hdata.getDisplayPic();
    final firstName = hdata.getFirstName();
    Future<dynamic> cloudUrl = fetchImage();

    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        color: const Color.fromARGB(255, 4, 37, 97),
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tiny Advocate",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.001),
                padding: const EdgeInsets.all(10.0),
                child: ProfileImage(cloudUrl: cloudUrl, displayPic: displayPic, firstName: firstName, initialsSize: 20,), 
              ),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                MaterialPageRoute(
                    builder: (context) => const ViewProfileScreen(),
                  ),
                );
                if (result == 'refresh') {
                  showProfileDetails();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
