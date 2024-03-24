import 'package:flutter/material.dart';

class ViewExpertAlertDataWidget {
  static Widget viewExpertAlertDataWidget(String label, dynamic value,
      bool isDisabled, Function(dynamic) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: _ViewExpertAlertDataWidget(
        label: label,
        value: value,
        isDisabled: isDisabled,
        onChanged: onChanged,
      ),
    );
  }
}

class _ViewExpertAlertDataWidget extends StatelessWidget {
  final String label;
  final dynamic value;
  final bool isDisabled;
  final Function(dynamic) onChanged;

  const _ViewExpertAlertDataWidget({
    Key? key,
    required this.label,
    required this.value,
    required this.isDisabled,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isDisabled ? Colors.grey : Colors.black,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 180, 177, 177),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDisabled
                ? Colors.grey.shade300
                : const Color.fromARGB(255, 4, 37, 97),
            width: 1.5,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        filled: true,
        fillColor: isDisabled ? Colors.grey[200] : Colors.white,
      ),
      initialValue: '$value',
      style: TextStyle(
        color: isDisabled ? Colors.black : const Color.fromARGB(255, 4, 37, 97),
        fontSize: 18,
      ),
      enabled: !isDisabled,
      onChanged: isDisabled ? null : onChanged,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textAlignVertical: TextAlignVertical.top,
    );
  }
}
