import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:roi_et_swine/Connectapi.dart';
import 'package:roi_et_swine/model/shareall_model.dart';
import 'package:roi_et_swine/utility/my_style.dart';
import 'package:roi_et_swine/widget/authen.dart';
import 'package:roi_et_swine/widget/member_widget.dart';

class Managerdata extends StatefulWidget {
  const Managerdata({Key? key}) : super(key: key);

  @override
  _ManagerdataState createState() => _ManagerdataState();
}

class _ManagerdataState extends State<Managerdata> {
  List users = [];
  List member = [];
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    readDataSql();
    readallmemberSql();
  }

  Future<Null> readDataSql() async {
    String url = '${Connectapi().domain}/roi_et_swine/getAll_share.php';

    try {
      Response response = await Dio().get(url);
      //print('res = $response');

      var result = json.decode(response.data);

      setState(() {
        users = result;
      });
    } catch (e) {}
  }

  Future<Null> readallmemberSql() async {
    String url = '${Connectapi().domain}/roi_et_swine/getAll_sum.php';

    try {
      Response response = await Dio().get(url);
      //print('res = $response');

      var result = json.decode(response.data);
      //print(result);
      setState(() {
        member = result;
      });
    } catch (e) {}
  }

  int _selectedIndex = 0;
  late double screen;
  @override
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Roi-Et Swine Raiser 4.0',style:TextStyle( fontFamily: 'Prompt'),),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => Authen(),
                );
                Navigator.pushAndRemoveUntil(context, route, (route) => false);
              },
            ),
          ],
          backgroundColor: MyStyle().DarkColor,
          elevation: 20,
        ),
        body: getBody(),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          currentIndex: _selectedIndex,
          backgroundColor: MyStyle().DarkColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.groups_outlined),
              label: 'สมาชิก',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.query_stats),
              label: 'ประกอบการ',
            ),
          ],
        ));
  }

  Widget getBody() {
    List<Widget> pages = [
      Container(
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return MemberWidget(users[index]);
            }),
      ),
      Container(
        child: ListView.builder(
            itemCount: member.length,
            itemBuilder: (context, index) {
              return sumallWidget(member[index]);
            }),
      ),
    ];
    return IndexedStack(
      index: _selectedIndex,
      children: pages,
    );
  }

  Widget MemberWidget(result) {
    screen = MediaQuery.of(context).size.width;
    var fullname = result['fullname'];
    var number_shares = result['number_shares'];
    var sum_dividend = result['sum_dividend'];
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
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
                Container(
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          'ชื่อ : ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,fontFamily: 'Prompt'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 45),
                        child: Text(
                          fullname,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          'จำนวนหุ้น : ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,fontFamily: 'Prompt'),
                        ),
                      ),
                      Container(
                        child: Text(
                          number_shares,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          'รวมปันผล : ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,fontFamily: 'Prompt'),
                        ),
                      ),
                      Container(
                        child: Text(
                          sum_dividend,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sumallWidget(result) {
    var allprice = result['allprice'];
    var allshare = result['allshare'];
    var allmember = result['allmember'];
    return Container(
      margin: EdgeInsets.only(top: 130),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "รายงานผลประกอบการ",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: MyStyle().DarkColor,fontFamily: 'Prompt'
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            width: screen * 0.9,
            height: screen * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: MyStyle().DarkColor.withOpacity(0.5)),
            child: Center(
                child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 30,
                  ),
                  child: Text(
                    'เงินหุ้นของสมาชิก =',
                    style: TextStyle(
                        fontSize: 22,
                        color: MyStyle().DarkColor,
                        fontWeight: FontWeight.bold,fontFamily: 'Prompt'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 30,
                  ),
                  child: Text(
                    allprice,
                    style: TextStyle(fontSize: 22, color: MyStyle().DarkColor),
                  ),
                ),
              ],
            )),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 5,
            ),
            width: screen * 0.9,
            height: screen * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: MyStyle().primaryColor.withOpacity(0.5)),
            child: Center(
                child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 30,
                  ),
                  child: Text(
                    'จำนวนหุ้นทั้งหมด =',
                    style: TextStyle(
                        fontSize: 22,
                        color: MyStyle().DarkColor,
                        fontWeight: FontWeight.bold,fontFamily: 'Prompt'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 22,
                  ),
                  child: Text(
                    allshare,
                    style: TextStyle(fontSize: 22, color: MyStyle().DarkColor),
                  ),
                ),
              ],
            )),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 5,
            ),
            width: screen * 0.9,
            height: screen * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: MyStyle().lightColor.withOpacity(0.5)),
            child: Center(
                child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 30,
                  ),
                  child: Text(
                    'สมาชิกทั้งหมด =',
                    style: TextStyle(
                        fontSize: 22,
                        color: MyStyle().DarkColor,
                        fontWeight: FontWeight.bold,fontFamily: 'Prompt'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 50,
                  ),
                  child: Text(
                    allmember,
                    style: TextStyle(fontSize: 22, color: MyStyle().DarkColor),
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
