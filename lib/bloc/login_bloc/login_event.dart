part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class OnLogin extends LoginEvent{
  final Map<String, dynamic> loginData;
  const OnLogin(this.loginData);
  @override
  List<Object?> get props => [];
}

class OnForgotPassword extends LoginEvent{
  final Map<String, dynamic> data;
  const OnForgotPassword(this.data);
  @override
  List<Object?> get props => [];
}

class OnResetPassword extends LoginEvent{
  final Map<String, dynamic> data;
  const OnResetPassword(this.data);
  @override
  List<Object?> get props => [];
}