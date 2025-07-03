abstract class Routes {
  static const String splashScreen = '/splash-screen';
  static const String onBoarding = '/on-boarding';

  ///Auth
  static const String login = '/login';
  static const String register = '/register';

  ///pageViewer
  static const String pageViewer = '/home';

  ///home
  static const String home = '/home';
  static const String account = '/account';

  static const String userProfile = '${account}/${SubRoutes.userProfile}';
  static const String editProfile = '${userProfile}/${SubRoutes.editProfile}';
  static const String aboutUs = '${account}/${SubRoutes.aboutUs}';
  static const String contactUs = '${account}/${SubRoutes.contactUs}';
  static const String manageAccount = '${account}/${SubRoutes.manageAccount}';
  static const String deleteAccount =
      '${manageAccount}/${SubRoutes.deleteAccount}';
  static const String estimatedScreen = '$home/${SubRoutes.estimatedScreen}';
  static const String savedJourneys = '$home/${SubRoutes.savedJourneys}';
  static const String determineLocationMap =
      '$home/${SubRoutes.determineLocationMap}';
  static const String scheduleJourney = '${estimatedScreen}/schedule-journey';
  static const String tripsSection = '/${SubRoutes.tripsSection}';
  static const String currentTripTracking =
      '${tripsSection}/${SubRoutes.currentTripTracking}';
  static const String myJourneyDetails = '${tripsSection}/${SubRoutes.myJourneyDetails}';
  static const String myDriverProfileDetails = '${myJourneyDetails}/${SubRoutes.myDriverProfileDetails}';

  static const String qRScanScreen =
      '${currentTripTracking}/${SubRoutes.qRScanScreen}';

  ///
  static const String chooseLanguage = '/choose-language';
  static const String driverMapScreen = '/driver-map';
  static const String accountDriver =
      '${driverMapScreen}/${SubRoutes.accountDriver}';
  static const String driverProfileFromAccount =
      '${accountDriver}/${SubRoutes.driverProfile}';

  static const String rideRequests =
      '${driverMapScreen}/${SubRoutes.rideRequests}';
  static const String scheduleRequests =
      '${driverMapScreen}/${SubRoutes.scheduleRequests}';
  static const String clientJourneyDetails =
      '${scheduleRequests}/${SubRoutes.clientJourneyDetails}';
  static const String clientOfferDetails =
      '${rideRequests}/${SubRoutes.clientOfferDetails}';

  static const String driverOnGoing = '/driver-on-going';
  static const String ratingCustomerPage =
      '${driverOnGoing}/${SubRoutes.ratingCustomerPage}';
  static const String thankDriverScreen =
      '${ratingCustomerPage}/${SubRoutes.thankDriverScreen}';
  static const String ratingPage =
      '${currentTripTracking}/${SubRoutes.ratingPage}';
  static const String thankScreen = '${ratingPage}/${SubRoutes.thankScreen}';
  static const String verifyNumber = '/verify-number';
  static const String registerStepTwo = '${register}/register-step-two';
}

abstract class SubRoutes {
  static const String accountDriver = 'account';
  static const String ratingPage = 'rating-age';
  static const String ratingCustomerPage = 'rating-customer-page';
  static const String thankDriverScreen = 'thankDriverScreen';
  static const String thankScreen = 'thankScreen';
  static const String driverProfile = 'driverProfile';

  static const String home = 'home';
  static const String myJourneyDetails = 'myJourneyDetails-number';
  static const String myDriverProfileDetails = 'myDriverProfileDetails';
  static const String clientJourneyDetails = 'client-journey-details';
  static const String clientOfferDetails = 'client-offer-details';
  static const String rideRequests = 'ride-requests';
  static const String scheduleRequests = 'schedule-requests';
  static const String editProfile = 'edit-profile';
  static const String determineLocationMap = 'determine-location-map';
  static const String account = 'account';
  static const String userProfile = 'user-profile';
  static const String aboutUs = 'about-us';
  static const String contactUs = 'contact-us';
  static const String manageAccount = 'manage-account';
  static const String deleteAccount = 'delete-account';
  static const String tripsSection = 'trips-section';
  static const String currentTripTracking = 'current-trip-tracking';
  static const String qRScanScreen = 'qr-scan';
  static const String registerStepTwo = 'register-step-two';
  static const String scheduleJourney = 'schedule-journey';
  static const String estimatedScreen = 'estimated-screen';
  static const String savedJourneys = 'savedJ-journeys';
  static const String deliveryAddress = 'delivery-address';
}
