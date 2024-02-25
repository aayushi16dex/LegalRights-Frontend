class HeaderData {
  static String firstName = '';
  static String lastName = '';
  static String joinedDate = '';
  static String displayPic = '';

  // To get the value
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

  static void setProfileData(
      String fName, String lname, String joinDate, String displayPicture) {
    firstName = fName;
    lastName = lname;
    joinedDate = joinDate;
    displayPic = displayPicture;
  }
}
