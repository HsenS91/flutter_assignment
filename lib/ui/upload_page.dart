import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_work/bloc/work_bloc/work_bloc.dart';
import 'package:my_work/bloc/work_bloc/work_data.dart';
import 'package:my_work/components/text_field_component.dart';
import 'package:my_work/model/work/work.dart';
import 'package:my_work/styles/colors.dart';
import 'package:my_work/utils/utils.dart';
import 'package:my_work/utils/validations/validations.dart';
import '../components/button_component.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    uploadWork$?.add(null);
  }

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

            Form(
              key: _key,
              child: TextFieldComponent(placeHolder: 'Enter name', controller: _nameController, label: 'Meal Name', validator: Validations.defaultValidator,)
            ),

            const SizedBox(height: 20.0,),

            Text('Image', style: TextStyle(color: Colors.grey.withOpacity(0.8)),),
            const SizedBox(height: 15.0,),
            InkWell(
              onTap: () async{
                File image = await getFromGallery();
                Work work = Work(
                  image: image
                );
                uploadWork$?.add(work);
              },
              child: DottedBorder(
                color: Colors.deepOrange,
                strokeWidth: 1,
                child: StreamBuilder<Work?>(
                  initialData: null,
                  stream: uploadWork$,
                  builder: (context, snapshot) {
                    return (snapshot.data != null && snapshot.data?.image != null) ?
                    SizedBox(
                      width: Utils.getMaxWidth(context),
                      height: 200,
                      child: Center(child: Image.file(snapshot.data!.image!, width: 100, height: 100, fit: BoxFit.cover,)),
                    )
                      :
                    SizedBox(
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
                    );
                  }
                ),
              ),
            )
          ],
        ),
      ),

      bottomSheet: StreamBuilder<Work?>(
        initialData: null,
        stream: uploadWork$,
        builder: (context, snapshot) {
          return snapshot.data == null ?
          const SizedBox()
              :
          Container(
            padding: const EdgeInsetsDirectional.only(start: 30.0, end: 30.0,top: 20.0, bottom: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Flexible(flex: 1, child: ButtonComponent(text: 'Cancel', onPressed: (){}, color: Colors.black54,)),

                const SizedBox(width: 10.0,),

                Flexible(flex: 1, child: ButtonComponent(text: 'Upload', onPressed: () => validateUpload(context: context, key: _key, controller: _nameController ,work: snapshot.data) )
                )
              ],
            ),
          );
        }
    ),
    );
  }
}
