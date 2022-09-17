import 'package:flutter/material.dart';

class IconButtonComponent extends StatelessWidget {
  final void Function()? onTap;
  final IconData? iconData;
  const IconButtonComponent({Key? key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.all(5.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Colors.deepOrangeAccent, Colors.orange.withOpacity(0.5)]),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0, 2),
              blurRadius: 10.0,
              spreadRadius: 0
            )
          ]
        ),
        child: Center(
          child: Icon(iconData, color: Colors.white,),
        ),
      ),
    );
  }
}
