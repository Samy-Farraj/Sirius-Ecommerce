import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius/app/features/branches/presentation/bloc/branches_bloc.dart';
import 'package:sirius/app/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:sirius/app/features/categories/presentation/pages/category_details_screen.dart';
import 'package:sirius/app/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:sirius/app/features/my_profile/presentation/pages/my_branches_pages/add_new_branch_screen.dart';
import 'package:sirius/app/features/my_profile/presentation/pages/my_settings_pages/edit_profile_screen.dart';
import 'package:sirius/app/features/my_profile/presentation/pages/profile_pages/my_branches_screen.dart';
import 'package:sirius/app/features/notifications/presentation/pages/notification_screen.dart';
import 'package:sirius/app/features/offers/presentation/bloc/offers_bloc.dart';
import 'package:sirius/app/features/offers/presentation/pages/add_offer_screen.dart';
import 'package:sirius/app/features/product/presentation/bloc/prodcut_bloc.dart';
import 'package:sirius/app/features/product/presentation/pages/add_product_screen.dart';
import 'package:sirius/app/features/product/presentation/pages/add_product_step_tow_screen.dart'
    as s;
import 'package:sirius/app/features/splash_screen/presentation/pages/home_screen.dart';
import 'package:sirius/app/features/splash_screen/presentation/pages/welcome_screen.dart';
import '../../app/features/auth/presentation/pages/login_screen.dart';
import '../../app/features/branches/domain/entities/branch.dart';
import '../../app/features/categories/domain/entities/category.dart';
import '../../app/features/categories/presentation/pages/categories_screen.dart';
import '../../app/features/categories/presentation/pages/products_in_category_screen.dart';
import '../../app/features/dashboard/presentation/pages/dashboard_screen.dart';
import '../../app/features/my_profile/presentation/pages/my_settings_pages/company_pictures_screen.dart';
import '../../app/features/my_profile/presentation/pages/my_settings_pages/change_password_screen.dart';
import '../../app/features/my_profile/presentation/pages/my_branches_pages/determine_location_branch_map.dart';
import '../../app/features/my_profile/presentation/pages/profile_pages/my_company_specialty.dart';
import '../../app/features/my_profile/presentation/pages/my_profile_pages/my_profile_details_screen.dart';
import '../../app/features/my_profile/presentation/pages/profile_pages/my_profile_screen.dart';
import '../../app/features/my_profile/presentation/pages/profile_pages/settings_screen.dart';
import '../../app/features/offers/presentation/pages/offers_screen.dart';
import '../../app/features/product/data/models/NewProductParameter.dart'
    as newProd;
import '../../app/features/product/presentation/pages/add_product_step_tow_screen.dart';
import '../../app/features/splash_screen/presentation/pages/onboarding_screen.dart';
import '../../app/features/splash_screen/presentation/pages/spalsh_screen.dart';
import '../layout/presntation/page_viewer.dart';
import 'custom_navigation_observer.dart';
import 'fallback_screen.dart';
import 'routes.dart';

class AppRouter {
  final GoRouter goRouter;

  static late AppRouter _appRouter;

  static init() {
    _appRouter = AppRouter();
  }

  AppRouter() : goRouter = _getRouter;

  static get getRouter => _appRouter.goRouter;

  static final _rootKey = GlobalKey<NavigatorState>();

  // static final _shellKey = GlobalKey<NavigatorState>();

