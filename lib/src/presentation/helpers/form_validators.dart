class FormValidators {
  bool validateEmail(String email) {
    const Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regExp = RegExp(pattern.toString());
    return regExp.hasMatch(email);
  }

  bool validateFieldIsNotEmpty(String input) {
    return input.isNotEmpty;
  }

  bool validatePasswordStrength(String password) {
// Minimum 1 Upper case
// Minimum 1 lowercase
// Minimum 1 Numeric Number
// Minimum 8 characters long

    const Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    final RegExp regExp = RegExp(pattern.toString());
    return regExp.hasMatch(password);
  }

  bool validatePasswordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }
}
