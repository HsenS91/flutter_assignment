import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_work/bloc/login_bloc/login_bloc.dart';
import 'package:my_work/components/checkbox_component.dart';
import 'package:my_work/components/gesture_detector_component.dart';
import 'package:my_work/components/icon_button_component.dart';
import 'package:my_work/components/text_field_component.dart';
import 'package:my_work/model/login_model/login_model.dart';
import 'package:my_work/styles/colors.dart';
import 'package:my_work/styles/text_styles.dart';
import 'package:my_work/ui/forgot_password.dart';
import 'package:my_work/ui/reset_password.dart';
import 'package:my_work/utils/routes/routes.dart';
import 'package:my_work/utils/shared_prefs/shared_prefs.dart';
import 'package:my_work/utils/utils.dart';
import 'package:my_work/utils/validations/validations.dart';
import 'package:rxdart/rxdart.dart';
import '../components/button_component.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: LoginView(),
    );
  }
}


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passNode = FocusNode();
  final GlobalKey<FormState> _forgotPassKey = GlobalKey<FormState>();
  final TextEditingController _forgotPassController = TextEditingController();
  final GlobalKey<FormState> _resetPassKey = GlobalKey<FormState>();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  BehaviorSubject<bool> showPassword$ = BehaviorSubject<bool>();
  BehaviorSubject<bool> rememberMe$ = BehaviorSubject<bool>();

  late Future<String?> future;

  @override
  void initState() {
    super.initState();

    future = SharedPrefs().getData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetectorComponent(
      child: Scaffold(
        body: Container(
          height: Utils.getMaxHeight(context),
          width: Utils.getMaxWidth(context),
          padding: const EdgeInsetsDirectional.only(start: 30.0, end: 30.0, top: 180),
          child: FutureBuilder<String?>(
            initialData: null,
            future: future,
            builder: (context, snapshot) {
              if(snapshot.data != null && (snapshot.data?.isNotEmpty??false)){
                LoginModel login = LoginModel.fromJson(jsonDecode(snapshot.data??''));
                rememberMe$.add(login.rememberMe??false);
                _emailController.text = login.email??'';
                _passwordController.text = login.password??'';
              }
              return snapshot.data == null ?
              const Center(
                child: SpinKitWave(
                  color: AppColors.deepOrange,
                ),
              )
                  :
              SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Login', style: AppTextStyle.title,),
                      const SizedBox(height: 20,),
                      TextFieldComponent(
                        label: 'Email',
                        placeHolder: 'Enter email',
                        controller: _emailController,
                        validator: Validations.emailValidator,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_passNode),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20,),
                      StreamBuilder<bool>(
                          initialData: false,
                          stream: showPassword$,
                          builder: (context, snapshot) {
                            return TextFieldComponent(
                              textInputAction: TextInputAction.done,
                              focusNode: _passNode,
                              label: 'Password',
                              placeHolder: 'Enter password',
                              controller: _passwordController,
                              validator: Validations.passwordValidator,
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                              hideText: !(snapshot.data??true),
                              keyboardType: TextInputType.visiblePassword,
                              suffixIcon: IconButton(
                                onPressed: (){
                                  bool value = snapshot.data??false;
                                  showPassword$.add(!value);
                                },
                                icon: (snapshot.data??false) ? const Icon(Icons.visibility_off,) : const Icon(Icons.visibility),
                                color: Colors.grey.withOpacity(0.5),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                            );
                          }
                      ),
                      Row(
                        children: [
                          StreamBuilder<bool>(
                              stream: rememberMe$,
                              initialData: false,
                              builder: (context, snapshot) {
                                return CheckboxComponent(
                                  text: 'Remember me',
                                  value: snapshot.data,
                                  onChanged: (value) async {
                                    rememberMe$.add(value??false);
                                    await SharedPrefs().setRememberMe(value??false);

                                  },
                                );
                              }
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () => bottomSheet(ForgotPassword(
                                  globalKey: _forgotPassKey,
                                  controller: _forgotPassController,
                                  onPressed: () => validateForgotPass(context, _forgotPassKey, _forgotPassController)
                              )),
                              child: Text('Forgot password?', style: AppTextStyle.defaultStyle,)),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      BlocListener<LoginBloc, LoginState>(
                        listener: widgetState,
                        child: ButtonComponent(
                          onPressed: () => validateLogin(context, _key, _emailController, _passwordController),
                          text: 'Login',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        )
      ),
    );
  }

  widgetState(context, state) async {
    if(state is LoginLoading){
      showLoader(context);
    }
    else{

      if(Get.isDialogOpen??false){
        Get.back();
      }

      if(state is LoginSuccess){
        if(SharedPrefs.REMEMBER_ME != null && (SharedPrefs.REMEMBER_ME??false)){
          LoginModel login = LoginModel(
            rememberMe: SharedPrefs.REMEMBER_ME,
            portalId: 2,
            email: _emailController.text,
            password: _passwordController.text,
          );

          await SharedPrefs().saveData(jsonEncode(login));
        }
        else{
          await SharedPrefs().clearAll();
        }

        Get.offNamed(Routes.myWorkPage);
      }
      else if(state is ForgotPassSuccess){
        _forgotPassKey.currentState?.reset();
        customDialog(
          context: context,
          iconData :Icons.mail,
          text :'An email has been sent! Please copy the token from the url after pressing the reset button in your email received.',
          onPressed: (){
            Get.back();
            bottomSheet(
              ResetPassword(
                globalKey: _resetPassKey,
                newPassController: _newPassController,
                confirmNewPassController: _confirmPassController,
                tokenController: _tokenController,
                onPressed: () => validateResetPass(context, _resetPassKey, _newPassController, _confirmPassController, _tokenController)
              ));
          }
        );
      }
      else if(state is ResetPassSuccess){
        _resetPassKey.currentState?.reset();
        customDialog(
          context: context,
          iconData :Icons.lock_open,
          text :'Password changed!',
          onPressed: (){
            Get.back();
          }
        );
      }
      else if(state is LoginError){
        _forgotPassKey.currentState?.reset();
        _resetPassKey.currentState?.reset();
        showError(context,error: state.errorMessage);
      }
    }
  }
}
