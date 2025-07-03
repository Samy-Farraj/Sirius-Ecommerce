
import 'package:osm/app/features/auth/domain/usecases/log_out_usecase.dart';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/features/app/data/remote_datasources/app_remote_datasource.dart';
import '../../app/features/app/data/repositories_impl/app_repository_impl.dart';
import '../../app/features/app/domain/repositories/app_repository.dart';
import '../../app/features/app/domain/usecases/get_apps_usecase.dart';
import '../../app/features/app/presntation/blocs/app/app_bloc.dart';
import '../../app/features/auth/data/datasources/auth_datasource.dart';
import '../../app/features/auth/data/repositories/auth_repository.dart';
import '../../app/features/auth/domain/repositories/base_auth_repository.dart';

import '../../app/features/auth/domain/usecases/login_usecase.dart';
import '../../app/features/auth/domain/usecases/register_usecase.dart';
import '../../app/features/auth/domain/usecases/resend_code_usecase.dart';
import '../../app/features/auth/domain/usecases/verify_code_usecase.dart';
import '../../app/features/auth/presentation/bloc/auth_bloc.dart';

import '../../firebase_options.dart';
import '../core/data_sources/local/hive/hive_initializer.dart';
import '../core/data_sources/local/local_storage.dart';
import '../core/data_sources/remote/helpers/dio_helper.dart';
import '../core/data_sources/remote/helpers/interceptor.dart';

import '../utils/dotenv_keys.dart';
import 'package:firebase_core/firebase_core.dart';

final sl = GetIt.instance;

class ServicesLocator {
  static setup() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await _setupLocalStorage();
    _injectHive();
    _injectNetworkingDependencies();
    _injectBlocProviders();
    _injectUseCases();
    _injectRepositories();
    _injectDataSources();
  }

  static _injectHive() async {}

  static _injectBlocProviders() {
    sl.registerFactory(() => AuthBloc(
          sl<LogOutUseCase>(),
          sl<LoginUseCase>(),
          sl<RegisterUseCase>(),
          sl<ResendCodeUseCase>(),
          sl<VerifyCodeUseCase>(),
        ));
    sl.registerFactory(() => AppBloc(
          sl<GetAppsUsecase>(),
        ));

  }

  static _injectRepositories() {
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));
    sl.registerLazySingleton<AppRepository>(
        () => AppRepositoryImpl(dataSource: sl()));

  }

  static _injectDataSources() async {
    final dio = _injectDio();
    // final box = await sl.getAsync<Box<LocalCart>>();
    final dioHelper = DioHelper(dio); // تمرير Dio إلى DioHelper


    sl.registerFactory<AppRemoteDatasource>(
        () => AppRemoteDatasource(dioHelper: dioHelper));

    sl.registerFactory<BaseAuthDataSource>(
        () => AuthDataSource(dioHelper: dioHelper));



  }

  static _injectUseCases() {
    //

    sl.registerLazySingleton(() => GetAppsUsecase(
          appRepository: sl(),
        ));


    sl.registerLazySingleton(() => LoginUseCase(sl()));

    sl.registerLazySingleton(() => LogOutUseCase(sl()));
    sl.registerLazySingleton(() => RegisterUseCase(sl()));
    sl.registerLazySingleton(() => ResendCodeUseCase(sl()));
    sl.registerLazySingleton(() => VerifyCodeUseCase(sl()));


    ////////////Driver Journey//////////////



////////////////////////////
  }

  static Future _setupLocalStorage() async {
    final pref = await SharedPreferences.getInstance();
    sl.registerSingleton<LocalStorage>(LocalStorage(pref));
  }

  static Dio _injectDio() {
    Dio dio = Dio();
    dio.interceptors.clear();
    dio.interceptors.add(RemoteInterceptor(sl.get<LocalStorage>()));
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 50,
    ));
    sl.registerSingleton<Dio>(dio);
    return dio;
  }

  //
  // static _injectApiServices(Dio dio, String baseUrl) {
  //   sl.registerLazySingleton<CarLicenseServices>(() =>
  //       CarLicenseServices(dio, baseUrl: dotenv.get(DotenvKeys.azureResource)));
  //   sl.registerLazySingleton<HomeServices>(
  //       () => HomeServices(dio, baseUrl: baseUrl));
  //   sl.registerLazySingleton<OffersServices>(
  //       () => OffersServices(dio, baseUrl: baseUrl));
  //   sl.registerLazySingleton<MyWalletServices>(
  //       () => MyWalletServices(dio, baseUrl: baseUrl));
  //   sl.registerLazySingleton<MyProfileServices>(
  //       () => MyProfileServices(dio, baseUrl: baseUrl));
  //   sl.registerLazySingleton<MyCarsServices>(
  //       () => MyCarsServices(dio, baseUrl: baseUrl));
  //   sl.registerLazySingleton<CarDetailsServices>(
  //     () => CarDetailsServices(dio, baseUrl: baseUrl),
  //   );
  //
  //   sl.registerLazySingleton<MyAddressServices>(
  //     () => MyAddressServices(dio, baseUrl: baseUrl),
  //   );
  //   sl.registerLazySingleton<MyOrdersServices>(
  //     () => MyOrdersServices(dio, baseUrl: baseUrl),
  //   );
  //   sl.registerLazySingleton<AuthServices>(
  //     () => AuthServices(dio, baseUrl: baseUrl),
  //   );
  //
  //   sl.registerLazySingleton<HomeDeliveryAddressServices>(
  //       () => HomeDeliveryAddressServices(dio, baseUrl: baseUrl));
  //   sl.registerLazySingleton<CategoryServices>(
  //       () => CategoryServices(dio, baseUrl: baseUrl));
  //
  //   sl.registerLazySingleton<ProdcutDetailsServices>(
  //     () => ProdcutDetailsServices(dio, baseUrl: baseUrl),
  //   );
  //
  //   sl.registerLazySingleton<CheckoutServices>(
  //     () => CheckoutServices(dio, baseUrl: baseUrl),
  //   );
  //
  //   sl.registerLazySingleton<BookAppointmentServices>(
  //     () => BookAppointmentServices(dio, baseUrl: baseUrl),
  //   );
  //
  //   sl.registerLazySingleton<DistanceMatrixServices>(
  //     () => DistanceMatrixServices(dio,
  //         baseUrl: 'https://maps.googleapis.com/maps/api/'),
  //   );
  //
  //   sl.registerLazySingleton<OrderSummaryServices>(
  //     () => OrderSummaryServices(dio, baseUrl: baseUrl),
  //   );
  //
  //   sl.registerLazySingleton<OrderDetailsServices>(
  //     () => OrderDetailsServices(dio, baseUrl: baseUrl),
  //   );
  //
  //   sl.registerLazySingleton<MainCategoryServices>(
  //     () => MainCategoryServices(dio, baseUrl: baseUrl),
  //   );
  // }

  static _injectNetworkingDependencies() {
    // final dio = _injectDio();
    // final baseUrl = dotenv.get(DotenvKeys.baseUrl);
    // //   _injectApiServices(dio, baseUrl);
  }
}
