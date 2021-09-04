class EnumToString {
  EnumToString._();

  static bool _isEnum(dynamic enumItem) {
    final List<String> splitEnum = enumItem.toString().split('.');
    return splitEnum.length > 1 && splitEnum[0] == enumItem.runtimeType.toString();
  }

  static String convertToString(dynamic enumItem) {
    assert(enumItem != null);
    assert(_isEnum(enumItem), '$enumItem of type ${enumItem.runtimeType.toString()} is not an enum item');
    return enumItem.toString().split('.')[1];
  }

  static T? fromString<T>(List<T> enumValues, String value) {
    try {
      return enumValues.singleWhere(
        (dynamic enumItem) => EnumToString.convertToString(enumItem).toLowerCase() == value.toLowerCase(),
      );
    } on Exception {
      return null;
    }
  }

  static int indexOf<T>(List<T> enumValues, String value) {
    final T? fromStringResult = fromString<T>(enumValues, value);
    if (fromStringResult == null) {
      return -1;
    } else {
      return enumValues.indexOf(fromStringResult);
    }
  }

  static List<String> toList<T>(List<T> enumValues) {
    final List<String> _enumList = enumValues.map((T t) => EnumToString.convertToString(t)).toList();

    final List<String> output = <String>[];
    for (final String value in _enumList) {
      output.add(value);
    }
    return output;
  }

  static List<T?> fromList<T>(List<T> enumValues, List<String> valueList) {
    return List<T?>.from(valueList.map<T?>((String item) => fromString(enumValues, item)));
  }
}
