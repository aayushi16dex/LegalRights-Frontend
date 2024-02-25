import 'package:flutter/material.dart';

class ViewExpertAlertDataWidget {
  static Widget viewExpertAlertDataWidget(String label, dynamic value,
      bool isDisabled, Function(dynamic) onChanged) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        initialValue: '$value',
        style: isDisabled
            ? const TextStyle(
                color: Colors.black,
                fontSize: 15) // Set the color for disabled text
            : null, // Use default style for editable text
        enabled: !isDisabled,
        onChanged: isDisabled ? null : onChanged,
      ),
    );
  }
}
