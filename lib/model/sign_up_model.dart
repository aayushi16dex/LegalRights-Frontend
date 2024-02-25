class SignUpModel {
  String firstName;
  String lastName;
  String password;
  String email;
  String gender;
  DateTime dob;
  int? roleID;
  String? profession;
  String? qualification;

  SignUpModel(
      {required this.firstName,
      required this.lastName,
      required this.password,
      required this.email,
      required this.gender,
      required this.dob,
      this.roleID,
      this.profession,
      this.qualification});
}
