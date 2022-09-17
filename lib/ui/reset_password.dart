import 'package:flutter/material.dart';
import 'package:my_work/components/button_component.dart';
import 'package:my_work/styles/text_styles.dart';
import 'package:my_work/utils/validations/validations.dart';

import '../components/text_field_component.dart';

class ResetPassword extends StatelessWidget {
  final void Function()? onPressed;
  final GlobalKey<FormState>? globalKey;
  final TextEditingController? newPassController;
  final TextEditingController? confirmNewPassController;
  const ResetPassword({Key? key, this.onPressed, this.globalKey, this.newPassController, this.confirmNewPassController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          start: 30.0, end: 30.0, top: 20.0, bottom: 30.0),
      child: Form(
        key: globalKey,
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
              label: 'New Password',
              validator: Validations.passwordValidator,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              placeHolder: 'Enter password',
              controller: newPassController
            ),

            const SizedBox(height: 15,),

            TextFieldComponent(
              label: 'Confirm Password',
              validator: Validations.passwordValidator,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              placeHolder: 'Enter password',
              controller: newPassController
            ),

            const SizedBox(height: 15,),

            ButtonComponent(
              text: 'Continue',
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}
