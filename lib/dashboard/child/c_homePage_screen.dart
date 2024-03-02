import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalContent_api/section_apiCall.dart';
import 'package:frontend/presentation/child_dashboard/build_card/contentSection_cardBuild.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int currentPage = 0;
  List<Map<String, dynamic>> sectionList = [];
  final BuildSectionCardBox buildSectionCard = BuildSectionCardBox();
  @override
  void initState() {
    super.initState();
    var sectionListFuture = SectionApiCall.fetchSectionApi(context);
    sectionListFuture.then((result) {
      setState(() {
        sectionList = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10.0),
          // Section 1: Carousel in a round-cornered box
          Container(
            margin: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [
                CarouselSlider(
                  items: [
                    'assets/images/user-screen1.jpg',
                    'assets/images/user-screen2.jpg',
                    'assets/images/user-screen3.png',
                    'assets/images/user-screen4.jpg',
                  ].map((assetPath) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: const Color.fromARGB(255, 28, 96, 223),
                            width: 2.0,
                          )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13.0),
                        child: Image.asset(
                          assetPath,
                          width: double.infinity,
                          // height: 1000,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.1,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  height: MediaQuery.of(context).size.height *
                      0.03, // Height of the indicator
                  child: DotsIndicator(
                    dotsCount: 4, // Number of carousel items
                    position: currentPage.toDouble(), // Initial position
                    decorator: const DotsDecorator(
                      color: Colors.grey, // Inactive dot color
                      activeColor:
                          Color.fromARGB(255, 4, 37, 97), // Active dot color
                      size: Size(20.0, 100.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Add some space
          const SizedBox(height: 10.0),

          // Section 2: Motivational quotes
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: const Text(
                'Play, Learn, Know Your Rights \n\t\t\t\t Fun with Legal Insights!',
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 73, 98, 139)
                    //fontFamily:
                    )),
          ),

          // Section 3: Exciting Quotes
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
            child: const Text('GAME ON!!',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    //color: Color.fromARGB(255, 4, 37, 97),
                    color: Colors.red,
                    fontFamily: 'Anton')),
          ),

          // Section 4: Horizontal Scrollable Boxes
          Container(
            margin: const EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height * 0.38,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  sectionList.length,
                  (index) => buildSectionCard.buildSectionCardBox(
                      sectionList[index],
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
