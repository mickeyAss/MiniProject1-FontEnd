import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/config/config.dart';
import 'package:project/models/respone/number_get_res.dart';
import 'package:project/models/respone/user_get_uid_res.dart';
import 'package:project/models/respone/user_my_lotto_res.dart';

class MyLottoPage extends StatefulWidget {
  int uid = 0;
  MyLottoPage({super.key, required this.uid});

  @override
  State<MyLottoPage> createState() => _MyLottoPageState();
}

class _MyLottoPageState extends State<MyLottoPage> {
  late Future<void> loadData;
  List<UserMyLottoRespone> getnumber = [];
  List<TextEditingController> searchControllers =
      List.generate(6, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  String searchStatus = ''; // ใช้สำหรับเก็บข้อความสถานะของการค้นหา

  final GlobalKey<State<StatefulWidget>> _sizedBoxKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    loadData = getData();
  }

  Future<void> _refreshData() async {
    setState(() {
      loadData = getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child:  Stack(
        children: [
          Image.asset(
            "assets/images/bg1.jpg",
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
           const Padding(
            padding: EdgeInsets.fromLTRB(20, 45, 20, 0),
            child: Row(
              children: [
              
                Text(
                  'LOTTO CLICK',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90),
            child: Column(
              children: [
                const Text(
                  'กรอกเลขลอตเตอร์รี่ของคุณ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                     ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: List.generate(6, (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: SizedBox(
                                  width: 46,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: searchControllers[index],
                                      focusNode: focusNodes[index],
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      maxLength: 1,
                                      decoration: const InputDecoration(
                                        counterText: '',
                                        hintStyle:
                                            TextStyle(color: Colors.black54),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        if (value.length == 0) {
                                          // If the value is empty, move focus to the previous field
                                          if (index > 0) {
                                            FocusScope.of(context).requestFocus(
                                                focusNodes[index - 1]);
                                          }
                                        } else if (value.length == 1) {
                                          // Move focus to the next field if not the last field
                                          if (index < 5) {
                                            FocusScope.of(context).requestFocus(
                                                focusNodes[index + 1]);
                                          } else {
                                            // Unfocus on the last field
                                            FocusScope.of(context).unfocus();
                                          }
                                        }
                                      },
                                      onTap: () {
                                        if (index > 0 &&
                                            searchControllers[index - 1]
                                                .text
                                                .isEmpty) {
                                          // Prevent focus on current field if previous fields are empty
                                          FocusScope.of(context).requestFocus(
                                              focusNodes[index - 1]);
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
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.amber,
                            foregroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            elevation: 15,
                          ),
                          onPressed: () {
                            String searchQuery = searchControllers
                                .map((controller) => controller.text)
                                .join();
                            searchNumber(searchQuery);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ค้นหาลอตเตอร์รี่',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "ลอตโต้ทั้งหมดของคุณ",
                              style: TextStyle(
                                  fontSize: 18,
                                   color: const Color.fromARGB(
                                                            255, 0, 10, 103),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: FutureBuilder(
                                    future: loadData,
                                    builder: (context, snapshot) {
                                      return SingleChildScrollView(
                                        child: Column(
                                            children: getnumber
                                                .map(
                                                  (e) => Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20,
                                                                right: 20),
                                                        child: SizedBox(
                                                          width: 350,
                                                          height: 160,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            20)),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.3),
                                                                      spreadRadius:
                                                                          1,
                                                                      blurRadius:
                                                                          1,
                                                                      offset:
                                                                          const Offset(
                                                                              0,
                                                                              1))
                                                                ]),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      20.0),
                                                              child: Row(
                                                                children: [
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left: 10),
                                                                        child: SizedBox(
                                                                          width:
                                                                              50,
                                                                          height:
                                                                              50,
                                                                          child: Container(
                                                                              decoration: BoxDecoration(color: const Color.fromARGB(255, 0, 10, 103), borderRadius: const BorderRadius.all(Radius.circular(20)), boxShadow: [
                                                                                BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1))
                                                                              ]),
                                                                              child: Image.asset('assets/images/logo.png')),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 40,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        top: 6),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        const Text(
                                                                          'LOTTO CLICK',
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 20),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              190,
                                                                          height:
                                                                              50,
                                                                          child: Container(
                                                                              decoration: BoxDecoration(color: const Color.fromARGB(255, 0, 10, 103), borderRadius: const BorderRadius.all(Radius.circular(15)), boxShadow: [
                                                                                BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1))
                                                                              ]),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                                    e.number,
                                                                                    style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                                                                                  )
                                                                                ],
                                                                              )),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      )
                                                    ],
                                                  ),
                                                )
                                                .toList()),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Future<void> getData() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    var response =
        await http.get(Uri.parse('$url/user/check-uidfk/${widget.uid}'));
    log(response.body);
    getnumber = userMyLottoResponeFromJson(response.body);
  }

  Future<void> searchNumber(String number) async {
    try {
      var config = await Configuration.getConfig();
      var url = config['apiEndpoint'];

      if (number.isEmpty) {
        // ถ้าหมายเลขค้นหาว่าง ให้โหลดข้อมูลทั้งหมด
        await getData();
        setState(() {
          searchStatus = ''; // รีเซ็ตข้อความสถานะเมื่อค้นหาว่าง
        });
      } else {
        // ค้นหาตามหมายเลขที่ป้อนและ uid
        var searchUrl = Uri.parse(
            '$url/user/searchnumber?number=$number&uid=${widget.uid}');
        var response = await http.get(searchUrl);

        if (response.statusCode == 200) {
          log(response.body);
          List<UserMyLottoRespone> results =
              userMyLottoResponeFromJson(response.body);
          setState(() {
            if (results.isEmpty) {
              searchStatus = 'ไม่มีเลขนี้';
            } else {
              getnumber = results;
              searchStatus = ''; // รีเซ็ตข้อความสถานะเมื่อพบหมายเลข
            }
          });
        } else {
          log('Request failed with status: ${response.statusCode}.');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Center(
                    child: Text(
                  'โปรดกรอกเลขลอตโต้อื่น',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                content: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('คุณไม่ได้ซื้อเลขนี้'),
                  ],
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        child: const Text('ตกลง'),
                        style: FilledButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 0, 10, 103),
                            foregroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            textStyle: const TextStyle(fontSize: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8.0), // มุมโค้งของปุ่ม
                            ),
                            elevation: 5),
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
      }
    } catch (e) {
      log('Error occurred: $e');
    }
  }
}
