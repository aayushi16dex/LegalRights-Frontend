class HeaderData {
  static String id = '';
  static String userRole = '';
  static String firstName = '';
  static String lastName = '';
  static String joinedDate = '';
  static String displayPic = '';

  // To get the value
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

// To get the value

  static void setProfileData(String userid, String role, String fName,
      String lname, String joinDate, String displayPicture) {
    id = userid;
    userRole = role;
    firstName = fName;
    lastName = lname;
    joinedDate = joinDate;
    displayPic = displayPicture;
  }
}
