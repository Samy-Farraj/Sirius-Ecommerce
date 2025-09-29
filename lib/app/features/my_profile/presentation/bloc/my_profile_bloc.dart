import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sirius/app/features/auth/domain/entities/app_user.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../domain/usecases/edit_profile_use_case.dart';
import '../../domain/usecases/get_profile_info_use_case.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  GetProfileInfoUseCase getProfileInfoUseCase;
  EditProfileUseCase editProfileUseCase;

  MyProfileBloc(
      {required this.getProfileInfoUseCase, required this.editProfileUseCase})
      : super(CategoriesInitial()) {
    on<GetProfileInfoEvent>(_onGetProfileInfoEvent);
    on<EditProfileEvent>(_onEditProfileEvent);
  }

  Future<void> _onEditProfileEvent(
    EditProfileEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(LoadingEditProfileState());
    final result = await editProfileUseCase.call(event.parameters);
    result.fold(
      (failure) {
        emit(ErrorEditProfileState(message: failure.message));
      },
      (_) {
        emit(DoneEditProfileState());
      },
    );
  }

  Future<void> _onGetProfileInfoEvent(
    GetProfileInfoEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(LoadingProfileDetailsState());
    final result = await getProfileInfoUseCase.call(NoParameters());
    result.fold(
      (failure) {
        emit(ErrorProfileDetailsState(message: failure.message));
      },
      (user) {
        emit(DoneProfileDetailsState(user));
      },
    );
  }
}
