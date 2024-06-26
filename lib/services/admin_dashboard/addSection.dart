// ignore_for_file: file_names, unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalContent_api/addSection_api.dart';
class AddSection extends StatelessWidget {
  final TextEditingController sectionNumberController = TextEditingController();
  final TextEditingController totalUnitsController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const Text(
                'Add A New Section Here',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 4, 37, 97),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: sectionNumberController,
                decoration: const InputDecoration(
                  labelText: 'Section Number',
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 4, 37, 97)),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Section Number is required';
                  }
                  if (!isNumeric(value)) {
                    return 'Enter a valid number for Section Number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: totalUnitsController,
                decoration: const InputDecoration(
                  labelText: 'Total Units',
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 4, 37, 97)),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Total Units is required';
                  }
                  if (!isNumeric(value)) {
                    return 'Enter a valid number for Total Units';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 4, 37, 97)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: subTitleController,
                decoration: const InputDecoration(
                  labelText: 'Sub Title',
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 4, 37, 97)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sub Title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: summaryController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Summary',
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 4, 37, 97)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Summary is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      submitForm(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 4, 37, 97),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                  ),
                  child: const Text('Submit', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitForm(BuildContext context) async {
    if (context != null) {
      await AddSectionApiCall.addSection(
        context,
        sectionNumberController.text,
        totalUnitsController.text,
        titleController.text,
        subTitleController.text,
        summaryController.text,
      );
    }
  }

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
