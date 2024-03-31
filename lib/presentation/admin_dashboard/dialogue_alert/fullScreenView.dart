// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalExpert_api/adminLegalExpertFieldApi.dart';
import 'package:frontend/presentation/admin_dashboard/widget/dialogue_alert/view_expertAlertDataWidget.dart';

class FullScreenView extends StatefulWidget {
  final String fullName;
  final String email;
  final int yrsExperience;
  final String professionName;
  final String stateName;
  final List<String> languageList;
  final List<String> expertiseList;

  const FullScreenView({
    Key? key,
    required this.fullName,
    required this.email,
    required this.yrsExperience,
    required this.professionName,
    required this.stateName,
    required this.languageList,
    required this.expertiseList,
  }) : super(key: key);

  @override
  _FullScreenViewState createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  bool _isLoading = true;
  bool _isEditMode = false;
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _experienceController;
  late String _selectedProfession;
  late String _selectedState;
  late List<String> _selectedLanguages;
  late List<String> _selectedExpertises;

  List<Map<String, dynamic>> professionListField = [];
  List<Map<String, dynamic>> languageListField = [];
  List<Map<String, dynamic>> stateListField = [];
  List<Map<String, dynamic>> expertiseListField = [];

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.fullName);
    _emailController = TextEditingController(text: widget.email);
    _experienceController =
        TextEditingController(text: widget.yrsExperience.toString());
    _selectedProfession = widget.professionName;
    _selectedState = widget.stateName;
    _selectedLanguages = List<String>.from(widget.languageList);
    _selectedExpertises = List<String>.from(widget.expertiseList);
    _fetchData();
  }

  Future<void> _fetchData() async {
    AdminLegalExpertFieldApiCall api = AdminLegalExpertFieldApiCall();
    professionListField = await api.showProfessionList(context);
    languageListField = await api.showLanguageList(context);
    stateListField = await api.showStateList(context);
    expertiseListField = await api.showExpertiseList(context);
    setState(() {
      _isLoading = false;
    });
    //print(expertiseListField);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
        title: Text(
          'Legal Expert: ${widget.fullName}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 4, 37, 97)),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ViewExpertAlertDataWidget.viewExpertAlertDataWidget(
                    'Email',
                    widget.email,
                    true,
                    (value) {},
                  ),
                  if (_isEditMode)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        value: _selectedProfession,
                        decoration: const InputDecoration(
                          labelText: 'Profession',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        items: professionListField.map((profession) {
                          return DropdownMenuItem<String>(
                            value: profession['professionName'],
                            child: Text(
                              profession['professionName'],
                              style: const TextStyle(
                                color: Color.fromARGB(255, 4, 37, 97),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedProfession = newValue!;
                          });
                        },
                      ),
                    )
                  else
                    ViewExpertAlertDataWidget.viewExpertAlertDataWidget(
                      'Profession',
                      widget.professionName,
                      !_isEditMode,
                      (value) {},
                    ),
                  ViewExpertAlertDataWidget.viewExpertAlertDataWidget(
                    'Experience years',
                    widget.yrsExperience.toString(),
                    !_isEditMode,
                    (value) {},
                  ),
                  if (_isEditMode)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        value: _selectedState,
                        decoration: const InputDecoration(
                          labelText: 'State',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        items: stateListField.map((state) {
                          return DropdownMenuItem<String>(
                            value: state['stateName'],
                            child: Text(
                              state['stateName'],
                              style: const TextStyle(
                                color: Color.fromARGB(255, 4, 37, 97),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedState = newValue!;
                          });
                        },
                      ),
                    )
                  else
                    ViewExpertAlertDataWidget.viewExpertAlertDataWidget(
                      'State',
                      widget.stateName,
                      !_isEditMode,
                      (value) {},
                    ),
                  if (_isEditMode)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Languages Known',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: languageListField.map((language) {
                              bool isSelected = _selectedLanguages
                                  .contains(language['languageName']);
                              return FilterChip(
                                label: Text(
                                  language['languageName'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                selected: isSelected,
                                selectedColor:
                                    const Color.fromARGB(255, 4, 37, 97),
                                checkmarkColor: Colors.white,
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (selected) {
                                      _selectedLanguages
                                          .add(language['languageName']);
                                    } else {
                                      _selectedLanguages
                                          .remove(language['languageName']);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    )
                  else
                    ViewExpertAlertDataWidget.viewExpertAlertDataWidget(
                      'Languages Known',
                      widget.languageList.join(", "),
                      !_isEditMode,
                      (value) {},
                    ),
                  if (_isEditMode)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Expertise Area',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: expertiseListField.map((expertise) {
                              bool isSelected = _selectedExpertises
                                  .contains(expertise['expertiseName']);
                              return FilterChip(
                                label: Text(
                                  expertise['expertiseName'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                selected: isSelected,
                                selectedColor:
                                    const Color.fromARGB(255, 4, 37, 97),
                                checkmarkColor: Colors.white,
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (selected) {
                                      _selectedExpertises
                                          .add(expertise['expertiseName']);
                                    } else {
                                      _selectedExpertises
                                          .remove(expertise['expertiseName']);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    )
                  else
                    ViewExpertAlertDataWidget.viewExpertAlertDataWidget(
                      'Expertise Area',
                      widget.expertiseList.join(", "),
                      !_isEditMode,
                      (value) {},
                    ),
                  const SizedBox(height: 20),
                  if (_isEditMode)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 4, 37, 97),
                            ),
                            child: const Text('Update',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isEditMode = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
      floatingActionButton: !_isEditMode && !_isLoading
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 100,
              child: FloatingActionButton.extended(
                onPressed: () {
                  setState(() {
                    _isEditMode = true;
                  });
                },
                label: const Text(
                  'Edit',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                backgroundColor: const Color.fromARGB(255, 4, 37, 97),
                foregroundColor: Colors.white,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
