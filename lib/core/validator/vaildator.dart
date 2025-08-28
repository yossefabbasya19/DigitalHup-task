class Validator {
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return "please enter email";
    }
    bool result = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
    if (result == false) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return "plaese enter password";
    }
    if (password.length < 8) {
      return "please enter more or equel 8 character or number";
    }
    return null;
  }
}
