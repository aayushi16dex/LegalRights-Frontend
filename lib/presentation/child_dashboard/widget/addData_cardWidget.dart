import 'package:flutter/material.dart';

class AddCardDataWidget {
  Widget addCardData(String? textId, dynamic textName) {
    return RichText(
      text: TextSpan(
        text: textId,
        style: const TextStyle(
            color: Color.fromARGB(255, 4, 37, 97),
            fontSize: 16,
            fontWeight: FontWeight.normal),
        children: [
          TextSpan(
            text: textName,
            style: const TextStyle(
                color: Color.fromARGB(255, 4, 37, 97),
                fontWeight: FontWeight.normal,
                fontSize: 15),
          ),
        ],
      ),
    );
  }
}
