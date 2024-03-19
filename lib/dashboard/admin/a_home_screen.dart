// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final Map<String, double> dataMap = {
    "Children": 17.73,
    "Organisations": 23.52,
    "Legal Experts": 29.41,
    "Legal Rights": 29.41,
  };

  final List<Color> colorList = [
    const Color.fromARGB(255, 90, 154, 243),
    const Color.fromARGB(255, 62, 205, 224),
    const Color(0xff3398F6),
    const Color.fromARGB(255, 25, 25, 220),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: const Column(
                  children: [
                    SizedBox(height: 50),
                    // Container(
                    //   color: Theme.of(context).primaryColor,
                    //   child: ListTile(
                    //     contentPadding:
                    //         const EdgeInsets.symmetric(horizontal: 30),
                    //     title: Text(
                    //       'Admin Dashboard!',
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .headline6
                    //           ?.copyWith(color: Colors.white),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: PieChart(
                  dataMap: dataMap,
                  colorList: colorList,
                  chartRadius: MediaQuery.of(context).size.width / 2,
                  centerText: ".",
                  ringStrokeWidth: 24,
                  animationDuration: const Duration(seconds: 5),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValues: true,
                    showChartValuesOutside: true,
                    showChartValuesInPercentage: true,
                    showChartValueBackground: false,
                  ),
                  legendOptions: const LegendOptions(
                    showLegends: true,
                    legendShape: BoxShape.rectangle,
                    legendTextStyle: TextStyle(fontSize: 15),
                    legendPosition: LegendPosition.bottom,
                    showLegendsInRow: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200)),
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 30,
                  children: [
                    itemDashboard(
                        'Children: 3', Icons.person, Colors.deepOrange),
                    itemDashboard(
                        'Legal Experts: 5', Icons.people, Colors.green),
                    itemDashboard(
                        'Organisations : 4', Icons.house, Colors.purple),
                    itemDashboard(
                        'Legal Rights: 5', Icons.balance, Colors.brown),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemDashboard(String title, IconData iconData, Color background) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.blue[900],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
              ),
              selectionColor: Colors.white,
            ),
          ],
        ),
      );
}
