abstract class Routes {
  static const String splashScreen = '/splash-screen';
  static const String onBoarding = '/on-boarding';
  static const String notification = '/notification';

  ///Auth
  static const String login = '/login';
  static const String welcome = '/welcome';
  static const String register = '/register';

  ///pageViewer
  static const String pageViewer = '/page-viewer';
  static const String addProduct = '/add-product';
  static const String addProductStepTow =
      '${addProduct}/${SubRoutes.addProductStepTow}';

  static const String dashboard = '/dashboard';
  static const String categories = '/categories';
  static const String offers = '/offers';
  static const String addNewOffer = '${offers}/${SubRoutes.addNewOffer}';
  static const String profile = '/profile';
  static const String profileDetails = '${profile}/${SubRoutes.profileDetails}';
  static const String settings = '${profile}/${SubRoutes.settings}';
  static const String myCompanySpecialty =
      '${profile}/${SubRoutes.myCompanySpecialty}';
  static const String addNewBranch = '${myBranches}/${SubRoutes.addNewBranch}';
  //static const String determineBranchLocationMap = '${addNewBranch}/${SubRoutes.determineBranchLocationMap}';
  static const String determineBranchLocationMap =
      '/determineBranchLocationMap';
  static const String myBranches = '${profile}/${SubRoutes.myBranches}';
  static const String editProfile = '${settings}/${SubRoutes.editProfile}';
  static const String changePassword =
      '${settings}/${SubRoutes.changePassword}';
  static const String companyPictures =
      '${settings}/${SubRoutes.companyPictures}';

  ///home
  static const String home = '${login}/home';
  static const String account = '/account';

  static const String subCategories =
      '${categories}/${SubRoutes.subCategories}';
  static const String productsInSubCategory =
      '${subCategories}/${SubRoutes.productsInSubCategory}';

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
  static const String myJourneyDetails =
      '${tripsSection}/${SubRoutes.myJourneyDetails}';
  static const String myDriverProfileDetails =
      '${myJourneyDetails}/${SubRoutes.myDriverProfileDetails}';

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
  static const String subCategories = 'sub-categories';
  static const String addNewOffer = 'add-new-offer';
  static const String addProductStepTow = 'add-product-step-tow';
  static const String determineBranchLocationMap =
      'determine-branchLocation-map';
  static const String productsInSubCategory = 'products-in-subCategory';
  static const String profileDetails = 'profile-details';
  static const String settings = 'settings';
  static const String myCompanySpecialty = 'my-company-specialty';
  static const String addNewBranch = 'add-new-branch';
  static const String myBranches = 'my-branches';
  static const String editProfile = 'edit-profile';
  static const String changePassword = 'change-password';
  static const String companyPictures = 'company-pictures';

  //////////////
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
  static const String determineLocationMap = 'determine-location-map';
  static const String account = 'account';
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
