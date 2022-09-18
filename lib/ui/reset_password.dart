import 'package:flutter/material.dart';
import 'package:my_work/components/button_component.dart';
import 'package:my_work/styles/text_styles.dart';
import 'package:my_work/utils/validations/validations.dart';
import 'package:rxdart/rxdart.dart';

import '../components/text_field_component.dart';

class ResetPassword extends StatelessWidget {
  final void Function()? onPressed;
  final GlobalKey<FormState>? globalKey;
  final TextEditingController? tokenController;
  final TextEditingController? newPassController;
  final TextEditingController? confirmNewPassController;

  ResetPassword({Key? key, this.onPressed, this.globalKey, this.tokenController, this.newPassController, this.confirmNewPassController}) : super(key: key);

  final BehaviorSubject<bool> showNewPassword$ = BehaviorSubject<bool>();
  final BehaviorSubject<bool> showConfirmPassword$ = BehaviorSubject<bool>();
  final FocusNode _passNode = FocusNode();
  final FocusNode _confirmPassNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          start: 30.0, end: 30.0, top: 20.0, bottom: 30.0),
      child: Form(
        key: globalKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 80,
                child: Divider(
                  thickness: 1.5,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 20,),

              Text('Reset Password', style: AppTextStyle.title,),

              const SizedBox(height: 20,),

              TextFieldComponent(
                label: 'Token',
                validator: Validations.defaultValidator,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                placeHolder: 'Enter token',
                textInputAction: TextInputAction.next,
                controller: tokenController,
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_passNode),
              ),

              const SizedBox(height: 15,),

              StreamBuilder<bool>(
                initialData: false,
                stream: showNewPassword$,
                builder: (context, snapshot) {
                  return TextFieldComponent(
                    focusNode: _passNode,
                    label: 'New Password',
                    validator: Validations.passwordValidator,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    placeHolder: 'Enter password',
                    textInputAction: TextInputAction.next,
                    controller: newPassController,
                    hideText: !(snapshot.data??true),
                    suffixIcon: IconButton(
                      onPressed: (){
                        bool value = snapshot.data??false;
                        showNewPassword$.add(!value);
                      },
                      icon: (snapshot.data??false) ? const Icon(Icons.visibility_off,) : const Icon(Icons.visibility),
                      color: Colors.grey.withOpacity(0.5),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_confirmPassNode),
                  );
                }
              ),

              const SizedBox(height: 15,),

              StreamBuilder<bool>(
                initialData: false,
                stream: showConfirmPassword$,
                builder: (context, snapshot) {
                  return TextFieldComponent(
                    focusNode: _confirmPassNode,
                    label: 'Confirm Password',
                    validator: (value) => MatchValidator(errorText: 'Passwords do not match').validateMatch(newPassController?.text??'0', value??'1'),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    placeHolder: 'Enter password',
                    controller: confirmNewPassController,
                    textInputAction: TextInputAction.done,
                    hideText: !(snapshot.data??true),
                    suffixIcon: IconButton(
                      onPressed: (){
                        bool value = snapshot.data??false;
                        showConfirmPassword$.add(!value);
                      },
                      icon: (snapshot.data??false) ? const Icon(Icons.visibility_off,) : const Icon(Icons.visibility),
                      color: Colors.grey.withOpacity(0.5),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  );
                }
              ),

              const SizedBox(height: 15,),

              ButtonComponent(
                text: 'Continue',
                onPressed: onPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}
