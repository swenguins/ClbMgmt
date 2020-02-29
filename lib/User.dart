///JK: This is a simple user object that could be used for basic login testing
///prior to Firebase implementation. Furthermore, this can be modified/changed
///if field requirements change (which they most likely will). ** This file is
///only utilized in the profile_page.dart file so far.

class User {
  String email;
  String password;
  String firstName;
  String lastName;
  int age;
  String shortProfileDescription;

  User(String email, String password,
      String firstName, String lastName, int age,
      String shortProfileDescription) {

    this.email = email;
    this.password = password;
    this.firstName = firstName;
    this.lastName = lastName;
    this.age = age;
    this.shortProfileDescription = shortProfileDescription;

  }

  String getEmail() {
    return this.email;
  }

  void setEmail(String email) {
    this.email = email;
  }

  String getPassword() {
    return this.password;
  }

  void setPassword(String password) {
    this.password = password;
  }

  String getFirstName() {
    return this.firstName;
  }

  void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  String getLastName() {
    return this.lastName;
  }

  void setLastName(String lastName) {
    this.lastName = lastName;
  }

  int getAge() {
    return this.age;
  }

  void setAge(int age) {
    this.age = age;
  }

  String getShortProfileDescription() {
    return this.shortProfileDescription;
  }

  void setShortProfileDescription(String shortProfileDescription) {
    this.shortProfileDescription = shortProfileDescription;
  }
}