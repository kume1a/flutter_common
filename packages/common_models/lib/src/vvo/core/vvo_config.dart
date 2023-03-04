class VVOConfig {
  static _PasswordConfig password = _PasswordConfig();
  static _NameConfig name = _NameConfig();
  static _VerificationCodeConfig verificationCode = _VerificationCodeConfig();
  static _ValueFailureConfig value = _ValueFailureConfig();
  static _SimpleContentConfig simpleContent = _SimpleContentConfig();
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

class _ValueFailureConfig {
  int maxLength = 255;
}

class _SimpleContentConfig {
  int maxLength = 255;
}
