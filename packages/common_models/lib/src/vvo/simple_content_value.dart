import '../../common_models.dart';
import '../failure/simple_content_value_failure.dart';

class SimpleContentValueVVO extends ValueObject<SimpleContentValueFailure, String> {
  factory SimpleContentValueVVO(String value) {
    if (value.trim().isEmpty) {
      return SimpleContentValueVVO._(left(const SimpleContentValueFailure.empty()));
    }
    return SimpleContentValueVVO._(right(value));
  }

  factory SimpleContentValueVVO.empty() => SimpleContentValueVVO('');

  SimpleContentValueVVO._(Either<SimpleContentValueFailure, String> value) : super(value);
}
