import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_work/components/text_field_component.dart';
import 'package:my_work/styles/colors.dart';
import 'package:my_work/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.4,
        leadingWidth: 0.0,
        title: InkWell(onTap: () => Get.back(), child: Row(
          children: const [
            Icon(Icons.chevron_left, size: 30, color: AppColors.deepOrange,),
            Text('Upload', style: TextStyle(color: Colors.deepOrange),),
          ],
        )),
      ),

      body: Padding(
        padding: const EdgeInsetsDirectional.only(start: 30.0, end: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0,),

            TextFieldComponent(placeHolder: 'Enter name', controller: TextEditingController(), label: 'Meal Name',),

            const SizedBox(height: 20.0,),

            Text('Image', style: TextStyle(color: Colors.grey.withOpacity(0.8)),),
            const SizedBox(height: 15.0,),
            InkWell(
              onTap: () async{
                await getFromGallery();
              },
              child: DottedBorder(
                color: Colors.deepOrange,
                strokeWidth: 1,
                child: SizedBox(
                  width: Utils.getMaxWidth(context),
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.upload_sharp, color: Colors.deepOrange, size: 30,),
                        SizedBox(height: 5.0,),
                        Text('Upload', style: TextStyle(color: Colors.deepOrange),)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
