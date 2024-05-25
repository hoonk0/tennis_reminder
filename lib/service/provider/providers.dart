import 'package:flutter/cupertino.dart';
import '../../model/model_member.dart';

final userNotifier = ValueNotifier<ModelMember?>(null);
// userNotifier.value : ModelMember Or null
final ValueNotifier<bool> vnIsShow = ValueNotifier(false);
// vnIsShow.value : false
final ValueNotifier<int> vnIsInt = ValueNotifier(0);
// vnIsInt.value : 0
final ValueNotifier<String> vnMyName = ValueNotifier('김종완');