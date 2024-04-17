class VVOConfig {
  static _PasswordConfig password = _PasswordConfig();
  static _NameConfig name = _NameConfig();
  static _VerificationCodeConfig verificationCode = _VerificationCodeConfig();
  static _ValueErrorConfig value = _ValueErrorConfig();
  static _RequiredStringConfig requiredString = _RequiredStringConfig();
}

class _PasswordConfig {
  int minLength = 4;
  int maxLength = 255;
  bool checkForUppercase = false;
  bool checkForLowercase = false;
  bool checkForDigits = false;
  bool checkForSpecialCharacters = false;
}

class _NameConfig {
  int minLength = 0;
  int maxLength = 255;
}

class _VerificationCodeConfig {
  int length = 4;
}

class _ValueErrorConfig {
  int maxLength = 255;
}

class _RequiredStringConfig {
  int maxLength = 255;
}
