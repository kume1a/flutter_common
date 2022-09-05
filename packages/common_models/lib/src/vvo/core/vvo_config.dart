class VVOConfig {
  static _PasswordVVOConfig password = _PasswordVVOConfig();
  static _NameVVOConfig name = _NameVVOConfig();
  static _VerificationCodeConfig verificationCode = _VerificationCodeConfig();
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

class _VerificationCodeConfig {
  int length = 4;
}
