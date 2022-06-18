// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:phononxchallenge/core/constants.dart';
import 'package:phononxchallenge/domain/models/user.dart';
import 'package:phononxchallenge/domain/usecases/get_user.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {

  final GetUserUseCase? _getUserUseCase;

  UsersBloc(this._getUserUseCase) : super(InitialState()) {
    on<GetUserEvent>((event, emit) async {
      emit(LoadingState());
      try {
        var response = await _getUserUseCase?.execute(event.user);
        response?.fold((error) {
          emit(ErrorState(error));
        }, (r) {
          emit(SuccessfulState(r));
        });
      } catch (e) {
        emit(const ErrorState(UNKNOW_ERROR));
      }
    });
  }
}
