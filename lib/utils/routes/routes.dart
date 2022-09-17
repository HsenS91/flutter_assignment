import 'package:get/get.dart';
import 'package:my_work/ui/my_work_page.dart';

class Routes{

  static const String myWorkPage = '/myWorkPage';

  static List<GetPage<dynamic>> routes = [
    GetPage(
      name: myWorkPage,
      page: () => const MyWorkPage(),
    ),
  ];
}