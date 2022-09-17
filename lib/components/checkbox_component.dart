import 'package:flutter/material.dart';
import 'package:my_work/styles/text_styles.dart';

class CheckboxComponent extends StatelessWidget {
  final String? text;
  final bool? value;
  final void Function(bool?)? onChanged;
  const CheckboxComponent({Key? key, required this.text, required this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: Colors.deepOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          value: value,
          onChanged: onChanged
        ),

        Text('$text', style: AppTextStyle.defaultStyle)
      ],
    );
  }
}
