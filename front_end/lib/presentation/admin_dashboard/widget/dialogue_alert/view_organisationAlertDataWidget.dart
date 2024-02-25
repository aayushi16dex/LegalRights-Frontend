import 'package:flutter/material.dart';

class ViewOrganisationAlertDataWidget {
  static Widget viewOrganisationAlertDataWidget(
      dynamic value, bool isDisabled, Function(dynamic) onChanged) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: TextFormField(
          decoration: !isDisabled
              ? const InputDecoration(
                  border: OutlineInputBorder(), // Add border here
                )
              : null,

          initialValue: '$value',
          maxLines: !isDisabled ? 3 : 5,
          minLines: 1,
          showCursor: true,
          style: isDisabled
              ? const TextStyle(
                  color: Colors.black,
                  fontSize: 15) // Set the color for disabled text
              : null, // Use default style for editable text
          enabled: !isDisabled,
          onChanged: isDisabled ? null : onChanged,
        ),
      ),
    );
  }
}
