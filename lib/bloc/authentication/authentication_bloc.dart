import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRepository _repository;
  AuthBloc(this._repository) : super(AuthInitialState()) {
    on<AuthLoginRequest>((event, emit) async {
      emit(AuthLoadingState());
      var response =
          await _repository.loginUser(event.username, event.password);
      emit(AuthResponseState(response));
    });
  }
}
