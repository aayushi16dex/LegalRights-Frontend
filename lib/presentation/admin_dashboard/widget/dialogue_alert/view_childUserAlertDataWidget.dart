import 'package:flutter/material.dart';

class ViewChildUserAlertDataWidget {
  static Widget viewChildUserAlertDataWidget(dynamic value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          initialValue: '$value',
          maxLines: 1,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 15) // Set the color for disabled text

          ),
    );
  }
}
