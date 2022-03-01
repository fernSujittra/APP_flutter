import 'package:flutter/material.dart';
import 'package:roi_et_swine/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

String finaliduser = '';

class MemberWidget extends StatefulWidget {
  late String index;

  MemberWidget(this.index);

  @override
  _MemberWidgetState createState() => _MemberWidgetState();
}

class _MemberWidgetState extends State<MemberWidget> {
  late double screen;
  String nameUser = '';

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    String snapshot;
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: screen * 0.9,
      height: screen * 0.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: MyStyle().lightColor.withOpacity(0.5)),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ชื่อ :',
                    style: TextStyle(fontSize: 16,fontFamily: 'Prompt'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'จำนวนหุ้น :',
                    style: TextStyle(fontSize: 16,fontFamily: 'Prompt'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'รวมปันผล :',
                    style: TextStyle(fontSize: 16,fontFamily: 'Prompt'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
