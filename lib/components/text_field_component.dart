import 'package:flutter/material.dart';
import 'package:my_work/styles/text_styles.dart';

class TextFieldComponent extends StatelessWidget {
  final Widget? icon;
  final bool? hasPadding;
  final String? label;
  final String? placeHolder;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final bool? hideText;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  const TextFieldComponent({Key? key, this.icon, this.hasPadding, this.label, required this.placeHolder, required this.controller, this.validator, this.autoValidateMode, this.hideText = false, this.keyboardType, this.focusNode, this.onFieldSubmitted, this.textInputAction, this.suffixIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(label != null)
          Text(label??'', style: AppTextStyle.label,),

        const SizedBox(height: 15,),

        TextFormField(
          controller: controller,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          focusNode: focusNode,
          keyboardType: keyboardType,
          obscureText: hideText??false,
          cursorColor: Colors.black,
          validator: validator,
          autovalidateMode: autoValidateMode,
          decoration: InputDecoration(
            contentPadding: (hasPadding??false) ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0) : null,
            prefixIcon: icon,
            suffixIcon: suffixIcon,
            suffixIconColor: Colors.grey.withOpacity(0.5),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: placeHolder,
            labelStyle: AppTextStyle.placeHolder,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.redAccent)
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.redAccent)
            ),
          ),
        ),
      ],
    );
  }
}
