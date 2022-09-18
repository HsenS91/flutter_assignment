import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:my_work/bloc/login_bloc/login_bloc.dart';
import 'package:my_work/bloc/work_bloc/work_data.dart';
import 'package:my_work/components/button_component.dart';
import 'package:my_work/components/icon_button_component.dart';
import 'package:my_work/components/text_field_component.dart';
import 'package:my_work/model/work/work.dart';
import 'package:my_work/styles/colors.dart';
import 'package:my_work/styles/text_styles.dart';
import 'package:my_work/ui/upload_page.dart';
import 'package:my_work/utils/routes/routes.dart';
import 'package:my_work/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class MyWorkPage extends StatelessWidget {
  const MyWorkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: MyWorkView(),
    );
  }
}


class MyWorkView extends StatelessWidget {
  MyWorkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        title: Padding(
          padding: const EdgeInsetsDirectional.only(start: 20.0),
          child: Text('My Work', style: AppTextStyle.appBarTitle,),
        ),
      ),

      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return Container(
              margin: const EdgeInsetsDirectional.only(start: 30.0, end: 30.0, top: 20.0),
              width: Utils.getMaxWidth(context),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    topBar(context),

                    const SizedBox(height: 10.0,),

                    StreamBuilder<List<Work>?>(
                      initialData: null,
                      stream: workList$,
                      builder: (context, snapshot) {
                        return snapshot.data == null ?
                        SizedBox(
                          height: Utils.getMaxWidth(context),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('You have not added any work yet!', style: AppTextStyle.defaultStyle,),
                                const SizedBox(height: 15.0,),
                                ButtonComponent(
                                  width: Utils.getMaxWidth(context)*0.5,
                                  onPressed: (){
                                    editSelected$?.add(false);
                                    uploadSelected$?.add(true);
                                    Get.toNamed(Routes.uploadWorkPage);
                                  },
                                  text: 'Upload work',
                                )
                              ],
                            ),
                          ),
                        )
                          :
                        gridView(snapshot.data??[]);
                      }
                    ),


                  ],
                ),
              ),
            );
        },
      ),

      bottomSheet: StreamBuilder<Work?>(
        initialData: null,
        stream: workSelected$,
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

                Flexible(flex: 1, child: ButtonComponent(text: 'Delete', onPressed: (){}))
              ],
            ),
          );
        }
      ),
    );
  }

  topBar(context){

    return Row(
      children: [
        SizedBox(
          width: Utils.getMaxWidth(context)*0.7 - 30,
          child: TextFieldComponent(
            icon: const Icon(Icons.search, color: AppColors.deepOrange,),
            hasPadding: true,
            placeHolder: 'Search',
            controller: TextEditingController()
          ),
        ),
        const Spacer(),
        const Spacer(),

        StreamBuilder<bool?>(
          initialData: true,
          stream: uploadSelected$,
          builder: (context, snapshot) {
            return IconButtonComponent(
              hasGradientColor: snapshot.data,
              onTap: (){
                workSelected$?.add(null);
                editSelected$?.add(false);
                uploadSelected$?.add(true);
                Get.toNamed(Routes.uploadWorkPage);
              },
              iconData: Icons.upload,
            );
          }
        ),

        const Spacer(),

        StreamBuilder<bool?>(
          initialData: false,
          stream: editSelected$,
          builder: (context, snapshot) {
            return IconButtonComponent(
              hasGradientColor: snapshot.data,
              onTap: (){
                uploadSelected$?.add(false);
                editSelected$?.add(true);
              },
              iconData: Icons.edit,
            );
          }
        ),
      ],
    );
  }

  gridView(List<Work> workList){
    return Padding(
      padding: const EdgeInsets.only(bottom: 90.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
        ),
        itemCount: workList.length,
        itemBuilder: (BuildContext ctx, index) {
          Work work = workList[index];
          return InkWell(
            onTap: (){

            },
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.all(5),
                  decoration: BoxDecoration(
                      //border: tests[index] ? Border.all(color: AppColors.deepOrange, width: 2) : null,
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadiusDirectional.vertical(
                              top: Radius.circular(18.0)
                            )
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(18.0)
                            ),
                            child: Image.file(work.image!, fit: BoxFit.fill, width: double.infinity, height: double.infinity,)),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadiusDirectional.vertical(
                              bottom: Radius.circular(18.0)
                            )
                          ),
                          child: Center(
                            child: Text(work.name??'', style: AppTextStyle.defaultStyle.copyWith(color: Colors.black),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                //if(tests[index])
                  PositionedDirectional(
                    end: 0,
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(0.5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.deepOrange, width: 2.0)
                      ),
                      child: const Center(
                        child: Icon(Icons.remove, color: AppColors.deepOrange,),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }
      ),
    );
  }
}
