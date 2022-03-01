import 'package:flutter/material.dart';
import 'package:roi_et_swine/widget/authen.dart';
import 'package:roi_et_swine/widget/manager_main.dart';
import 'package:roi_et_swine/widget/register.dart';
import 'package:roi_et_swine/widget/show_data.dart';

final Map<String, WidgetBuilder> routes = {
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => Register(),
  '/showdata': (BuildContext context) => Showdata(),
  '/manager_main': (BuildContext context) => Managerdata(),
};
