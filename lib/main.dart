import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_work/ui/login_page.dart';
import 'package:my_work/utils/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Task App',
      builder: (context, child) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        return ScrollConfiguration(
          behavior: DisableScrollGlow(),
          child: child!,
        );
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white
        )
      ),
      getPages: Routes.routes,
      home: const LoginPage()
    );
  }
}

class DisableScrollGlow extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const ClampingScrollPhysics();

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}