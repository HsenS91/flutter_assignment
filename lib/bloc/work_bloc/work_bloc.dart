import 'dart:async';

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

validateUpload({BuildContext? context, GlobalKey<FormState>? key, TextEditingController? controller, Work? work}){

  if(!(key?.currentState?.validate()??true)){
    return;
  }

  if(work != null){
    work.name = controller?.text;

    if(workList$?.hasValue??false){
      List<Work>? works = workList$?.value??[];
      works.add(work);
      workList$?.add(works);
    }
    else{
      workList$?.add([work]);
    }
  }

  Get.back();
}