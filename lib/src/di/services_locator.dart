import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirius/app/features/branches/data/datasources/branches_datasource.dart';
import 'package:sirius/app/features/branches/domain/repositories/branch_repository.dart';
import 'package:sirius/app/features/categories/data/datasources/categories_remote_datasource.dart';
import 'package:sirius/app/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:sirius/app/features/categories/domain/usecases/get_all_categories_use_case.dart';
import 'package:sirius/app/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:sirius/app/features/color/data/datasources/color_remote_datasource.dart';
import 'package:sirius/app/features/color/domain/usecases/get_all_color_use_case.dart';
import 'package:sirius/app/features/color/presentation/bloc/color_bloc.dart';
import 'package:sirius/app/features/dashboard/data/datasources/dash_board_datasource.dart';
import 'package:sirius/app/features/filters/presentation/bloc/filters_bloc.dart';
import 'package:sirius/app/features/my_profile/data/datasources/my_profile_remote_datasource.dart';
import 'package:sirius/app/features/my_profile/data/repositories/my_profile_repository_impl.dart';
import 'package:sirius/app/features/my_profile/domain/repositories/my_profile_repository.dart';
import 'package:sirius/app/features/product/domain/repositories/product_repository.dart';
import 'package:sirius/app/features/size/data/datasources/size_remote_datasource.dart';
import 'package:sirius/app/features/size/data/repositories/size_repository_impl.dart';
import 'package:sirius/app/features/size/domain/usecases/get_all_sizes_use_case.dart';
import 'package:sirius/app/features/size/presentation/bloc/color_bloc.dart';
import '../../app/features/auth/data/datasources/auth_datasource.dart';
import '../../app/features/auth/data/repositories/auth_repository.dart';
import '../../app/features/auth/domain/repositories/base_auth_repository.dart';
import '../../app/features/auth/domain/usecases/log_out_usecase.dart';
import '../../app/features/auth/domain/usecases/login_usecase.dart';
import '../../app/features/auth/presentation/bloc/auth_bloc.dart';
import '../../app/features/branches/data/repositories/branch_repository_impl.dart';
import '../../app/features/branches/domain/usecases/delete_branch_use_case.dart';
import '../../app/features/branches/domain/usecases/store_new_branch_use_case.dart';
import '../../app/features/branches/domain/usecases/update_branch_use_case.dart';
import '../../app/features/branches/presentation/bloc/branches_bloc.dart';
import '../../app/features/categories/domain/repositories/categories_repository.dart';
import '../../app/features/city/data/datasources/city_datasource.dart';
import '../../app/features/city/data/repositories/city_repository_impl.dart';
import '../../app/features/city/domain/repositories/city_repository.dart';
import '../../app/features/city/domain/usecases/get_all_cities_use_case.dart';
import '../../app/features/city/presentation/bloc/city_bloc.dart';
import '../../app/features/color/data/repositories/color_repository_impl.dart';
import '../../app/features/color/domain/repositories/color_repository.dart';
import '../../app/features/dashboard/data/repositories/dash_board_repository_impl.dart';
import '../../app/features/dashboard/domain/repositories/dash_board_repository.dart';
import '../../app/features/dashboard/domain/usecases/get_all_statistics_use_case.dart';
import '../../app/features/dashboard/presentation/bloc/dash_board_bloc.dart';
import '../../app/features/filters/data/datasources/filters_remote_datasource.dart';
import '../../app/features/filters/data/repositories/filters_repository_impl.dart';
import '../../app/features/filters/domain/repositories/filters_repository.dart';
import '../../app/features/filters/domain/usecases/get_filter_value_use_case.dart';
import '../../app/features/my_profile/domain/usecases/edit_profile_use_case.dart';
import '../../app/features/my_profile/domain/usecases/get_profile_info_use_case.dart';
import '../../app/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import '../../app/features/offers/data/datasources/offers_remote_datasource.dart';
import '../../app/features/offers/data/repositories/offers_repository_impl.dart';
import '../../app/features/offers/domain/repositories/offers_repository.dart';
import '../../app/features/offers/domain/usecases/delete_offer_by_id_use_case.dart';
import '../../app/features/offers/domain/usecases/get_all_offers_use_case.dart';
import '../../app/features/offers/domain/usecases/store_new_offer_use_case.dart';
import '../../app/features/offers/presentation/bloc/offers_bloc.dart';
import '../../app/features/product/data/datasources/product_remote_datasource.dart';
import '../../app/features/product/data/repositories/product_repository_impl.dart';
import '../../app/features/product/domain/usecases/create_new_product_use_case.dart';
import '../../app/features/product/domain/usecases/delete_product_use_case.dart';
import '../../app/features/product/domain/usecases/edit_product_use_case.dart';
import '../../app/features/product/domain/usecases/get_products_use_case.dart';
import '../../app/features/product/domain/usecases/show_product_details_by_id_use_case.dart';
import '../../app/features/product/presentation/bloc/prodcut_bloc.dart';
import '../../app/features/size/domain/repositories/size_repository.dart';
import '../../firebase_options.dart';
import '../core/data_sources/local/local_storage.dart';
import '../core/data_sources/remote/helpers/dio_helper.dart';
import '../core/data_sources/remote/helpers/interceptor.dart';
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
    sl.registerFactory(() => AuthBloc(sl<LoginUseCase>(), sl<LogOutUseCase>()));

    sl.registerFactory(() => CategoriesBloc(
          sl<GetAllCategoriesUseCase>(),
        ));

    sl.registerFactory(() => MyProfileBloc(
          getProfileInfoUseCase: sl<GetProfileInfoUseCase>(),
          editProfileUseCase: sl<EditProfileUseCase>(),
        ));

    sl.registerFactory(() => CityBloc(
          getAllCitiesUseCase: sl<GetAllCitiesUseCase>(),
        ));
    sl.registerFactory(() => BranchesBloc(
          storeNewBranchUseCase: sl<StoreNewBranchUseCase>(),
          updateBranchUseCase: sl<UpdateBranchUseCase>(),
          deleteBranchUseCase: sl<DeleteBranchUseCase>(),
        ));

    sl.registerFactory(() => ProductBloc(
        showProductDetailsByIdUseCase: sl<ShowProductDetailsByIdUseCase>(),
        getProductsUseCase: sl<GetProductsUseCase>(),
        createNewProductUseCase: sl<CreateNewProductUseCase>(),
        deleteProductUseCase: sl<DeleteProductUseCase>(),
        editProductUseCase: sl<EditProductUseCase>()));

    sl.registerFactory(() => OffersBloc(
          getAllOffersUseCase: sl<GetAllOffersUseCase>(),
          deleteOfferByIdUseCase: sl<DeleteOfferByIdUseCase>(),
          storeNewOfferUseCase: sl<StoreNewOfferUseCase>(),
        ));

    sl.registerFactory(() => DashBoardBloc(
          getAllStatisticsUseCase: sl<GetAllStatisticsUseCase>(),
        ));

    sl.registerFactory(() => SizeBloc(
          sl<GetAllSizesUseCase>(),
        ));
    sl.registerFactory(() => ColorBloc(
          sl<GetAllColorsUseCase>(),
        ));

    sl.registerFactory(() => FiltersBloc(
          getFilterValueUseCase: sl<GetFilterValueUseCase>(),
        ));
  }

  static _injectRepositories() {
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));
    sl.registerLazySingleton<BaseCategoriesRepository>(
        () => CategoriesRepositoryImpl(sl()));
    sl.registerLazySingleton<BaseMyProfileRepository>(
        () => MyProfileRepositoryImpl(sl()));

    sl.registerLazySingleton<BranchesRepository>(
        () => BranchesRepositoryImpl(sl()));

    sl.registerLazySingleton<CityRepository>(() => CityRepositoryImpl(sl()));
    sl.registerLazySingleton<OffersRepository>(
        () => OffersRepositoryImpl(sl()));

    sl.registerLazySingleton<BaseProductRepository>(
        () => ProductRepositoryImpl(sl()));
    sl.registerLazySingleton<BaseFiltersRepository>(
        () => FiltersRepositoryImpl(sl()));
    sl.registerLazySingleton<DashBoardRepository>(
        () => DashBoardRepositoryImpl(sl()));
    sl.registerLazySingleton<BaseSizeRepository>(
        () => SizeRepositoryImpl(sl()));

    sl.registerLazySingleton<BaseColorRepository>(
        () => ColorRepositoryImpl(sl()));
  }

  static _injectDataSources() async {
    final dio = _injectDio();
    final dioHelper = DioHelper(dio);
    sl.registerFactory<BaseAuthDataSource>(
        () => AuthDataSource(dioHelper: dioHelper));
    sl.registerFactory<BaseCategoriesDataSource>(
        () => CategoriesDataSource(dioHelper: dioHelper));
    sl.registerFactory<BaseMyProfileDataSource>(
        () => MyProfileDataSource(dioHelper: dioHelper));
    sl.registerFactory<BranchesDataSource>(
        () => BranchesDataSourceImpl(dioHelper: dioHelper));
    sl.registerFactory<DashBoardDataSource>(
        () => DashBoardDataSourceImpl(dioHelper: dioHelper));

    sl.registerFactory<CityDataSource>(
        () => CityDataSourceImpl(dioHelper: dioHelper));

    sl.registerFactory<OffersDataSource>(
        () => OffersDataSourceImpl(dioHelper: dioHelper));

    sl.registerFactory<BaseProductDataSource>(
        () => ProductDatasource(dioHelper: dioHelper));
    sl.registerFactory<BaseFiltersDataSource>(
        () => FiltersDataSource(dioHelper: dioHelper));

    sl.registerFactory<BaseSizeDataSource>(
        () => SizeDataSource(dioHelper: dioHelper));
    sl.registerFactory<BaseColorsDataSource>(
        () => ColorsDataSource(dioHelper: dioHelper));
  }

  static _injectUseCases() {
    sl.registerLazySingleton(() => LoginUseCase(sl()));
    sl.registerLazySingleton(() => LogOutUseCase(sl()));
    /////---- PROFILE------////
    sl.registerLazySingleton(() => EditProfileUseCase(sl()));
    sl.registerLazySingleton(() => GetProfileInfoUseCase(sl()));
    /////---- CATEGORIES------////
    sl.registerLazySingleton(() => GetAllCategoriesUseCase(sl()));
    /////---- PRODUCT------////
    sl.registerLazySingleton(() => GetProductsUseCase(sl()));
    sl.registerLazySingleton(() => DeleteProductUseCase(sl()));
    sl.registerLazySingleton(() => ShowProductDetailsByIdUseCase(sl()));
    sl.registerLazySingleton(() => GetFilterValueUseCase(sl()));
    sl.registerLazySingleton(() => EditProductUseCase(sl()));
    sl.registerLazySingleton(() => CreateNewProductUseCase(sl()));

    /////---- BRANCHES------////
    sl.registerLazySingleton(() => DeleteBranchUseCase(sl()));
    sl.registerLazySingleton(() => UpdateBranchUseCase(sl()));
    sl.registerLazySingleton(() => StoreNewBranchUseCase(sl()));
    /////---- CITY------////

    sl.registerLazySingleton(() => GetAllCitiesUseCase(sl()));

    /////---- OFFERS------////
    sl.registerLazySingleton(() => GetAllOffersUseCase(sl()));

    sl.registerLazySingleton(() => StoreNewOfferUseCase(sl()));

    sl.registerLazySingleton(() => DeleteOfferByIdUseCase(sl()));

    /////---- DASHBOARD------////

    sl.registerLazySingleton(() => GetAllStatisticsUseCase(sl()));
    sl.registerLazySingleton(() => GetAllSizesUseCase(sl()));
    sl.registerLazySingleton(() => GetAllColorsUseCase(sl()));
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

  static _injectNetworkingDependencies() {}
}
