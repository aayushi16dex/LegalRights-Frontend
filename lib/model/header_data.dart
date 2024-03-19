class HeaderData {
  static String id = '';
  static String userRole = '';
  static String firstName = '';
  static String lastName = '';
  static String joinedDate = '';
  static String displayPic = '';
  static String emailId = '';

  String getId() {
    return id;
  }

  String getUserRole() {
    return userRole;
  }

  String getFirstName() {
    return firstName;
  }

  String getLastName() {
    return lastName;
  }

  String getJoinedDate() {
    return joinedDate;
  }

  String getDisplayPic() {
    return displayPic;
  }

  String getEmailId() {
    return emailId;
  }

  static void setProfileData(String userid, String email, String role,
      String fName, String lname, String joinDate, String displayPicture) {
    id = userid;
    emailId = email;
    userRole = role;
    firstName = fName;
    lastName = lname;
    joinedDate = joinDate;
    displayPic = displayPicture;
  }
}
