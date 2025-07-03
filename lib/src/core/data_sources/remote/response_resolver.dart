import 'package:dartz/dartz.dart';

import '../../../error/failure.dart';
import '../../../utils/app_notifications.dart';
import 'api_response.dart';

class ResponseResolver {
  ResponseResolver._();

  static Future<Either<Failure, T>> resolve<T>(ApiResponse response) async {
    if (response.hasSucceeded) {
      _showSuccessIfEmpty(response);
      return Right(response.data);
    } else {
      AppNotifications.showError(message: response.error.toString());
      return Left(AuthenticationFailure(response.message.toString()));
    }
  }

  static void _showSuccessIfEmpty(ApiResponse result) {
    AppNotifications.showSuccess(
        message: (result.message == null || result.message!.isEmpty)
            ? 'Success'
            : result.message!);
  }
}
