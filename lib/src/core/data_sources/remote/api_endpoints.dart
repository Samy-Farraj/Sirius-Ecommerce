abstract class ApiEndpoints {
  static const String baseUrl = 'https://csc.taskati.net/api/';

  //---------------------- Account - CLIENT ---------------------------
  static const String show = '${baseUrl}client';
  //---------------------- Account - DRIVER ---------------------------
  static const String showDriver = '${baseUrl}driver';

  //---------------------- CLIENT - JOURNEYS ---------------------------
  static const String scheduled = '${baseUrl}client/journey/history';
  static const String getApps = '${baseUrl}version';
  static const String current = '${baseUrl}client/journey/active';
  static const String saved = '${baseUrl}client/journey/saved';
  static const String getDriverOffersByIdOffer =
      '${baseUrl}client/journey/get-drivers-offers/';
  static const String driverInfoBuDriverId =
      '${baseUrl}client/journey/get-driver/';
  static const String approveJourneysById =
      '${baseUrl}client/journey/approve-driver';
  static const String saveJourneyById = '${baseUrl}client/journey/save/';
  static const String rejectJourneysById =
      '${baseUrl}client/journey/reject-driver';
  static const String getInfoClientJourneyById =
      '${baseUrl}client/journey/current/';
  static const String getTrackPathJourneyById =
      '${baseUrl}client/journey/paths/';
  static const String generateSharingCodeLinkJourneyById =
      '${baseUrl}client/journey/encode/';

  //---------------------- AUTH - CLIENT ---------------------------
  static const String register = '${baseUrl}client/register';
  static const String verifyCode = '${baseUrl}client/validate';
  static const String login = '${baseUrl}client/verify';
  static const String logOutDriver = '${baseUrl}driver/logout';
  static const String logOutClient = '${baseUrl}client/logout';

  static const String changePassword = '${baseUrl}Auth/ChangePassword';
  static const String forgetPassword = '${baseUrl}Auth/ForgetPassword';
  static const String resendCode = 'Auth/ReSendCode';
  static const String nearby = '${baseUrl}client/journey/nearby-drivers';
  static const String estimate = '${baseUrl}client/journey/estimate';
  static const String sameNumberBYJourneyId =
      '${baseUrl}client/journey/same-number/';
  static const String verifyNumberBYJourneyId =
      '${baseUrl}client/journey/verify/';
  static const String validateNumberBYJourneyId =
      '${baseUrl}client/journey/validate/';

  ///////////////////////////
  static const String startJourneyByJourneyId =
      '${baseUrl}client/journey/start/';
  static const String endJourneyByJourneyId = '${baseUrl}client/journey/end/';

//---------------------- DRIVER - JOURNEY ---------------------------
  static const String getAvailableJourney = '${baseUrl}driver/journey';
  static const String updateLocation = '${baseUrl}driver';
  static const String onGoingJourney = '${baseUrl}driver/journey/on-going';
  static const String currentJourneyDriver = '${baseUrl}driver/journey/current';
  static const String iamHereByJourneyId = '${baseUrl}driver/journey/here/';
  static const String endJourneyByJourneyIdBYDriver =
      '${baseUrl}driver/journey/end/';

  static const String acceptJourneyByJourneyId =
      '${baseUrl}driver/journey/make-offer/';
}
