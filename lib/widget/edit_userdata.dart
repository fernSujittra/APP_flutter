import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:roi_et_swine/Connectapi.dart';
import 'package:roi_et_swine/model/showdata_user.dart';
import 'package:roi_et_swine/utility/dialog.dart';
import 'package:roi_et_swine/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class editRegister extends StatefulWidget {
  const editRegister({Key? key}) : super(key: key);

  @override
  _editRegisterState createState() => _editRegisterState();
}

class _editRegisterState extends State<editRegister> {
  final dateController = TextEditingController();
  TextEditingController textusernameController = TextEditingController();
  TextEditingController textpasswordController = TextEditingController();
  TextEditingController textfnameController = TextEditingController();
  TextEditingController textlnameController = TextEditingController();
  TextEditingController textcitizenController = TextEditingController();
  TextEditingController textbirthdateController = TextEditingController();
  TextEditingController textageController = TextEditingController();
  TextEditingController textsexController = TextEditingController();
  TextEditingController textphoneController = TextEditingController();
  TextEditingController textcareerController = TextEditingController();
  TextEditingController textincomeController = TextEditingController();
  TextEditingController textinvestController = TextEditingController();

  TextEditingController texthomenumController = TextEditingController();
  TextEditingController texthomenameController = TextEditingController();
  TextEditingController textroadController = TextEditingController();
  TextEditingController textsoiController = TextEditingController();
  TextEditingController texttumbolController = TextEditingController();
  TextEditingController textamphurController = TextEditingController();
  TextEditingController textprovinceController = TextEditingController();
  TextEditingController textpostcodeController = TextEditingController();

  String username = '',
      password = '',
      firstname = '',
      lastname = '',
      citizen = '',
      birthdate = '',
      age = '',
      sex = '',
      phone = '',
      career = '',
      income = '',
      invest = '',
      homenum = '',
      homename = '',
      nameUser = '';

  String homeroads = '',
      homesoi = '',
      hometumbol = '',
      homeamphur = '',
      homeprovince = '',
      homecode = '';

