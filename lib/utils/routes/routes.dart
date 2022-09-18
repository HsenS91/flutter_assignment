import 'package:get/get.dart';
import 'package:my_work/ui/my_work_page.dart';
import '../../ui/upload_edit_page.dart';

class Routes{

  static const String myWorkPage = '/myWorkPage';
  static const String uploadWorkPage = '/uploadWorkPage';

  static List<GetPage<dynamic>> routes = [
    GetPage(
      name: myWorkPage,
      page: () => const MyWorkPage(),
    ),

    GetPage(
      name: uploadWorkPage,
      page: () => UploadEditPage(),
    ),
  ];
}