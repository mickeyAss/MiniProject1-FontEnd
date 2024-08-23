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
  String url = "";
  late UserlGetUidRespone user;
  List<NumberGetRespone> num = [];
  late Future<void> loadData;
  late Future<void> loadnum;
  List<UserMyLottoRespone> getnumber = [];

  List<TextEditingController> searchControllers =
      List.generate(6, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  int _selectedIndex = 0;

  @override
  void initState() {
    log(widget.uid.toString());
    super.initState();
    loadData = loadDataAsync();
    loadnum = loaddatanumber();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 2) {
        // รีเฟรชหน้า WalletPage
        loadData = loadDataAsync(); // เรียกฟังก์ชันโหลดข้อมูลใหม่
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // หน้าแรก
          buildHomePage(),

          MyLottoPage(uid: widget.uid),

          WalletPage(uid: widget.uid)
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'หน้าแรก',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.stay_primary_landscape_sharp),
              label: 'ลอตโต้ของฉัน',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet),
              label: 'เป๋าตังค์',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 0, 10, 103),
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget buildHomePage() {
    return SingleChildScrollView(
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
                            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            child: ClipOval(
                                              child: Image.network(
                                                user.image,
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.cover,
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
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: List.generate(6, (index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: SizedBox(
                                              width: 45,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: TextField(
                                                  controller:
                                                      searchControllers[index],
                                                  focusNode: focusNodes[index],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textAlign: TextAlign.center,
                                                  maxLength: 1,
                                                  decoration:
                                                      const InputDecoration(
                                                    counterText: '',
                                                    hintStyle: TextStyle(
                                                        color: Colors.black54),
                                                    border: InputBorder.none,
                                                  ),
                                                  onChanged: (value) {
                                                    if (value.length == 0) {
                                                      // If the value is empty, move focus to the previous field
                                                      if (index > 0) {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                focusNodes[
                                                                    index - 1]);
                                                      }
                                                    } else if (value.length ==
                                                        1) {
                                                      // Move focus to the next field if not the last field
                                                      if (index < 5) {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                focusNodes[
                                                                    index + 1]);
                                                      } else {
                                                        // Unfocus on the last field
                                                        FocusScope.of(context)
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
                                                                  index - 1]);
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
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: FilledButton(
                                          style: FilledButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 0, 10, 103),
                                            foregroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 255, 255),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            textStyle:
                                                const TextStyle(fontSize: 14),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8.0), // มุมโค้งของปุ่ม
                                            ),
                                            elevation: 15,
                                          ),
                                          onPressed: () {
                                            String searchQuery =
                                                searchControllers
                                                    .map((controller) =>
                                                        controller.text)
                                                    .join();
                                            searchNumber(searchQuery);
                                          },
                                          child: const Text(
                                            'ตรวจเลขลอตโต้',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 50, 0, 0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15), // ขอบมน
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
                                            padding: const EdgeInsets.fromLTRB(
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
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 25, 0, 0),
                                                    child: FilledButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    BuyPage(
                                                                        uid: widget
                                                                            .uid),
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
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(150, 0, 0, 0),
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
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 220,
            width: 360,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 14),
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
                        padding:
                            const EdgeInsets.only(left: 40, right: 40, top: 20),
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
                              return const Center(
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
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ));
                              } else if (e.result == 'รางวัลที่ 1') {
                                column2.add(Column(
                                  children: [
                                    Text(e.result),
                                    Text(
                                      e.number,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
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
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ));
                              }
                            }

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
    );
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
                  content: SizedBox(
                    width: 300, // ปรับขนาดความกว้างที่นี่
                    height: 350, // ปรับขนาดความสูงที่นี่
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: 200,
                              height: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 10, 103),
                                  borderRadius: BorderRadius.circular(
                                      15), // ปรับค่าขอบมนที่นี่
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${v.result[0].number}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                              height: 10), // เว้นระยะห่างระหว่างข้อความและปุ่ม

                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  '${v.result[0].result}',
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 10, 103),
                                  ),
                                ),
                                const Text(
                                  "ขอแสดงความยินดี",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 10, 103),
                                    fontSize: 18,
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/happy.png",
                                  width: 170,
                                  height: 170,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 255, 207, 15), // สีพื้นหลังของปุ่ม
                              foregroundColor: Colors.white, // สีข้อความบนปุ่ม
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              textStyle:
                                  const TextStyle(fontSize: 16), // ขนาดข้อความ
                              elevation: 18),
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
                          child: const Text(
                            'ขึ้นเงินรางวัล',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          child: const Text('ตกลง'),
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
                  content: SizedBox(
                    width: 300, // ปรับขนาดความกว้างที่นี่
                    height: 350, // ปรับขนาดความสูงที่นี่
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: 200,
                              height: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 10, 103),
                                  borderRadius: BorderRadius.circular(
                                      15), // ปรับค่าขอบมนที่นี่
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${v.result[0].number}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                              height: 10), // เว้นระยะห่างระหว่างข้อความและปุ่ม

                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  '${v.result[0].result}',
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 10, 103),
                                  ),
                                ),
                                const Text(
                                  "ขอแสดงความยินดี",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 10, 103),
                                    fontSize: 18,
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/happy.png",
                                  width: 170,
                                  height: 170,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 255, 207, 15), // สีพื้นหลังของปุ่ม
                              foregroundColor: Colors.white, // สีข้อความบนปุ่ม
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              textStyle:
                                  const TextStyle(fontSize: 16), // ขนาดข้อความ
                              elevation: 18),
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
                          child: const Text(
                            'ขึ้นเงินรางวัล',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          child: const Text('ตกลง'),
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
                  content: SizedBox(
                    width: 300, // ปรับขนาดความกว้างที่นี่
                    height: 350, // ปรับขนาดความสูงที่นี่
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: 200,
                              height: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 10, 103),
                                  borderRadius: BorderRadius.circular(
                                      15), // ปรับค่าขอบมนที่นี่
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${v.result[0].number}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                              height: 10), // เว้นระยะห่างระหว่างข้อความและปุ่ม

                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  '${v.result[0].result}',
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 10, 103),
                                  ),
                                ),
                                const Text(
                                  "ขอแสดงความยินดี",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 10, 103),
                                    fontSize: 18,
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/happy.png",
                                  width: 170,
                                  height: 170,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 255, 207, 15), // สีพื้นหลังของปุ่ม
                              foregroundColor: Colors.white, // สีข้อความบนปุ่ม
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              textStyle:
                                  const TextStyle(fontSize: 16), // ขนาดข้อความ
                              elevation: 18),
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
                          child: const Text(
                            'ขึ้นเงินรางวัล',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          child: const Text('ตกลง'),
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
                  content: SizedBox(
                    width: 300, // ปรับขนาดความกว้างที่นี่
                    height: 350, // ปรับขนาดความสูงที่นี่
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: 200,
                              height: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 10, 103),
                                  borderRadius: BorderRadius.circular(
                                      15), // ปรับค่าขอบมนที่นี่
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${v.result[0].number}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                              height: 10), // เว้นระยะห่างระหว่างข้อความและปุ่ม

                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  '${v.result[0].result}',
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 10, 103),
                                  ),
                                ),
                                const Text(
                                  "ขอแสดงความยินดี",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 10, 103),
                                    fontSize: 18,
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/happy.png",
                                  width: 170,
                                  height: 170,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 255, 207, 15), // สีพื้นหลังของปุ่ม
                              foregroundColor: Colors.white, // สีข้อความบนปุ่ม
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              textStyle:
                                  const TextStyle(fontSize: 16), // ขนาดข้อความ
                              elevation: 18),
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
                          child: const Text(
                            'ขึ้นเงินรางวัล',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          child: const Text('ตกลง'),
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
                  content: SizedBox(
                    width: 300, // ปรับขนาดความกว้างที่นี่
                    height: 350, // ปรับขนาดความสูงที่นี่
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: 200,
                              height: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 10, 103),
                                  borderRadius: BorderRadius.circular(
                                      15), // ปรับค่าขอบมนที่นี่
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${v.result[0].number}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                              height: 10), // เว้นระยะห่างระหว่างข้อความและปุ่ม
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  '${v.result[0].result}',
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 10, 103),
                                  ),
                                ),
                                const Text(
                                  "ขอแสดงความยินดี",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 10, 103),
                                    fontSize: 18,
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/happy.png",
                                  width: 170,
                                  height: 170,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 255, 207, 15), // สีพื้นหลังของปุ่ม
                              foregroundColor: Colors.white, // สีข้อความบนปุ่ม
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              textStyle:
                                  const TextStyle(fontSize: 16), // ขนาดข้อความ
                              elevation: 18),
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
                          child: const Text(
                            'ขึ้นเงินรางวัล',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          child: const Text('ตกลง'),
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
                  content: SizedBox(
                    width: 300, // ปรับขนาดความกว้างที่นี่
                    height: 350, // ปรับขนาดความสูงที่นี่
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: 200,
                              height: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 10, 103),
                                  borderRadius: BorderRadius.circular(
                                      15), // ปรับค่าขอบมนที่นี่
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${v.result[0].number}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                              height: 10), // เว้นระยะห่างระหว่างข้อความและปุ่ม

                          SingleChildScrollView(
                            child: Column(
                              children: [
                                const Text(
                                  'ไม่ถูกรางวัล',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 10, 103),
                                  ),
                                ),
                                const Text(
                                  "ขอแสดงความเสียใจ",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 10, 103),
                                    fontSize: 18,
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/sad.png",
                                  width: 200,
                                  height: 200,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.indigo.shade900,
                          ),
                          child: const Text(
                            'ตกลง',
                            style: TextStyle(fontSize: 20),
                          ),
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
          }
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'คุณยังไม่ได้ซื้อลอตโต้เลขนี้',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 10, 103)),
                      ),
                      Text(
                        'กร6ณาซื้อลอตโต้เพื่อตรวจรางวัล',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 10, 103)),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.indigo.shade900,
                        ),
                        child: const Text('ซื้อลอตโต้'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BuyPage(
                                        uid: widget.uid,
                                      )));
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'ตกลง',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 10, 103),
                          ),
                        ),
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
          log('Request failed with status: ${response.statusCode}.');
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              width: 300,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'คุณยังไม่ได้ซื้อลอตโต้เลขนี้',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 10, 103)),
                  ),
                  const Text(
                    'กรุณาซื้อลอตโต้เพื่อตรวจรางวัล',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 0, 10, 103)),
                  ),
                  Image.asset(
                    "assets/images/um.png",
                    width: 80,
                    height: 80,
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 10, 103),
                    ),
                    child: const Text('ซื้อลอตโต้'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyPage(
                                    uid: widget.uid,
                                  )));
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'ตกลง',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 10, 103),
                      ),
                    ),
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
      log('Error occurred: $e');
    }
  }

  //โหลดข้อมูล
  Future<void> loadDataAsync() async {
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
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var number = await http.get(Uri.parse(("$url/number_lotto/getnumber")));
    num = numberGetResponeFromJson(number.body);
  }
}
