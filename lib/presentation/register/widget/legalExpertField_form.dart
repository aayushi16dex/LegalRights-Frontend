import 'package:flutter/material.dart';
import 'package:frontend/api_call/dropdown_api/expertiseDropdown_apiCall.dart';
import 'package:frontend/api_call/dropdown_api/languageDropdown_apiCall.dart';
import 'package:frontend/api_call/dropdown_api/professionDropdown_apiCall.dart';
import 'package:frontend/api_call/dropdown_api/stateDropdown_apiCall.dart';
import 'package:frontend/model/signup_controller.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ExpertFormFieldWidget extends StatefulWidget {
  final SignupFieldController expertSignupController;

  const ExpertFormFieldWidget({Key? key, required this.expertSignupController})
      : super(key: key);
  @override
  _ExpertFormFieldWidget createState() => _ExpertFormFieldWidget();
}

class _ExpertFormFieldWidget extends State<ExpertFormFieldWidget> {
  List<Map<String, dynamic>> professions = [];
  List<Map<String, dynamic>> states = [];
  List<Map<String, dynamic>> languages = [];
  List<Map<String, dynamic>> expertises = [];

  List<Map<String, dynamic>> selectedExpertiseItems = [];
  List<Map<String, dynamic>> selectedLanguageItems = [];
  Map<String, dynamic>? selectedProfession;
  Map<String, dynamic>? selectedState;

  @override
  void initState() {
    // Fetch languages
    showLanguageList(context);

    // Fetch professions
    showProfessionList(context);

    // Fetch states
    showStateList(context);

    // Fetch expertise
    showExpertiseList(context);

    super.initState();
  }

  // Fetch profession list
  Future<void> showProfessionList(BuildContext context) async {
    try {
      final List<dynamic> fetchedProfessions =
          await ProfessionDropDownApi.fetchProfessionData(context);
      setState(() {
        professions = fetchedProfessions.map((item) {
          return {
            'id': item['_id'] ?? '',
            'professionName': item['professionName'] ?? '',
          };
        }).toList();
      });
    } catch (e) {
      print('Error fetching profession: $e');
    }
  }

  // Fetch language list
  Future<void> showLanguageList(BuildContext context) async {
    try {
      final List<dynamic> fetchedLanguages =
          await LanguageDropDownApi.fetchLanguageData(context);
      setState(() {
        languages = fetchedLanguages.map((item) {
          return {
            'id': item['_id'] ?? '',
            'languageName': item['languageName'] ?? '',
          };
        }).toList();
      });
    } catch (e) {
      print('Error fetching language Name: $e');
    }
  }

  // Fetch state list
  Future<void> showStateList(BuildContext context) async {
    try {
      final List<dynamic> fetchedStates =
          await StateDropDownApi.fetchStateData(context);
      setState(() {
        states = fetchedStates.map((item) {
          return {
            'id': item['_id'] ?? '',
            'stateName': item['name'] ?? '',
          };
        }).toList();
      });
    } catch (e) {
      print('Error fetching state: $e');
    }
  }

  // Fetch profession list
  Future<void> showExpertiseList(BuildContext context) async {
    try {
      final List<dynamic> fetchedExpertise =
          await ExpertiseDropDownApi.fetchExpertiseData(context);
      setState(() {
        expertises = fetchedExpertise.map((item) {
          return {
            'id': item['_id'] ?? '',
            'expertiseName': item['expertiseField'] ?? '',
          };
        }).toList();
      });
    } catch (e) {
      print('Error fetching expertise: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    SignupFieldController expertSignupController =
        widget.expertSignupController;
    Map<String, dynamic>? selectedProfession;

    return Expanded(
      child: Column(
        children: [
          TextFormField(
            controller: expertSignupController.yearsOfExperience,
            decoration: const InputDecoration(
                labelText: 'Years of Experience',
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16.0),
          DropdownButtonFormField<Map<String, dynamic>>(
            value: selectedProfession,
            onChanged: (Map<String, dynamic>? newValue) {
              setState(() {
                selectedProfession = newValue;
                expertSignupController.professionController.text =
                    newValue?['id'] ?? '';
              });
            },
            items: [
              // Add a default label that cannot be selected
              const DropdownMenuItem<Map<String, dynamic>>(
                value:
                    null, // Set the value to null or any other value that won't match any item
                child: Text('Select a profession'),
              ),
              ...professions.map<DropdownMenuItem<Map<String, dynamic>>>(
                (item) => DropdownMenuItem<Map<String, dynamic>>(
                  value: item,
                  child: Text(item['professionName'] ?? ''),
                ),
              )
            ],
            decoration: const InputDecoration(
              labelText: 'Profession',
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16.0),
          MultiSelectDialogField<Map<String, dynamic>>(
            buttonText: const Text(
              'Expertise Area',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: const Text('Select Expertise field'),
            items: expertises
                .map(
                  (item) => MultiSelectItem<Map<String, dynamic>>(
                    item,
                    item['expertiseName'] ?? '',
                  ),
                )
                .toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              setState(() {
                selectedExpertiseItems = values;
                List<dynamic> selectedExpertiseIds = selectedExpertiseItems
                    .map((languages) => languages['id']!)
                    .toList();
                expertSignupController.expertiseController.text =
                    selectedExpertiseIds.join(', ');
              });
            },
          ),
          const SizedBox(height: 16.0),
          MultiSelectDialogField<Map<String, dynamic>>(
            buttonText: const Text(
              'Languages Known',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: const Text('Select languages'),
            items: languages
                .map(
                  (item) => MultiSelectItem<Map<String, dynamic>>(
                    item,
                    item['languageName'] ?? '',
                  ),
                )
                .toList(),
            listType: MultiSelectListType.LIST,
            onConfirm: (values) {
              setState(() {
                selectedLanguageItems = values;
                List<dynamic> selectedLanguageIds = selectedLanguageItems
                    .map((languages) => languages['id']!)
                    .toList();
                expertSignupController.languageController.text =
                    selectedLanguageIds.join(', ');
              });
            },
          ),
          const SizedBox(height: 16.0),
          DropdownButtonFormField<Map<String, dynamic>>(
            value: selectedState,
            onChanged: (Map<String, dynamic>? newValue) {
              setState(() {
                selectedState = newValue;
                expertSignupController.stateController.text =
                    newValue?['id'] ?? '';
              });
            },
            items: [
              // Add a default label that cannot be selected
              const DropdownMenuItem<Map<String, dynamic>>(
                value:
                    null, // Set the value to null or any other value that won't match any item
                child: Text('Select a state'),
              ),
              ...states.map<DropdownMenuItem<Map<String, dynamic>>>(
                (item) => DropdownMenuItem<Map<String, dynamic>>(
                  value: item,
                  child: Text(item['stateName'] ?? ''),
                ),
              )
            ],
            decoration: const InputDecoration(
              labelText: 'State',
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
