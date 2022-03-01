import 'package:flutter/material.dart';
import 'package:roi_et_swine/router.dart';

main() => runApp(MyAppEsis());

class MyAppEsis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      initialRoute: '/authen',
    );
  }
}
