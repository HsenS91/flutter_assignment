part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class ForgotPassSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class ResetPassSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginError extends LoginState {
  final String? errorMessage;
  const LoginError(this.errorMessage);
  @override
  List<Object> get props => [];
}