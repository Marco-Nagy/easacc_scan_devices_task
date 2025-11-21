import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


extension MyContextExtension on BuildContext {
  /// MediaQuery extension
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  bool get isLandScape => MediaQuery.of(this).orientation == Orientation.landscape;
  bool get isPortrait => MediaQuery.of(this).orientation == Orientation.portrait;





}
