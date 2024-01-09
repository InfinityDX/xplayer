import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ViewerState {
  final String _id;
  ValueNotifier<bool> isShowPlaceHolder = ValueNotifier<bool>(true);

  ViewerState() : _id = UniqueKey().toString();

  String get id => _id;
}
