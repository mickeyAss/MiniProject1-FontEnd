import 'dart:convert';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/buy.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/result.dart';
import 'package:project/pages/wallet.dart';
import 'package:project/pages/mylotto.dart';
import 'package:project/config/config.dart';
import 'package:project/pages/profile.dart';
import 'package:project/models/respone/number_get_res.dart';
import 'package:project/models/respone/user_get_uid_res.dart';
import 'package:project/models/respone/user_my_reslt_res.dart';
import 'package:project/models/respone/user_my_lotto_res.dart';

class HomePage extends StatefulWidget {
  int uid = 0;
  HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedDate;
  List<String> date = [
    "1 สิงหาคม 2567",
    "16 กรกฎาคม 2567",
    "1 กรกฎาคม 2567",
  ];
  String url = "";
  late UserlGetUidRespone user;
  List<NumberGetRespone> num = [];
  late Future<void> loadData;
  late Future<void> loadnum;
  List<UserMyLottoRespone> getnumber = [];

  List<TextEditingController> searchControllers =
      List.generate(6, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    log(widget.uid.toString());
    super.initState();
    loadData = loadDataAsync();
    loadnum = loaddatanumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: loadData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                "assets/images/bg1.jpg",
                                width: double.infinity,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 30, 20, 0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "LOTTO CLICK",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                child: ClipOval(
                                                  child: Image.network(
                                                    user.image,
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfilePage(
                                                          uid: widget.uid,
                                                        ),
                                                      ));
                                                },
                                              ),
                                            ),
                                            Image.asset(
                                              "assets/images/bell.png",
                                              width: 30,
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        "กรอกเลขลอตโต้ที่ต้องการตรวจ",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: List.generate(6, (index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: SizedBox(
                                                  width: 46,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: TextField(
                                                      controller:
                                                          searchControllers[
                                                              index],
                                                      focusNode:
                                                          focusNodes[index],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLength: 1,
                                                      decoration:
                                                          InputDecoration(
                                                        counterText: '',
                                                        hintStyle: TextStyle(
                                                            color:
                                                                Colors.black54),
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                      onChanged: (value) {
                                                        if (value.length == 0) {
                                                          // If the value is empty, move focus to the previous field
                                                          if (index > 0) {
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    focusNodes[
                                                                        index -
                                                                            1]);
                                                          }
                                                        } else if (value
                                                                .length ==
                                                            1) {
                                                          // Move focus to the next field if not the last field
                                                          if (index < 5) {
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    focusNodes[
                                                                        index +
                                                                            1]);
                                                          } else {
                                                            // Unfocus on the last field
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus();
                                                          }
                                                        }
                                                      },
                                                      onTap: () {
                                                        if (index > 0 &&
                                                            searchControllers[
                                                                    index - 1]
                                                                .text
                                                                .isEmpty) {
                                                          // Prevent focus on current field if previous fields are empty
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  focusNodes[
                                                                      index -
                                                                          1]);
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: FilledButton(
                                              style: FilledButton.styleFrom(
                                                  backgroundColor: Color.fromARGB(
                                                      255,
                                                      0,
                                                      10,
                                                      103), // สีพื้นหลังของปุ่ม
                                                  foregroundColor: Colors
                                                      .white, // สีข้อความบนปุ่ม
                                                  padding: EdgeInsets.only(
                                                      left: 50, right: 50),
                                                  textStyle: TextStyle(
                                                      fontSize:
                                                          16), // ขนาดข้อความ
                                                  elevation: 15),
                                              onPressed: () {
                                                String searchQuery =
                                                    searchControllers
                                                        .map((controller) =>
                                                            controller.text)
                                                        .join();
                                                searchNumber(searchQuery);
                                              },
                                              child: Text(
                                                'ตรวจเลขลอตโต้',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15), // ขอบมน
                                        ),
                                        child: SizedBox(
                                          width: 400,
                                          height: 200,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                15), // ให้แน่ใจว่าภาพอยู่ในขอบมน
                                            child: Stack(children: [
                                              Image.asset(
                                                "assets/images/bg2.jpg",
                                                width: 400,
                                                height: 200,
                                                fit: BoxFit.cover,
                                              ),
                                              Image.asset(
                                                "assets/images/cound.png",
                                                width: 400,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 100, 0, 0),
                                                child: Image.asset(
                                                  "assets/images/cound.png",
                                                  width: 200,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                20, 15, 0, 0),
                                                        child: Text(
                                                          "ต้องการซื้อเลขเด็ดๆ",
                                                          style: TextStyle(
                                                              fontSize: 24,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 25, 0, 0),
                                                        child: FilledButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        BuyPage(
                                                                            uid:
                                                                                widget.uid),
                                                                  ));
                                                            },
                                                            style: FilledButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .amber),
                                                            child: const Text(
                                                              'คลิกเลย',
                                                              style: TextStyle(
                                                                  fontSize: 32,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                150, 0, 0, 0),
                                                        child: Image.asset(
                                                          "assets/images/tap.png",
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Image.asset(
                                                    "assets/images/dragon.png",
                                                    width: 100,
                                                  )
                                                ],
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 220,
                width: 360,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'ผลการออกรางวัล',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 20),
                            child: FutureBuilder(
                              future: loadnum,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (num.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'ยังไม่ออกรางวัล',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }

                                List<Widget> column1 = [];
                                List<Widget> column2 = [];
                                List<Widget> column3 = [];

                                for (var e in num) {
                                  if (e.result == 'รางวัลที่ 2' ||
                                      e.result == 'รางวัลที่ 4') {
                                    column1.add(Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Column(
                                        children: [
                                          Text(e.result),
                                          Text(
                                            e.number,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ));
                                  } else if (e.result == 'รางวัลที่ 1') {
                                    column2.add(Column(
                                      children: [
                                        Text(e.result),
                                        Text(
                                          e.number,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ));
                                  } else {
                                    column3.add(Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Column(
                                        children: [
                                          Text(e.result),
                                          Text(
                                            e.number,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ));
                                  }
                                }

                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: column1,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: column2,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: column3,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 90,
          child: SingleChildScrollView(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.home,
                            size: 30,
                          )),
                      const Text(
                        "หน้าแรก",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyLottoPage(uid: widget.uid),
                                ));
                          },
                          icon: const Icon(
                            Icons.newspaper,
                            size: 30,
                          )),
                      const Text(
                        "ลอตโต้ของฉัน",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WalletPage(
                                    uid: widget.uid,
                                  ),
                                ));
                          },
                          icon: const Icon(
                            Icons.wallet,
                            size: 30,
                          )),
                      const Text(
                        "กระเป๋าตังค์",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PopupMenuButton<int>(
                        icon: const Icon(Icons.menu, size: 30),
                        onSelected: (value) {
                          if (value == 0) {
                            // เมื่อเลือก Logout ให้ไปหน้าแรก
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                          } else if (value == 1) {
                            // เมื่อเลือก Profile ให้ไปหน้าข้อมูลโปรไฟล์
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                    uid: widget.uid,
                                  ),
                                ));
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem<int>(
                              value: 0, child: Text("Logout")),
                          const PopupMenuItem<int>(
                              value: 1, child: Text("Profile")),
                        ],
                      ),
                      const Text(
                        "เมนู",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }

  Future<void> searchNumber(String number) async {
    try {
      var config = await Configuration.getConfig();
      var url = config['apiEndpoint'];

      if (number.isEmpty) {
        // ถ้าหมายเลขค้นหาว่าง ให้โหลดข้อมูลทั้งหมด
        await getData();
      } else {
        // ค้นหาตามหมายเลขที่ป้อนและ uid
        var searchUrl = Uri.parse(
            '$url/user/searchresult?number=$number&uid=${widget.uid}');
        var response = await http.get(searchUrl);
        var v = userMyresultResponeFromJson(response.body);
        log(v.result[0].lottoid.toString());

        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);

          // สมมุติว่า message เก็บข้อความที่คุณต้องการตรวจสอบ
          if (responseBody['message'] == 'รางวัลที่ 1') {
            log('รางวัลที่1');
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('ผลการค้นหา'),
                  content: Text('ถูกรางวัลที่ 1'),
                  actions: [
                    Row(
                      children: [
                        FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: Color.fromARGB(
                                  255, 0, 10, 103), // สีพื้นหลังของปุ่ม
                              foregroundColor: Colors.white, // สีข้อความบนปุ่ม
                              padding: EdgeInsets.only(left: 10, right: 10),
                              textStyle: TextStyle(fontSize: 16), // ขนาดข้อความ
                              elevation: 15),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultPage(
                                    uid: widget.uid,
                                    lottoid: v.result[0].lottoid),
                              ),
                            );
                          },
                          child: Text(
                            'ขึ้นเงินรางวัล',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          child: Text('ตกลง'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          } else if (responseBody['message'] == 'รางวัลที่ 2') {
            log('รางวัลที่2');
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('ผลการค้นหา'),
                  content: Text('ถูกรางวัลที่2'),
                  actions: [
                    Row(
                      children: [
                        FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: Color.fromARGB(
                                  255, 0, 10, 103), // สีพื้นหลังของปุ่ม
                              foregroundColor: Colors.white, // สีข้อความบนปุ่ม
                              padding: EdgeInsets.only(left: 10, right: 10),
                              textStyle: TextStyle(fontSize: 16), // ขนาดข้อความ
                              elevation: 15),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultPage(
                                    uid: widget.uid,
                                    lottoid: v.result[0].lottoid),
                              ),
                            );
                          },
                          child: Text(
                            'ขึ้นเงินรางวัล',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          child: Text('ตกลง'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          } else if (responseBody['message'] == 'รางวัลที่ 3') {
            log('รางวัลที่3');
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('ผลการค้นหา'),
                  content: Text('ถูกรางวัลที่ 3'),
                  actions: [
                    Row(
                      children: [
                        FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: Color.fromARGB(
                                  255, 0, 10, 103), // สีพื้นหลังของปุ่ม
                              foregroundColor: Colors.white, // สีข้อความบนปุ่ม
                              padding: EdgeInsets.only(left: 10, right: 10),
                              textStyle: TextStyle(fontSize: 16), // ขนาดข้อความ
                              elevation: 15),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultPage(
                                    uid: widget.uid,
                                    lottoid: v.result[0].lottoid),
                              ),
                            );
                          },
                          child: Text(
                            'ขึ้นเงินรางวัล',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          child: Text('ตกลง'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          } else if (responseBody['message'] == 'รางวัลที่ 4') {
            log('รางวัลที่4');
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('ผลการค้นหา'),
                  content: Text('ถูกรางวัลที่ 4'),
                  actions: [
                    Row(
                      children: [
                        FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: Color.fromARGB(
                                  255, 0, 10, 103), // สีพื้นหลังของปุ่ม
                              foregroundColor: Colors.white, // สีข้อความบนปุ่ม
                              padding: EdgeInsets.only(left: 10, right: 10),
                              textStyle: TextStyle(fontSize: 16), // ขนาดข้อความ
                              elevation: 15),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultPage(
                                    uid: widget.uid,
                                    lottoid: v.result[0].lottoid),
                              ),
                            );
                          },
                          child: Text(
                            'ขึ้นเงินรางวัล',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          child: Text('ตกลง'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          } else if (responseBody['message'] == 'รางวัลที่ 5') {
            log('รางวัลที่5');
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('ผลการค้นหา'),
                  content: Text('ถูกรางวัลที่ 5'),
                  actions: [
                    Row(
                      children: [
                        FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: Color.fromARGB(
                                  255, 0, 10, 103), // สีพื้นหลังของปุ่ม
                              foregroundColor: Colors.white, // สีข้อความบนปุ่ม
                              padding: EdgeInsets.only(left: 10, right: 10),
                              textStyle: TextStyle(fontSize: 16), // ขนาดข้อความ
                              elevation: 15),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultPage(
                                    uid: widget.uid,
                                    lottoid: v.result[0].lottoid),
                              ),
                            );
                          },
                          child: Text(
                            'ขึ้นเงินรางวัล',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          child: Text('ตกลง'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          } else {
            log('ไม่ถูกรางวัล');
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('ผลการค้นหา'),
                  content: Text('ไม่ถูกรางวัล'),
                  actions: [
                    TextButton(
                      child: Text('ตกลง'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('คุณไม่ได้ซื้อลอตโต้นี้'),
                content: Text('โปรดเช็คลอตโต้ของคุณ'),
                actions: [
                  TextButton(
                    child: Text('ตกลง'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          log('Request failed with status: ${response.statusCode}.');
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('คุณไม่ได้ซื้อลอตโต้นี้'),
            content: Text('โปรดเช็คลอตโต้ของคุณ'),
            actions: [
              TextButton(
                child: Text('ตกลง'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      log('Error occurred: $e');
    }
  }

  //โหลดข้อมูล
  Future<void> loadDataAsync() async {
    await Future.delayed(const Duration(seconds: 1), () => print("AAA"));
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var value = await http.get(Uri.parse(("$url/get/${widget.uid}")));
    user = userlGetUidResponeFromJson(value.body);
    log(widget.uid.toString());
  }

  Future<void> getData() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    var response =
        await http.get(Uri.parse('$url/user/check-uidfk/${widget.uid}'));
    log(response.body);
    getnumber = userMyLottoResponeFromJson(response.body);
  }

  Future<void> loaddatanumber() async {
    await Future.delayed(const Duration(seconds: 1), () => print("AAA"));
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var number = await http.get(Uri.parse(("$url/number_lotto/getnumber")));
    num = numberGetResponeFromJson(number.body);
  }
}
