import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:my_work/bloc/login_bloc/login_bloc.dart';
import 'package:my_work/components/button_component.dart';
import 'package:my_work/components/icon_button_component.dart';
import 'package:my_work/components/text_field_component.dart';
import 'package:my_work/styles/colors.dart';
import 'package:my_work/styles/text_styles.dart';
import 'package:my_work/ui/upload_page.dart';
import 'package:my_work/utils/utils.dart';

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topBar(context),

                  const SizedBox(height: 10.0,),

                  Expanded(
                    child: gridView(),
                  ),


                  const SizedBox(height: 90,)
                ],
              ),
            );
        },
      ),

      bottomSheet: Container(
        padding: const EdgeInsetsDirectional.only(start: 30.0, end: 30.0,top: 20.0, bottom: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Flexible(flex: 1, child: ButtonComponent(text: 'Cancel', onPressed: (){}, color: Colors.black54,)),

            const SizedBox(width: 10.0,),

            Flexible(flex: 1, child: ButtonComponent(text: 'Delete', onPressed: (){}))
          ],
        ),
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
        IconButtonComponent(
          onTap: ()=>Get.to(const UploadPage()),
          iconData: Icons.upload,
        ),
        const Spacer(),
        IconButtonComponent(
          onTap: (){

          },
          iconData: Icons.edit,
        ),
      ],
    );
  }

  gridView(){
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
      ),
      itemCount: 10,
      itemBuilder: (BuildContext ctx, index) {
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
                            color: Colors.amber,
                            borderRadius: BorderRadiusDirectional.vertical(
                                top: Radius.circular(18.0)
                            )
                        ),
                        child: Text('$index'),
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
                          child: Text('Name', style: AppTextStyle.defaultStyle.copyWith(color: Colors.black),),
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
    );
  }
}
