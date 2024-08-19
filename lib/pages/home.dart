import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/buy.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/wallet.dart';
import 'package:project/pages/mylotto.dart';
import 'package:project/config/config.dart';
import 'package:project/pages/profile.dart';
import 'package:project/models/respone/number_get_res.dart';
import 'package:project/models/respone/user_get_uid_res.dart';

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
        body: FutureBuilder(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(6, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: SizedBox(
                                        width: 45,
                                        height:
                                            45, // เพิ่มความสูงของช่องข้อความ
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          maxLength: 1,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 22,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            counterText: "",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical:
                                                        6), // ปรับช่องว่างภายใน
                                          ),
                                          onChanged: (value) {
                                            if (value.length == 1 &&
                                                index < 5) {
                                              FocusScope.of(context)
                                                  .nextFocus(); //ถ้าสถานะข้างต้นเป็นจริง, โฟกัสจะย้ายไปที่ช่องถัดไปโดยอัตโนมัติ
                                            }
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    DropdownButton<String>(
                                      value: selectedDate,
                                      hint: const Text(
                                        'งวดประจำวันที่',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                      ),
                                      iconEnabledColor: Colors
                                          .white, // สีของไอคอนเมื่อ dropdown เปิดใช้งาน
                                      iconDisabledColor: Colors.indigo
                                          .shade900, // สีของไอคอนเมื่อ dropdown ปิดใช้งาน
                                      elevation: 16,
                                      style: const TextStyle(
                                          color:
                                              Colors.white), // สีข้อความในปุ่ม
                                      dropdownColor: Colors.indigo
                                          .shade900, // สีพื้นหลังของ dropdown
                                      underline: Container(
                                        height: 2,
                                        color: Colors
                                            .blueAccent, // สีเส้นใต้ของ dropdown
                                      ),
                                      items: date.map((String date) {
                                        return DropdownMenuItem<String>(
                                          value: date,
                                          child: Text(date),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedDate = newValue!;
                                        });
                                      },
                                    ),
                                    FilledButton(
                                      onPressed: () {},
                                      style: FilledButton.styleFrom(
                                          backgroundColor:
                                              Colors.indigo.shade900),
                                      child: const Text(
                                        'ตรวจเลขลอตโต้',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
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
                                                  padding: EdgeInsets.fromLTRB(
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
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 25, 0, 0),
                                                  child: FilledButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const BuyPage(),
                                                            ));
                                                      },
                                                      style: FilledButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors.amber),
                                                      child: const Text(
                                                        'คลิกเลย',
                                                        style: TextStyle(
                                                            fontSize: 32,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
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
                              FutureBuilder(
                                  future: loadnum,
                                  builder: (context, snapshot) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Column(
                                        children: num.map((numm) {
                                          return Card(
                                            child: SizedBox(
                                              width: 400,
                                              height: 240,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 10, 20, 0),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "ผลรางวัลสลาก",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const Text(
                                                          "งวดประจำวันที่ 1 สิงหาคม 2567"),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text(
                                                                numm.result,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .amber),
                                                              ),
                                                              Text(
                                                                numm.number,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        22,
                                                                    color: Colors
                                                                        .amber,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text(
                                                                numm.result,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Text(
                                                                numm.number,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        22,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                numm.result,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Text(
                                                                numm.number,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        22,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 5, 0, 0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  numm.result,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                  numm.number,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          22,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  numm.result,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                  numm.number,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          22,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
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

  //โหลดข้อมูล
  Future<void> loadDataAsync() async {
    await Future.delayed(const Duration(seconds: 1), () => print("AAA"));
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var value = await http.get(Uri.parse(("$url/get/${widget.uid}")));
    user = userlGetUidResponeFromJson(value.body);
    log(widget.uid.toString());
  }

  Future<void> loaddatanumber() async {
    await Future.delayed(const Duration(seconds: 1), () => print("AAA"));
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var number = await http.get(Uri.parse(("$url/number_lotto/getnumber")));
    num = numberGetResponeFromJson(number.body);
  }
}
