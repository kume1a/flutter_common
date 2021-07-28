class VVOConfig {
  static _PasswordVVOConfig passwordVVOConfig = _PasswordVVOConfig();
  static _NameVVOConfig nameVVOConfig = _NameVVOConfig();
}

class _PasswordVVOConfig {
  int minLength = 4;
  bool checkForUppercase = false;
  bool checkForLowercase = false;
  bool checkForDigits = false;
  bool checkForSpecialCharacters = false;
}

class _NameVVOConfig {
  int minLength = 0;
}