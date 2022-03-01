import 'package:flutter/material.dart';

class MyStyle {
  Color DarkColor = Color(0xff005cb2);
  Color primaryColor = Color(0xff1e88e5);
  Color lightColor = Color(0xff6ab7ff);

  TextStyle redboldStyle() => TextStyle(
        fontSize: 20,
        color: Colors.red.shade700,
        fontWeight: FontWeight.bold,
      );

  Widget ShowLogo() => Image.asset('image/logo_nb.png');

  Widget ShowLogo2() => Image.asset(
        'image/etech_nb.png',
        height: 70,
        width: 70,
      );

  Widget TitleEsisM() => Text(
        "E-sis Mobile",
        style: TextStyle(
            color: DarkColor, fontWeight: FontWeight.bold, fontSize: 20),
      );

  Widget title1(String string) => Text(
        string,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      );
  MyStyle();
}
