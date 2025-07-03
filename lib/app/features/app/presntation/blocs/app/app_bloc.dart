import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:osm/app/features/app/domain/entities/app.dart';
import 'package:osm/app/features/app/domain/usecases/get_apps_usecase.dart';
import 'package:package_info_plus/package_info_plus.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  GetAppsUsecase getAppsUsecase;
  AppBloc(
    this.getAppsUsecase,
  ) : super(AppInitial()) {
    on<AppEvent>((event, emit) async {
      if (event is GetAppEvent) {
        emit(LoadingGetAppState());
        final packageInfo = await getPackageInfo();
        final String currentVersionCode = packageInfo.buildNumber;
        print(currentVersionCode);
        final either = await getAppsUsecase();
        either.fold((l) {
          if (l.message == "unauthorized") {
            emit(LogInAgainInApp());
          }
          emit(ErrorGetAppState(message: " ErrorMessage.offline"));
        }, (apps) {
          if (apps == null) {
            emit(DoneGetAppState(
              currentVersionName: packageInfo.version,
            ));
            return;
          }

          App latestApp = apps;
          log("latestApp ${apps}");
          log("latestApplatestApp ${latestApp}");
          final currentVersion = int.tryParse(currentVersionCode) ?? 0;

          emit(DoneGetAppState(
            app: latestApp.versionCode! > currentVersion ? latestApp : null,
            currentVersionName: packageInfo.version,
          ));
        });
      }
    });
  }

  Future<PackageInfo> getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }
}
