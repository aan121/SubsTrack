class SignUpModel {
  late String userFirstName,
      userLastName,
      userPhoneNumber,
      userEmail,
      userPassword;

  SignUpModel(this.userFirstName, this.userLastName, this.userPhoneNumber,
      this.userEmail, this.userPassword);

  Map<String, dynamic> toJson() {
    return {
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'userPhoneNumber': userPhoneNumber,
      'userEmail': userEmail,
      'userPassword': userPassword,
    };
  }
}
