import 'package:flutter/material.dart';

class LegalExpertFooterScreen extends StatefulWidget {
  LegalExpertFooterScreen({
    Key? key,
  }) : super(key: key);
  @override
  _LegalExpertFooterScreenState createState() =>
      _LegalExpertFooterScreenState();
}

class _LegalExpertFooterScreenState extends State<LegalExpertFooterScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 4, 37, 97)),
      width: double.infinity,
      height: 60.0,
    );
  }
}
