extension FormValidatorExtension on String? {
  bool isValidEmail() {
    if (this == null) return false;
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this!);
  }

  bool isValidPassword() {
    if (this == null) return false;
    return RegExp('(?=.*[0-9a-zA-Z]).{6,}').hasMatch(this!);
  }
}
