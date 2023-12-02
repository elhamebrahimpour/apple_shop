part of 'authentication_bloc.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

//loading state uses when user clicks on the login button
//and waits to authenticate from the server
class AuthLoadingState extends AuthState {}

//this state uses to know the response of our request
//is the user authenticated or not
class AuthResponseState extends AuthState {
  Either<String, String> response;
  AuthResponseState(this.response);
}
