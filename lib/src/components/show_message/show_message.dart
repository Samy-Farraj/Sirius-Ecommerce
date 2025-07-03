import '../../core/data_sources/remote/api_response.dart';
import '../../utils/app_notifications.dart';

void showErrorMessage(ApiResponse response) {
  String errorMessage = 'Error happened';

  if (response.error != null) {
    if (response.error is Map<String, dynamic>) {
      if (response.error!.containsKey('error_messages')) {
        List<dynamic> errorMessages = response.error!['error_messages'];
        if (errorMessages.isNotEmpty) {
          errorMessage = errorMessages.join(', '); // تجميع الرسائل في نص واحد
        }
      } else if (response.error!.containsKey('message')) {
        errorMessage = response.error!['message'];
      }
    }
  }

  // إذا لم يتم العثور على رسالة خطأ في `error`، استخدم `response.message`
  if (errorMessage == 'Error happened' && response.message != null) {
    errorMessage = response.message!;
  }

  AppNotifications.showError(message: errorMessage);
}

void showSuccessMessage(ApiResponse response) {
  AppNotifications.showSuccess(
    message: (response.message == null || response.message!.isEmpty)
        ? 'Success'
        : response.message!,
  );
}
