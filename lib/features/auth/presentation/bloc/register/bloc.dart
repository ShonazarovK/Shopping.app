import 'package:assigment_4/features/auth/domain/usecase/register_usecase.dart';
import 'package:assigment_4/features/auth/presentation/bloc/register/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_event.dart';

import 'package:bloc/bloc.dart';

class LogInUserBloc extends Bloc<AuthEvent, LogInUserState> {
  final LoginUseCase logInUseCase;

  LogInUserBloc(this.logInUseCase) : super(LogInUserInitial()) {
    on<LoginUser>(onLogInUser);
  }

  Future<void> onLogInUser(event, emit) async {
    emit(LogInUserLoading());
    try {
      final result = await logInUseCase(
        email: event.email,
        password: event.password,
      );
      emit(LogInUserSuccess(user: result));
    } catch (e) {
      emit(LogInUserError(message: e.toString()));
    }
  }
}