  static get _getRouter => GoRouter(
        navigatorKey: _rootKey,
        initialLocation: Routes.splashScreen,
        observers: [BotToastNavigatorObserver(), CustomNavigationObserver()],
        errorBuilder: (context, state) => const FallbackScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: Routes.onBoarding,
            builder: (BuildContext context, GoRouterState state) {
              return OnboardingScreen();
            },
          ),
          GoRoute(
              path: Routes.addProduct,
              builder: (BuildContext context, GoRouterState state) {
                String categoryId =
                    (state.extra as Map<String, dynamic>)['categoryId'];
                ProductBloc oldBloc =
                    (state.extra as Map<String, dynamic>)['oldBloc'];
                List<Category> categoriesChildren =
                    (state.extra as Map<String, dynamic>)['categoriesChildren'];
                bool isEdit = (state.extra as Map<String, dynamic>)['isEdit'];
                if (isEdit == true) {
                  newProd.NewProductParameter productToEdit =
                      (state.extra as Map<String, dynamic>)['productToEdit'];
                  return AddProductScreen(
                    categoryId: categoryId,
                    categoriesChildren: categoriesChildren,
                    oldBloc: oldBloc,
                    isEdit: isEdit,
                    productToEdit: productToEdit,
                  );
                } else {
                  return AddProductScreen(
                    categoryId: categoryId,
                    categoriesChildren: categoriesChildren,
                    oldBloc: oldBloc,
                    isEdit: false,
                  );
                }
              },
              routes: [
                GoRoute(
                  path: SubRoutes.addProductStepTow,
                  builder: (BuildContext context, GoRouterState state) {
                    String description =
                        (state.extra as Map<String, dynamic>)['description'];
                    String name = (state.extra as Map<String, dynamic>)['name'];
                    ProductBloc bloc =
                        (state.extra as Map<String, dynamic>)['bloc'];
                    String gender =
                        (state.extra as Map<String, dynamic>)['gender'];
                    String isOnSale =
                        (state.extra as Map<String, dynamic>)['isOnSale'];
                    String isReplaceable =
                        (state.extra as Map<String, dynamic>)['isReplaceable'];
                    String isRefundable =
                        (state.extra as Map<String, dynamic>)['isRefundable'];
                    String points =
                        (state.extra as Map<String, dynamic>)['points'];
                    String categories =
                        (state.extra as Map<String, dynamic>)['categories'];
                    String productPrice =
                        (state.extra as Map<String, dynamic>)['productPrice'];
                    String categoryChildId = (state.extra
                        as Map<String, dynamic>)['categoryChildId'];
                    List<File> productImages =
                        (state.extra as Map<String, dynamic>)['productImages'];

                    bool isEdit =
                        (state.extra as Map<String, dynamic>)['isEdit'];
                    if (isEdit == true) {
                      newProd.NewProductParameter productToEdit = (state.extra
                          as Map<String, dynamic>)['productToEdit'];
                      return AddProductStepTowScreen(
                        name: name,
                        description: description,
                        gender: gender,
                        isOnSale: isOnSale,
                        isReplaceable: isReplaceable,
                        isRefundable: isRefundable,
                        points: points,
                        categories: categories,
                        productPrice: productPrice,
                        productImages: productImages,
                        bloc: bloc,
                        categoryChildId: categoryChildId,
                        isEdit: isEdit,
                        productToEdit: productToEdit,
                      );
                    } else {
                      return AddProductStepTowScreen(
                        name: name,
                        description: description,
                        gender: gender,
                        isOnSale: isOnSale,
                        isReplaceable: isReplaceable,
                        isRefundable: isRefundable,
                        points: points,
                        categories: categories,
                        productPrice: productPrice,
                        productImages: productImages,
                        bloc: bloc,
                        categoryChildId: categoryChildId,
                        isEdit: false,
                      );
                    }
                  },
                ),
              ]),
          GoRoute(
            path: Routes.notification,
            builder: (BuildContext context, GoRouterState state) {
              return NotificationScreen();
            },
          ),
          GoRoute(
            path: Routes.splashScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const SplashScreen();
            },
          ),
          GoRoute(
              path: Routes.login,
              builder: (BuildContext context, GoRouterState state) {
                return const LoginScreen();
              },
              routes: [
                GoRoute(
                  path: SubRoutes.home,
                  builder: (BuildContext context, GoRouterState state) {
                    return const HomeScreen();
                  },
                ),
              ]),
          GoRoute(
            path: Routes.welcome,
            builder: (BuildContext context, GoRouterState state) {
              return const WelcomeScreen();
            },
          ),
          GoRoute(
            path: Routes.determineBranchLocationMap,
            builder: (BuildContext context, GoRouterState state) {
              BranchesBloc bloc = (state.extra as Map<String, dynamic>)['bloc'];
              return DetermineLocationMap(bloc);
            },
          ),
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return PageViewer(navigationShell);
            },
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                      path: Routes.dashboard,
                      builder: (BuildContext context, GoRouterState state) {
                        return DashboardScreen();
                      },
                      routes: []),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                      path: Routes.offers,
                      builder: (BuildContext context, GoRouterState state) {
                        return OffersScreen();
                      },
                      routes: [
                        GoRoute(
                            path: SubRoutes.addNewOffer,
                            builder:
                                (BuildContext context, GoRouterState state) {
                              OffersBloc bloc =
                                  (state.extra as Map<String, dynamic>)['bloc'];
                              ProductBloc productBloc = (state.extra
                                  as Map<String, dynamic>)['productBloc'];
                              List<String> selectedProductIds = (state.extra
                                  as Map<String, dynamic>)['productId'];

                              return AddOfferScreen(
                                bloc: bloc,
                                productId: selectedProductIds,
                                productBloc: productBloc,
                              );
                            },
                            routes: []),
                      ]),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                      path: Routes.categories,
                      builder: (BuildContext context, GoRouterState state) {
                        return CategoriesScreen();
                      },
                      routes: [
                        GoRoute(
                            path: SubRoutes.subCategories,
                            builder:
                                (BuildContext context, GoRouterState state) {
                              Category category = (state.extra
                                  as Map<String, dynamic>)['category'];
                              CategoriesBloc bloc =
                                  (state.extra as Map<String, dynamic>)['bloc'];
                              return CategoryDetailsScreen(
                                  category: category, bloc: bloc);
                            },
                            routes: [
                              GoRoute(
                                path: SubRoutes.productsInSubCategory,
                                builder: (BuildContext context,
                                    GoRouterState state) {
                                  String categoryId = (state.extra
                                      as Map<String, dynamic>)['categoryId'];
                                  CategoriesBloc bloc = (state.extra
                                      as Map<String, dynamic>)['bloc'];
                                  List<Category> categoriesChildren =
                                      (state.extra as Map<String, dynamic>)[
                                          'categoriesChildren'];

                                  return ProductsInCategoryScreen(
                                    bloc: bloc,
                                    categoryId: categoryId,
                                    categoriesChildren: categoriesChildren,
                                  );
                                },
                              ),
                            ]),
                      ]),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                      path: Routes.profile,
                      builder: (BuildContext context, GoRouterState state) {
                        return MyProfileScreen();
                      },
                      routes: [
                        GoRoute(
                          path: SubRoutes.profileDetails,
                          builder: (BuildContext context, GoRouterState state) {
                            return MyProfileDetailsScreen();
                          },
                        ),
                        GoRoute(
                            path: SubRoutes.myBranches,
                            builder:
                                (BuildContext context, GoRouterState state) {
                              return MyBranchesScreen();
                            },
                            routes: [
                              GoRoute(
                                  path: SubRoutes.addNewBranch,
                                  builder: (BuildContext context,
                                      GoRouterState state) {
                                    String branchId = (state.extra
                                        as Map<String, dynamic>)['branchId'];
                                    MyProfileBloc profileBloc = (state.extra
                                        as Map<String, dynamic>)['profileBloc'];
                                    if ((state.extra as Map<String, dynamic>)[
                                            'isEdit'] as bool ==
                                        true) {
                                      Branch branch = (state.extra
                                          as Map<String, dynamic>)['branch'];
                                      return AddNewBranchScreen(
                                        companyId: branchId,
                                        profileBloc: profileBloc,
                                        isEdit: true,
                                        branch: branch,
                                      );
                                    }

                                    return AddNewBranchScreen(
                                      companyId: branchId,
                                      profileBloc: profileBloc,
                                      isEdit: false,
                                    );
                                  },
                                  routes: []),
                            ]),
                        GoRoute(
                          path: SubRoutes.myCompanySpecialty,
                          builder: (BuildContext context, GoRouterState state) {
                            return MyCompanySpecialty();
                          },
                        ),
                        GoRoute(
                            path: SubRoutes.settings,
                            builder:
                                (BuildContext context, GoRouterState state) {
                              return SettingsScreen();
                            },
                            routes: [
                              GoRoute(
                                path: SubRoutes.editProfile,
                                builder: (BuildContext context,
                                    GoRouterState state) {
                                  return EditProfileScreen();
                                },
                              ),
                              GoRoute(
                                path: SubRoutes.changePassword,
                                builder: (BuildContext context,
                                    GoRouterState state) {
                                  return ChangePasswordScreen();
                                },
                              ),
                              GoRoute(
                                path: SubRoutes.companyPictures,
                                builder: (BuildContext context,
                                    GoRouterState state) {
                                  return CompanyPicturesScreen();
                                },
                              ),
                            ]),
                      ]),
                ],
              ),
            ],
          ),
        ],
      );
}
