import 'package:my_work/utils/routes/routes.dart';
import 'package:my_work/utils/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_work/bloc/work_bloc/work_data.dart';
import 'package:my_work/model/work/work.dart';

part 'work_event.dart';
part 'work_state.dart';

class WorkBloc extends Bloc<WorkEvent, WorkState> {
  WorkBloc() : super(WorkInitial()) {
    on<WorkEvent>((event, emit) {

    });
  }
}

validateUpload({BuildContext? context, GlobalKey<FormState>? key, TextEditingController? controller, Work? work, bool? isEditing}){

  const uuid = Uuid();

  if(!(key?.currentState?.validate()??true)){
    return;
  }

  if(work != null){
    work.name = controller?.text;
    if(isEditing??false){
      workList?.firstWhere((element) => element.uuid == work.uuid)?..name = work.name..image=work.image;

      List<Work>? tempWork = workList$?.value;

      if(tempWork != null){
        tempWork.firstWhere((element) => element.uuid == work.uuid)..name = work.name..image=work.image;
        workList$?.add(tempWork);
      }
      else{
        workList$?.add(workList);
      }
    }
    else{
      work.uuid = uuid.v1();
      if(workList$?.hasValue??false){
        List<Work>? works = workList$?.value??[];
        works.add(work);
        workList$?.add(works);
      }
      else{
        workList$?.add([work]);
      }
    }

  }

  workList = workList$?.value;
  Get.back();
}

onCancelEdit(context){
  FocusScope.of(context).requestFocus(FocusNode());
  workSelected$?.add(null);
  if(workList$?.hasValue??false){
    List<Work> works = workList$?.value??[];
    for (var element in works) {
      element.selected = false;
    }
    workList$?.add(works);
  }

  selectedWorksList?.clear();
}

onDeleteWork(context, Work work, TextEditingController controller){
  FocusScope.of(context).requestFocus(FocusNode());
  twoButtonsDialog(
    title: 'Warning!',
    text: 'Are you sure you want to delete?',
    context: context,
    onCancel: (){
      Get.back();
    },
    onContinue: (){
      List<Work>? works = workList;
      List<Work>? tempWorkList = workList$?.value??[];

      if(tempWorkList.isNotEmpty){
        tempWorkList.remove(work);
      }

      works?.remove(work);
      selectedWorksList?.removeWhere((element) => work.uuid == element.uuid);

      if(tempWorkList.isNotEmpty){
        workList$?.add(tempWorkList);
      }
      else{
        controller.clear();
        workList$?.add((works?.isEmpty??false)?null:works);
      }

      if(selectedWorksList?.isEmpty??false) {
        workSelected$?.add(null);
      }
      Get.back();
    }
  );
}

onFilter(value){
  List<Work> works = workList$?.value??[];
  for (var element in works) {
    element.selected = false;
  }
  workList$?.add(works);
  workSelected$?.add(null);
  if(value.trim().isNotEmpty){
    List<Work> filteredWorks = workList?.where((element) => element.name!.contains(value)).toList()??[];
    workList$?.add(filteredWorks);
  }
  else{
    workList$?.add((workList?.isEmpty??false)?null:workList);
  }
}

onUploadTap(context, TextEditingController controller){
  FocusScope.of(context).requestFocus(FocusNode());
  controller.clear();
  workSelected$?.add(null);
  editSelected$?.add(false);
  uploadSelected$?.add(true);

  if(workList$?.hasValue??false){

    List<Work>? works = workList;
    for (var element in works??[]) {
      element.selected = false;
    }
    workList$?.add(works);
  }

  Get.toNamed(Routes.uploadWorkPage);
}

onEditTap(context, Work? work, TextEditingController controller){
  FocusScope.of(context).requestFocus(FocusNode());
  controller.clear();
  uploadSelected$?.add(false);
  editSelected$?.add(true);

  workList$?.add(workList);

  if(work != null){
    twoButtonsDialog(
      title: 'Edit Work!',
      text: 'Are you sure you want to edit the selected work?',
      context: context,
      onCancel: (){
        Get.back();
      },
      onContinue: (){
        Get.back();
        Get.toNamed(Routes.uploadWorkPage, arguments: work);
      }
    );
  }
  else{
    customDialog(
      context: context,
      hasIcon: false,
      text :'Please select the work that you wish to edit.',
      onPressed: (){
        Get.back();
      }
    );
  }

}

onWorkTap(context, Work work, int index){
  List<Work>? works = workList;
  for (var element in works??[]) {
    if(element.uuid == work.uuid){
      element.selected = true;
      selectedWorksList?.add(element);
    }
  }
  work.selected = true;
  workSelected$?.add(work);
  workList$?.add(workList);
}

onDeleteMultipleWorks(context){
  FocusScope.of(context).requestFocus(FocusNode());
  twoButtonsDialog(
      title: 'Warning!',
      text: 'Are you sure you want to delete?',
      context: context,
      onCancel: (){
        Get.back();
      },
      onContinue: (){

        for(Work work in selectedWorksList??[]){
          workList?.removeWhere((element) => element.uuid == work.uuid);
        }

        selectedWorksList?.clear();

        workSelected$?.add(null);

        workList$?.add((workList?.isEmpty??false)?null:workList);
        Get.back();
      }
  );
}