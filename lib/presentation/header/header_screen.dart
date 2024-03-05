import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/model/header_data.dart';
import 'package:frontend/presentation/app_start/splash_screen.dart';

class HeaderScreen extends StatefulWidget implements PreferredSizeWidget {
  const HeaderScreen({super.key});

  @override
  _HeaderScreenState createState() => _HeaderScreenState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HeaderScreenState extends State<HeaderScreen> {
  String profileName = '';
  String joinDate = '';
  String initials = '';
  HeaderData hdata = HeaderData();

  @override
  void initState() {
    showProfileDetails();
    super.initState();
  }

  void showProfileDetails() {
    final firstName = hdata.getFirstName();
    final lastName = hdata.getLastName();
    final joinedDate = hdata.getJoinedDate();
    //final displayPic = hdata.getDisplayPic();

    setState(() {
      profileName = firstName + ' ' + lastName;
      joinDate = 'Joined On $joinedDate';
      initials = firstName[0];
    });
  }

  void signOut(BuildContext context) async {
    await TokenManager.clearTokens();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
                child: Stack(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          initials,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 4, 37, 97),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                showMenu(
                  context: context,
                  position:
                      const RelativeRect.fromLTRB(800.0, 0.0, 0.0, 1000.0),
                  items: [
                    PopupMenuItem(
                      child: InkWell(
                        child: const Text('Sign Out'),
                        onTap: () {
                          // Handle sign out
                          signOut(context);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
