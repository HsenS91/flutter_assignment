import 'package:flutter/material.dart';
import 'package:my_work/styles/colors.dart';

import '../utils/utils.dart';

class ButtonComponent extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final Color? color;
  const ButtonComponent({Key? key, required this.text, this.onPressed, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: Utils.getMaxWidth(context),
      height: 45.0,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: color??AppColors.deepOrange,
      child: Text(text??'', style: const TextStyle(color: Colors.white),),
    );
  }
}
