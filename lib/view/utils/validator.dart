String? validatePassword(String? value) {
  if (value!.isEmpty) {
    return 'Field cannot be Empty';
  } else if (value.length < 8) {
    return "Password must be above 8 characters";
  }
  return null;
}

String? confirmPassword(String? value, String confirmPass) {
  if (value != confirmPass) {
    return 'Not Equal';
  }
  return null;
}

String? validateEmail(String? value) {
  const String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  final RegExp regex = RegExp(pattern);
  if (value!.length < 6) {
    return "Email Field cannot be Empty";
  } else if (value.isEmpty) {
    return 'Email Field cannot be Empty';
  } else if (!regex.hasMatch(value)) {
    return 'Invalid Email Address';
  } else {
    return null;
  }
}

String? validateGeneric(String? value) {
  if (value!.isEmpty) {
    return 'Field cannot be Empty';
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value!.isEmpty) {
    return 'Field cannot be Empty';
  } else if (value.length < 11) {
    return 'Phone Number is too short';
  }
  return null;
}

String? validateFirstPassword(String? value) {
  if (value!.isEmpty) {
    return 'Field cannot be Empty';
  } else if (value.length < 8) {
    return "Password must be above 8 characters";
  } else if (!value.contains(RegExp(r"[A-Z]"))) {
    return 'Must have 1 Uppercase Letter';
  } else if (!value.contains(RegExp(r"[a-z]"))) {
    return 'Must have 1 Lowercase Letter';
  } else if (!value.contains(RegExp(r"[0-9]"))) {
    return 'Must have 1 Number';
  } else if (!value.contains(RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+='
      "'"
      ']'))) {
    return 'Must have 1 Special Character';
  }
  return null;
}

bool isStrongPassword(String password) {
  // Check for at least 1 uppercase letter
  final hasUppercaseLetter = RegExp(r"[A-Z]").hasMatch(password);

  // Check for at least 1 lowercase letter
  final hasLowercaseLetter = RegExp(r"[a-z]").hasMatch(password);

  // Check for at least 1 special character
  final hasSymbol = RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+='
          "'"
          ']')
      .hasMatch(password);

  // Check for a minimum length of 8 characters
  final isMinimumLength = password.length >= 8;

  // Combine all conditions
  return hasUppercaseLetter &&
      hasLowercaseLetter &&
      hasSymbol &&
      isMinimumLength;
}
