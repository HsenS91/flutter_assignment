import 'package:my_work/model/work/work.dart';
import 'package:rxdart/rxdart.dart';


BehaviorSubject<bool?>? uploadSelected$ = BehaviorSubject<bool?>();
BehaviorSubject<bool?>? editSelected$ = BehaviorSubject<bool?>();

List<Work>? workList;
BehaviorSubject<List<Work>?>? workList$ = BehaviorSubject<List<Work>?>();
BehaviorSubject<Work?>? workSelected$ = BehaviorSubject<Work?>();

BehaviorSubject<Work?>? uploadWork$ = BehaviorSubject<Work?>();