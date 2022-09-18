import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:my_work/bloc/login_bloc/login_bloc.dart';
import 'package:my_work/components/button_component.dart';
import 'package:my_work/components/text_field_component.dart';
import 'package:my_work/styles/text_styles.dart';
import 'package:my_work/utils/utils.dart';

import '../utils/validations/validations.dart';


class ForgotPassword extends StatelessWidget {
  final void Function()? onPressed;
  final GlobalKey<FormState>? globalKey;
  final TextEditingController? controller;
  const ForgotPassword({Key? key, this.onPressed, this.controller, this.globalKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          start: 30.0, end: 30.0, top: 20.0, bottom: 30.0),
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

          Text('Forgot Password', style: AppTextStyle.title,),

          const SizedBox(height: 20,),

          Form(
            key: globalKey,
            child: TextFieldComponent(
                label: 'Email',
                validator: Validations.emailValidator,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                placeHolder: 'Enter email',
                controller: controller
            ),
          ),

          const SizedBox(height: 15,),

          ButtonComponent(
            text: 'Continue',
            onPressed: onPressed,
          )
        ],
      ),
    );
  }

}
