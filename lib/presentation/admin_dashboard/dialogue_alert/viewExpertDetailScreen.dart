// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalExpert_api/adminLegalExpertFieldApi.dart';
import 'package:frontend/api_call/legalExpert_api/legalExpertDetailUpdateApi.dart';
import 'package:frontend/dashboard/admin/a_landingPage_screen.dart';
import 'package:frontend/presentation/admin_dashboard/widget/dialogue_alert/view_expertAlertDataWidget.dart';
import 'package:frontend/presentation/child_dashboard/confirmation_alert/LegalExpertDetailChangeConfirmationAlert.dart';

class ViewExpertDetailScreen extends StatefulWidget {
  final String id;
  final String fullName;
  final String email;
  final int yrsExperience;
  final String professionName;
  final String stateName;
  final List<String> languageList;
  final List<String> expertiseList;

  const ViewExpertDetailScreen({
    Key? key,
    required this.id,
    required this.fullName,
    required this.email,
    required this.yrsExperience,
    required this.professionName,
    required this.stateName,
    required this.languageList,
    required this.expertiseList,
  }) : super(key: key);

  @override
  _ViewExpertDetailScreenState createState() => _ViewExpertDetailScreenState();
}

class _ViewExpertDetailScreenState extends State<ViewExpertDetailScreen> {
  bool _isLoading = true;
  bool _isEditMode = false;
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late String _selectedProfession;
  late String _selectedState;
  late int _selectedExperience;
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
    _selectedProfession = widget.professionName;
    _selectedState = widget.stateName;
    _selectedExperience = widget.yrsExperience;
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
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
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
                  if (_isEditMode)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: _selectedExperience.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Experience years',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 4, 37, 97),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedExperience = int.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    )
                  else
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
                            onPressed: () async {
                              ChangeLegalDetailInfoApi
                                  changeLegalDetailInfoApi =
                                  ChangeLegalDetailInfoApi();
                              var response = await changeLegalDetailInfoApi
                                  .changeLegalAccountInfo(
                                context,
                                widget.id,
                                _selectedExperience,
                                _selectedProfession,
                                _selectedState,
                                _selectedLanguages,
                                _selectedExpertises,
                              );
                              if (response == 200) {
                                LegalExpertChangeconfirmation
                                    legalExpertChangeconfirmation =
                                    LegalExpertChangeconfirmation();
                                legalExpertChangeconfirmation
                                    .legalExpertChangeConfirmationAlert(
                                        context);
                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminLandingScreen(
                                                selectLegalExpertScreen: true)),
                                  );
                                });
                              } else if (response == 403) {
                                showErrorConfirmation(
                                    context, 'Access Denied!!!');
                              } else {
                                showErrorConfirmation(
                                    context, "An Error Occured!!!");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(4, 37, 97, 1),
                            ),
                            child: const Text('Update',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isEditMode = false;
                                _selectedProfession = widget.professionName;
                                _selectedState = widget.stateName;
                                _selectedExperience = widget.yrsExperience;
                                _selectedLanguages =
                                    List<String>.from(widget.languageList);
                                _selectedExpertises =
                                    List<String>.from(widget.expertiseList);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (!_isEditMode && !_isLoading)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              setState(() {
                                _isEditMode = true;
                              });
                            },
                            label: const Text(
                              'Edit',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 4, 37, 97),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

void showErrorConfirmation(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 4, 37, 97),
          ),
        ),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 37, 97),
              ),
            ),
          ),
        ],
      );
    },
  );
}
