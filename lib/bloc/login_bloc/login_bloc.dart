import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:my_work/api/api_provider.dart';
import 'package:my_work/model/base_response/base_response.dart';
import 'package:my_work/model/login_model/login_model.dart';
import 'package:my_work/model/login_model/login_response.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    ApiProvider api = ApiProvider();
    on<LoginEvent>((event, emit) async {
      try{
        if(event is OnLogin){
          emit(LoginLoading());
          LoginResponse response = await api.getClient().login(event.loginData);
          if(response.success??false){
            emit(LoginSuccess());
          }
          else{
            emit(LoginError(response.message));
          }
        }

        else if(event is OnForgotPassword){
          emit(LoginLoading());
          BaseResponse response = await api.getClient().resetPasswordForm(event.data);
          if(response.success??false){
            emit(ForgotPassSuccess());
          }
          else{
            emit(LoginError(response.message));
          }
        }

        else if(event is OnResetPassword){
          emit(LoginLoading());
          BaseResponse response = await api.getClient().resetPassword(event.data);
          if(response.success??false){
            emit(ResetPassSuccess());
          }
          else{
            emit(LoginError(response.message));
          }
        }
      }
      catch(error){
        emit(const LoginError('Something went wrong, please try again.'));
      }
    });
  }
}

validateLogin(BuildContext context ,GlobalKey<FormState> key, TextEditingController emailController, TextEditingController passwordController){

  FocusScope.of(context).requestFocus(FocusNode());

  if(!(key.currentState?.validate()??true)){
    return;
  }

  LoginModel loginModel = LoginModel(
      portalId: 2,
      email: emailController.text,
      password: passwordController.text
  );

  onLogin(context, loginModel);
}

onLogin(BuildContext context, LoginModel loginModel){
  BlocProvider.of<LoginBloc>(context).add(OnLogin(loginModel.toJson()));
}

validateForgotPass(BuildContext context ,GlobalKey<FormState> key, TextEditingController emailController){
  if(!(key.currentState?.validate()??true)){
    return;
  }
  Get.back();
  Map<String, dynamic> data = {}..putIfAbsent('email', () => emailController.text);
  BlocProvider.of<LoginBloc>(context).add(OnForgotPassword(data));
}

validateResetPass(BuildContext context ,GlobalKey<FormState> key, TextEditingController newController, TextEditingController confirmController, TextEditingController token){
  if(!(key.currentState?.validate()??true)) {
    return;
  }
  Get.back();

  Map<String, dynamic> data = {}..putIfAbsent('password', () => newController.text)
    ..putIfAbsent('password_confirmation', () => confirmController.text)
      ..putIfAbsent('token', () => token.text);
  BlocProvider.of<LoginBloc>(context).add(OnResetPassword(data));
}