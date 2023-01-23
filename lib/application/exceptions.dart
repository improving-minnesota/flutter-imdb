class BaseException implements Exception {

  const BaseException(this.message);

  final String message;

  @override
  String toString() => message;
}

class ApiKeyMissingException extends BaseException {
  const ApiKeyMissingException(super.message);
}

class ImdbApiException extends BaseException {
  const ImdbApiException(super.message);
}
