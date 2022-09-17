import 'package:flutter/material.dart';

class GestureDetectorComponent extends StatelessWidget {
  final Widget? child;
  const GestureDetectorComponent({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );
  }
}
