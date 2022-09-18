import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_work/api/api_provider.dart';
import 'package:my_work/components/button_component.dart';
import 'package:my_work/styles/colors.dart';
import 'package:my_work/styles/text_styles.dart';
import 'package:path_provider/path_provider.dart';

class Utils{
  static double getMaxHeight(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return screenSize.height;
  }

  static double getMaxWidth(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return screenSize.width;
  }
}

getFromGallery() async {
  XFile? pickedFile = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 70,
    maxWidth: 1200,
    maxHeight: 1200,
  );
  if (pickedFile != null) {

    final bytes = File(pickedFile.path).readAsBytesSync().lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;
    debugPrint('>>>>>>>>>>>>> $mb');

    File imageFile = File(pickedFile.path);



    return imageFile;
  }
}

bottomSheet(Widget widget){
  Get.bottomSheet(
    widget,
    backgroundColor: Colors.white,
    isDismissible: true,
    enableDrag: true,
    ignoreSafeArea: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.vertical(
        top: Radius.circular(15.0)
      )
    )
  );
}

showLoader(context){
  if(!(Get.isDialogOpen??true)){
    Get.dialog(
      Scaffold(
        body: SizedBox(
          height: Utils.getMaxHeight(context),
          width: Utils.getMaxWidth(context),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpinKitWave(
                  color: AppColors.deepOrange,
                ),
                const SizedBox(height: 10.0,),
                Text('Loading...', style: AppTextStyle.defaultStyle.copyWith(color: AppColors.deepOrange),)
              ],
            ),
          ),
        ),
      )
    );
  }
}

showError(context, {String? error}){
  if(!(Get.isDialogOpen??true)){
    Get.defaultDialog(
      title: 'OPS!',
      middleText: error??'Something went wrong, please try again.',

      actions: [
        ButtonComponent(
          onPressed: (){
            Get.back();
          },
          text: 'Close',
        )
      ]
    );
  }
}

customDialog({context, IconData? iconData, String? text, void Function()? onPressed}){
  if(!(Get.isDialogOpen??true)){
    Get.defaultDialog(
      title: '',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, size: 100, color: AppColors.deepOrange,),

          Text('$text', style: AppTextStyle.defaultStyle, textAlign: TextAlign.center,)
        ],
      ),

      actions: [
        ButtonComponent(
          onPressed: onPressed,
          text: 'Close',
        )
      ]
    );
  }
}