  late double screen;
  @override
  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('id_user');
      getuserdataSql(nameUser);
    });
    //print('test' + nameUser);
  }

  Future<Null> getuserdataSql(nameUser) async {
    String url =
        '${Connectapi().domain}/roi_et_swine/getuser_data.php?isAdd=true&id_user=' +
            nameUser;

    try {
      Response response = await Dio().get(url);
      //print('res = $response');

      var result = json.decode(response.data);
      //print(result);
      for (var map in result) {
        showdata_user showData_user = showdata_user.fromJson(map);

        setState(() {
          textusernameController.text = showData_user.username;
          textpasswordController.text = showData_user.password;
          textfnameController.text = showData_user.fname;
          textlnameController.text = showData_user.lname;
          textcitizenController.text = showData_user.cardId;
          dateController.text = showData_user.birthDate;
          textageController.text = showData_user.age;
          textsexController.text = showData_user.sex;
          textphoneController.text = showData_user.phone;
          textcareerController.text = showData_user.career;
          textincomeController.text = showData_user.earnings;
          textinvestController.text = showData_user.investment;

          texthomenumController.text = showData_user.homeNumber;
          texthomenameController.text = showData_user.home;
          textroadController.text = showData_user.road;
          textsoiController.text = showData_user.alley;
          texttumbolController.text = showData_user.tombonName;
          textamphurController.text = showData_user.aumphurName;
          textprovinceController.text = showData_user.provinceName;
          textpostcodeController.text = showData_user.postCode;
        });
      }
      //print(Userdata);
    } catch (e) {}
  }

  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().DarkColor,
        title: Text('แก้ไขข้อมูลส่วนตัว' + nameUser,style:TextStyle( fontFamily: 'Prompt'),),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [MyStyle().primaryColor, Colors.grey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 4.0],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: screen * 0.95,
                  //height: screen * 1.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'ข้อมูลส่วนตัว',
                        style:
                            TextStyle(fontSize: 20, color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                      ),
                      buildtextfieldUsername(),
                      buildtextpassword(),
                      buildtextfirstname(),
                      buildtextlastname(),
                      buildtextcitizen(),
                      buildtextbirthdate(),
                      buildtextAge(),
                      buildtextSex(),
                      buildtextPhone(),
                      buildtextcareer(),
                      buildtextincome(),
                      buildtextinvest(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: screen * 0.95,
                  //height: screen * 1.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'ที่อยู่ที่สามารถติดต่อได้',
                        style:
                            TextStyle(fontSize: 20, color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                      ),
                      buildtextHomenum(),
                      buildtextHomename(),
                      buildtextHomeroad(),
                      buildtextHomesoi(),
                      buildtextHometumbol(),
                      buildtextHomeamphur(),
                      buildtextHomeprovince(),
                      buildtextHomecode(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: screen * 0.95,
                  //height: screen * 1.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildbtnregis(),
                        buildbtncancel(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildtextfieldUsername() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textusernameController,
        /*onChanged: (value) => username = 
            value.trim(),*/
        onChanged: (value) => username =
            value.trim(), //ถ้ามีการเปลี่ยนแปลงจะกำลังให้ username = value
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'ชื่อผู้ใช้ :',
          prefixIcon: Icon(
            Icons.perm_identity_outlined, //icon User ในช่อง
            color: MyStyle().DarkColor,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextpassword() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textpasswordController,
        onChanged: (value) => password = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'รหัสผ่าน :',
          prefixIcon: Icon(
            Icons.lock_outline,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextfirstname() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textfnameController,
        onChanged: (value) => firstname = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'ชื่อ :',
          prefixIcon: Icon(
            Icons.account_circle,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextlastname() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textlnameController,
        onChanged: (value) => lastname = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'นามสกุล :',
          prefixIcon: Icon(
            Icons.account_circle,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextcitizen() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textcitizenController,
        onChanged: (value) => citizen = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'เลขบัตรประชาชน :',
          prefixIcon: Icon(
            Icons.credit_card,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextbirthdate() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white38,
        ),
        margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
        width: screen * 0.9,
        child: TextField(
          readOnly: true,
          controller: dateController,
          style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
            hintText: 'วัน/เดือน/ปี เกิด :',
            prefixIcon: Icon(
              Icons.calendar_today,
              color: MyStyle().DarkColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
                borderSide: BorderSide(
                    color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyStyle().lightColor),
            ), //icon User ในช่อง
          ),
          onTap: () async {
            var date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            dateController.text = date.toString().substring(0, 10);
            setState(() {
              birthdate = dateController.text;
            });
          },
        )

        /*TextField(
        onChanged: (value) => birthdate = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor),
          hintText: 'วัน/เดือน/ปี เกิด :',
          prefixIcon: Icon(
            Icons.calendar_today,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),*/
        );
  }

  Container buildtextAge() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textageController,
        onChanged: (value) => age = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'อายุ :',
          prefixIcon: Icon(
            Icons.account_box,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextSex() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textsexController,
        onChanged: (value) => sex = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'เพศ :',
          prefixIcon: Icon(
            Icons.accessibility,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextPhone() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textphoneController,
        onChanged: (value) => phone = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'เบอร์โทร :',
          prefixIcon: Icon(
            Icons.call,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextcareer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textcareerController,
        onChanged: (value) => career = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'อาชีพ :',
          prefixIcon: Icon(
            Icons.rule_outlined,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextincome() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textincomeController,
        onChanged: (value) => income = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'รายได้/ปี :',
          prefixIcon: Icon(
            Icons.paid,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextinvest() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.all(8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textinvestController,
        onChanged: (value) => invest = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'เงินลงทุน :',
          prefixIcon: Icon(
            Icons.attach_money,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextHomenum() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: texthomenumController,
        onChanged: (value) => homenum = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'บ้านเลขที่ :',
          prefixIcon: Icon(
            Icons.home,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextHomename() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: texthomenameController,
        onChanged: (value) => homename = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'หมู่บ้าน :',
          prefixIcon: Icon(
            Icons.home,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextHomeroad() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textroadController,
        onChanged: (value) => homeroads = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'ถนน :',
          prefixIcon: Icon(
            Icons.home,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextHomesoi() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textsoiController,
        onChanged: (value) => homesoi = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'ซอย :',
          prefixIcon: Icon(
            Icons.home,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextHometumbol() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: texttumbolController,
        onChanged: (value) => hometumbol = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'ตำบล :',
          prefixIcon: Icon(
            Icons.home,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextHomeamphur() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textamphurController,
        onChanged: (value) => homeamphur = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'อำเภอ :',
          prefixIcon: Icon(
            Icons.home,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextHomeprovince() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textprovinceController,
        onChanged: (value) => homeprovince = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'จังหวัด :',
          prefixIcon: Icon(
            Icons.home,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildtextHomecode() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white38,
      ),
      margin: EdgeInsets.all(8.0), // ให้อยู่ห่างจากขอบบน
      width: screen * 0.9,
      child: TextField(
        controller: textpostcodeController,
        onChanged: (value) => homecode = value.trim(),
        //obscureText: StatusRedEye,
        style: TextStyle(color: MyStyle().primaryColor, height: 0.6,fontFamily: 'Prompt'),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().DarkColor,fontFamily: 'Prompt'),
          hintText: 'รหัสไปรษณีย์ :',
          prefixIcon: Icon(
            Icons.home,
            color: MyStyle().DarkColor,
          ), //icon User ในช่อง
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), //ทำให้กรอบโค้งตรงมุม
              borderSide: BorderSide(
                  color: MyStyle().DarkColor)), //ให้มองเห็นกรอบสี่เหลี่ยม
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildbtnregis() {
    return Container(
        margin: EdgeInsets.only(top: 16),
        width: screen * 0.3,
        child: ElevatedButton(
          onPressed: () {
            updateThread();
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
          //onPressed: () => Navigator.pushNamed(context, '/pincode'),
          child: Text('บันทึก'),
          style: ElevatedButton.styleFrom(
            primary: MyStyle().DarkColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ));
  }

  Future<Null> updateThread() async {
    String url =
        '${Connectapi().domain}/roi_et_swine/update_user.php?isAdd=true&id_user=$nameUser&username=' +
            textusernameController.text +
            '&password=' +
            textpasswordController.text +
            '&fname=' +
            textfnameController.text +
            '&lname=' +
            textlnameController.text +
            '&card_id=' +
            textcitizenController.text +
            '&birth_date=' +
            dateController.text +
            '&age=' +
            textageController.text +
            '&sex=' +
            textsexController.text +
            '&phone=' +
            textphoneController.text +
            '&career=' +
            textcareerController.text +
            '&earnings=' +
            textincomeController.text +
            '&Investment=' +
            textinvestController.text +
            '&home_number=' +
            texthomenumController.text +
            '&home=' +
            texthomenameController.text +
            '&road=' +
            textroadController.text +
            '&alley=' +
            textsoiController.text +
            '&tombon_name=' +
            texttumbolController.text +
            '&aumphur_name=' +
            textamphurController.text +
            '&province_name=' +
            textprovinceController.text +
            '&post_code=' +
            textpostcodeController.text;

    try {
      Response response = await Dio().get(url);
      print('res = $response');

      if (response.toString() == 'true') {
        showDialog(
            context: context,
            builder: (context) => SimpleDialog(
                  title: ListTile(
                    leading: Image.asset('image/logo_nb.png'),
                    title: Text(
                      'กรุณาตรวจสอบ',
                      style: MyStyle().redboldStyle(),
                    ),
                    subtitle: Text('ทำการแก้ไขเรียบร้อยแล้วค่ะ'),
                  ),
                  children: [
                    TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/showdata'),
                        child: Text('OK'))
                  ],
                ));
        /*normakDialog(context, 'ทำการสมัครเรียบร้อยค่ะ');
        Navigator.pop(context);*/
      } else {
        normakDialog(context, 'ไม่สามารถแก้ไขได้ กรุณาลองใหม่ค่ะ');
      }
    } catch (e) {}
  }

  Container buildbtncancel() {
    return Container(
        margin: EdgeInsets.only(top: 16),
        width: screen * 0.3,
        child: ElevatedButton(
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
          onPressed: () => Navigator.pushNamed(context, '/showdata'),
          child: Text('ยกเลิก'),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ));
  }
}
