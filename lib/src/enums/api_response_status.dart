enum ApiResponseStatus {
  success,
  error,
  sessionExpired,
}

extension AsString on ApiResponseStatus?{
  String asString() {
    switch (this){

      case ApiResponseStatus.success:
        return 'Success';
      case ApiResponseStatus.error:
        return 'Error';
      case ApiResponseStatus.sessionExpired:
        return 'SessionExpired';
      case null:
        return 'Error';
    }
  }
}
