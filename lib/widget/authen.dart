import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:roi_et_swine/Connectapi.dart';
import 'package:roi_et_swine/model/user_model.dart';
import 'package:roi_et_swine/utility/dialog.dart';
import 'package:roi_et_swine/utility/my_style.dart';
import 'package:roi_et_swine/widget/manager_main.dart';
import 'package:roi_et_swine/widget/show_data.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  late double screen;
  bool StatusRedEye = true;
  String username = '', password = '';

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: buildtextbtnforgotpass(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [MyStyle().DarkColor, const Color(0xfffffff)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 4.0],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: screen * 0.8,
              height: screen * 1.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white.withOpacity(0.2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  buildlogo(),
                  Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(fontFamily: 'Prompt',fontSize: 20, color: MyStyle().DarkColor,),
                  ),
                  buildtextfieldUser(),
                  buildtextpassword(),
                  buildbtnlogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextButton buildtextbtnforgotpass() {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/register'),
      // onPressed: () => Navigator.pushNamed(context, '/manager_main'),
      child: Text(
        'สมัครสมาชิก',
        style: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
      ),
    );
  }

  Container buildbtnlogin() {
    return Container(
        margin: EdgeInsets.only(top: 16),
        width: screen * 0.6,
        child: ElevatedButton(
          onPressed: () {
            if (username.isEmpty || password.isEmpty) {
              showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                        title: ListTile(
                          leading: Image.asset('image/logo_nb.png'),
                          title: Text(
                            'กรุณาตรวจสอบ',
                            style: MyStyle().redboldStyle(),
                          ),
                          subtitle: Text('มีช่องว่าง กรุณากรอกข้อมูลให้ครบค่ะ'),
                        ),
                        children: [
                          TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/authen'),
                              child: Text('OK'))
                        ],
                      ));
            } else {
              checkAuthen();
            }
          },
          /*onPressed: () {
            print('name = $username และ $password');
            if ((username.isEmpty) || (password.isEmpty)) {
              print("have null");
              normakDialog(context, 'มีค่าว่าง กรุณากรอกข้อมูลให้ครบ');
            } else {
              print("not null");
              loginFirebase();
            }
          },*/
          //onPressed: () => Navigator.pushNamed(context, '/manager_main'),
          child: Text('Log in'),
          style: ElevatedButton.styleFrom(
            primary: MyStyle().DarkColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ));
  }

  Container buildlogo() {
    return Container(
      width: screen * 0.3,
      child: MyStyle().ShowLogo(),
      margin: EdgeInsets.only(top: 16),
    );
  }

  Container buildtextfieldUser() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 16), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.6,
      child: TextField(
        controller: usernameController,
        onChanged: (value) => username =
            value.trim(), //ถ้ามีการเปลี่ยนแปลงจะกำลังให้ username = value
        style: TextStyle(color: MyStyle().primaryColor,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor),
          hintText: 'Username :',
          prefixIcon: Icon(
            Icons.perm_identity, //icon User ในช่อง
            color: MyStyle().DarkColor,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextpassword() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 16), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.6,
      child: TextField(
        controller: passwordController,
        onChanged: (value) => password = value.trim(),
        obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  StatusRedEye = !StatusRedEye;
                });
              },
              icon: StatusRedEye
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.remove_red_eye_outlined)),
          hintStyle: TextStyle(color: MyStyle().DarkColor),
          hintText: 'Password :',
          prefixIcon: Icon(
            Icons.lock_outline,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String url =
        '${Connectapi().domain}/roi_et_swine/getUserWhereUser.php?isAdd=true&username=$username&password=$password';
        
    try {
      Response response = await Dio().get(url);
      //print('res = $response');

      var result = json.decode(response.data);

      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (password == userModel.password) {
          String typeuser = userModel.idRole;
          if (typeuser == '1') {
            routetoservice(Managerdata(), userModel);
          } else if (typeuser == '3') {
            routetoservice(Showdata(), userModel);
          } else {
            normakDialog(context, 'มีข้อผิดพลาด กรุณาลองใหม่ค่ะ');
          }
        } else {
          normakDialog(context, 'password ผิด กรุณาลองใหม่ค่ะ');
        }
      }
    } catch (e) {}
  }

  Future<Null> routetoservice(Widget mywidget, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id_user', userModel.idUser);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => mywidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
