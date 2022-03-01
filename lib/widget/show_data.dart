import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:roi_et_swine/Connectapi.dart';
import 'package:roi_et_swine/model/showdata_allsummember.dart';
import 'package:roi_et_swine/model/showdata_user.dart';
import 'package:roi_et_swine/utility/my_style.dart';
import 'package:roi_et_swine/widget/edit_userdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authen.dart';

class Showdata extends StatefulWidget {
  const Showdata({Key? key}) : super(key: key);

  @override
  _ShowdataState createState() => _ShowdataState();
}

class _ShowdataState extends State<Showdata> {
  int _selectedIndex = 0;
  List member = [], sumuser = [];
  List Userdata = [];
  late double screen;
  String nameUser = '';

  String fullname = '',
      citizen = '',
      birthdate = '',
      phone = '',
      sex = '',
      age = '',
      career = '',
      invest = '',
      income = '',
      address = '',
      address2 = '',
      address3 = '',
      address4 = '';

  String share_num = '',
      share_price = '',
     // share_price_divi = '',
      totalPriceCost = '',
      profitSum = '',
      sumDividend = '';

  @override
  void initState() {
    super.initState();
    findUser();
    readallmemberSql();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('id_user');
      getuserdataSql(nameUser);
      readall_sumuserSql(nameUser);
    });
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
      //print(result);
    } catch (e) {}
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
          fullname = showData_user.fname + ' ' + showData_user.lname;
          citizen = showData_user.cardId;
          birthdate = showData_user.birthDate;
          phone = showData_user.phone;
          sex = showData_user.sex;
          age = showData_user.age;
          career = showData_user.career;
          invest = showData_user.investment;
          income = showData_user.earnings;
          address = showData_user.homeNumber + ' ' + showData_user.home;
          address2 = ' ถนน' + showData_user.road + ' ซอย' + showData_user.alley;
          address3 = 'ต.' +
              showData_user.tombonName +
              ' อ.' +
              showData_user.aumphurName;
          address4 =
              'จ.' + showData_user.provinceName + ' ' + showData_user.postCode;
        });
      }
      //print(Userdata);
    } catch (e) {}
  }

  Future<Null> readall_sumuserSql(nameUser) async {
    String url =
        '${Connectapi().domain}/roi_et_swine/get_all_sumuser.php?isAdd=true&id_user=' +
            nameUser;

    try {
      Response response = await Dio().get(url);
      //print('res = $response');

      var result = json.decode(response.data);
      for (var map in result) {
        all_sumuser all_sum = all_sumuser.fromJson(map);

        setState(() {
          share_num = all_sum.aNum;
          share_price = all_sum.aPrice;
         // share_price_divi = all_sum.dPriceShares;
          totalPriceCost = all_sum.totalPriceCost;
          profitSum = all_sum.profitSum;
          sumDividend = all_sum.sumDividend;
        });
      }
    } catch (e) {}
  }

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
          // ignore: unnecessary_null_comparison
          title: Text(nameUser == Null
              ? 'Roi-Et Swine Raiser 4.0'
              : '$fullname', style: TextStyle(fontFamily: 'Prompt')), //Roi-Et Swine Raiser 4.0
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
              icon: Icon(Icons.attach_money),
              label: 'หุ้น',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.query_stats),
              label: 'ประกอบการ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts),
              label: 'บัญชี',
            ),
          ],
        ));
  }

  Widget getBody() {
    List<Widget> pages = [
      Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                width: screen * 0.9,
                height: screen * 0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: MyStyle().lightColor.withOpacity(0.5)),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.real_estate_agent,
                                    color: MyStyle().DarkColor,
                                    size: 50,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "หุ้น",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    'ถือหุ้น :',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: MyStyle().DarkColor,
                                        fontWeight: FontWeight.bold,fontFamily: 'Prompt'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: Text(
                                    share_num,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    'ราคา/หุ้น :',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    share_price,
                                    style: TextStyle(fontSize: 20),
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
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                width: screen * 0.9,
                height: screen * 0.75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: MyStyle().lightColor.withOpacity(0.5)),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.monetization_on_outlined,
                                    color: MyStyle().DarkColor,
                                    size: 50,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "เงินปันผล",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(top: 20),
                          //   alignment: Alignment.centerLeft,
                          //   child: Row(
                          //     children: [
                          //       Container(
                          //         child: Text(
                          //           'ราคา / หุ้น :',
                          //           style: TextStyle(
                          //               fontSize: 20,
                          //               fontWeight: FontWeight.bold,
                          //               color: MyStyle().DarkColor),
                          //         ),
                          //       ),
                          //       Container(
                          //         margin: EdgeInsets.only(left: 20),
                          //         child: Text(
                          //          share_price_divi,
                          //           style: TextStyle(fontSize: 20),
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    'ยอดซื้อสินค้า :',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    // ignore: unnecessary_null_comparison
                                    totalPriceCost!=null?totalPriceCost:'',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    'กำไรจากการซื้อสินค้า :',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    profitSum !=null?profitSum:'',
                                    style: TextStyle(fontSize: 20),
                                  ),//Text(cart_prod_qty!=null?cart_prod_qty:''),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    'รวมปันผล :',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    sumDividend,//Text(cart_prod_qtycart_prod_qty:''),
                                    style: TextStyle(fontSize: 20),
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
              )
            ],
          ),
        ),
      ),
      Container(
        child: ListView.builder(
            itemCount: member.length,
            itemBuilder: (context, index) {
              return sumallWidget(member[index]);
            }),
      ),
      Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Image.asset(
                  'image/logo_nb.png',
                  width: 70,
                  height: 70,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  'ข้อมูลส่วนตัว',
                  style: TextStyle(
                    fontSize: 20,
                    color: MyStyle().DarkColor,
                    fontWeight: FontWeight.bold,fontFamily: 'Prompt'
                  ),
                ),
              ),
              Container(
                width: screen * 0.9,
                height: screen * 1.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: MyStyle().lightColor.withOpacity(0.5)),
                child: Column(
                  children: [
                    showname(),
                    showcitizen(),
                    showbirthdate(),
                    showphone(),
                    showsex(),
                    showage(),
                    showcareer(),
                    showinvest(),
                    showincome(),
                    showaddress(),
                  ],
                ),
              ),
              Container(
                child: buildbtnedit(),
              ),
            ],
          ),
        ),
      ),
    ];
    return IndexedStack(
      index: _selectedIndex,
      children: pages,
    );
  }

  Widget showname() {
    //var fname = Userdata['fname'];
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 20, bottom: 5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.account_circle,
              color: MyStyle().DarkColor,
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text(
                    "ชื่อ : ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    fullname,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container showbirthdate() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 20, bottom: 5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.calendar_today,
              color: MyStyle().DarkColor,
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text(
                    "วัน/เดือน/ปี เกิด :",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    birthdate,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container showcitizen() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 20, bottom: 5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.credit_card,
              color: MyStyle().DarkColor,
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text(
                    "เลขบัตรประชาชน :",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    citizen,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container showphone() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 20, bottom: 5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.call,
              color: MyStyle().DarkColor,
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text(
                    "เบอร์โทรศัพท์ :",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: MyStyle().DarkColor,fontFamily: 'Prompt'
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    phone,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container showsex() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 20, bottom: 5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.accessibility,
              color: MyStyle().DarkColor,
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text(
                    "เพศ :",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    sex,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container showage() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 20, bottom: 5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.account_box,
              color: MyStyle().DarkColor,
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text(
                    "อายุ :",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    age,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container showcareer() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 20, bottom: 5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.rule_outlined,
              color: MyStyle().DarkColor,
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text(
                    "อาชีพ :",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    career,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container showinvest() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 20, bottom: 5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.attach_money,
              color: MyStyle().DarkColor,
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text(
                    "เงินลงทุน :",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    invest,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container showincome() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 20, bottom: 5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.paid,
              color: MyStyle().DarkColor,
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text(
                    "รายได้ต่อปี :",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,fontFamily: 'Prompt',
                        color: MyStyle().DarkColor),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    income,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container showaddress() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 20, bottom: 5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.home,
              color: MyStyle().DarkColor,
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text(
                    "ที่อยู่ :",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyStyle().DarkColor,fontFamily: 'Prompt'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          address,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          address2,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          address3,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          address4,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildbtnedit() {
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
          onPressed: () {
            routetoservice(editRegister(), nameUser);
          },
          child: Text('แก้ไขข้อมูล',style:TextStyle( fontFamily: 'Prompt'),),
          style: ElevatedButton.styleFrom(
            primary: MyStyle().DarkColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ));
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

  Future<Null> routetoservice(Widget mywidget, nameUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id_user', nameUser);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => editRegister()),
    );
  }
}
