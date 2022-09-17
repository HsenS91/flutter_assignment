import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:my_work/bloc/login_bloc/login_bloc.dart';
import 'package:my_work/components/checkbox_component.dart';
import 'package:my_work/components/gesture_detector_component.dart';
import 'package:my_work/components/text_field_component.dart';
import 'package:my_work/styles/text_styles.dart';
import 'package:my_work/ui/forgot_password.dart';
import 'package:my_work/ui/reset_password.dart';
import 'package:my_work/utils/routes/routes.dart';
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


class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passNode = FocusNode();

  final GlobalKey<FormState> _forgotPassKey = GlobalKey<FormState>();
  final TextEditingController _forgotPassController = TextEditingController();

  final GlobalKey<FormState> _resetPassKey = GlobalKey<FormState>();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  BehaviorSubject<bool> rememberMe$ = BehaviorSubject<bool>();

  @override
  Widget build(BuildContext context) {
    return GestureDetectorComponent(
      child: Scaffold(
        body: Container(
          height: Utils.getMaxHeight(context),
          width: Utils.getMaxWidth(context),
          padding: const EdgeInsetsDirectional.only(start: 30.0, end: 30.0, top: 180),
          child: SingleChildScrollView(
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
                  TextFieldComponent(
                    textInputAction: TextInputAction.done,
                    focusNode: _passNode,
                    label: 'Password',
                    placeHolder: 'Enter password',
                    controller: _passwordController,
                    validator: Validations.passwordValidator,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    hideText: true,
                    keyboardType: TextInputType.visiblePassword,
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
                            onChanged: (value){
                              rememberMe$.add(value??false);
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
          ),
        ),
      ),
    );
  }


  widgetState(context, state){
    if(state is LoginLoading){
      showLoader(context);
    }
    else{

      if(Get.isDialogOpen??false){
        Get.back();
      }

      if(state is LoginSuccess){
        Get.offNamed(Routes.myWorkPage);
      }
      else if(state is ForgotPassSuccess){

        customDialog(
          context: context,
          iconData :Icons.mail,
          text :'An email has been sent!',
          onPressed: (){
            Get.back();
            bottomSheet(
            ResetPassword(
              globalKey: _resetPassKey,
              newPassController: _newPassController,
              confirmNewPassController: _confirmPassController,
              onPressed: (){

              }
            ));
          }
        );
      }
      else if(state is ResetPassSuccess){

      }
      else if(state is LoginError){
        showError(context);
      }
    }
  }
}
