import 'dart:convert';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:project/pages/home.dart';
import 'package:project/config/config.dart';
import 'package:project/models/respone/number_get_res.dart';

class BuyPage extends StatefulWidget {
  int uid = 0;
  BuyPage({super.key, required this.uid});

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  late Future<void> loadData;
  List<NumberGetRespone> getnumber = [];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // ทำให้ AppBar อยู่บนภาพพื้นหลัง
      appBar: AppBar(
        backgroundColor: Colors.transparent, // ทำให้ AppBar โปร่งใส
        elevation: 0, // ไม่มีเงา
        iconTheme: const IconThemeData(color: Colors.white),
       
      ),
      body: Stack(
        children: [
            Image.asset(
            "assets/images/bg1.jpg",
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
           const Padding(
            padding: EdgeInsets.fromLTRB(50, 45, 20, 0),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 55),
                  child: Text(
                    'เลือกซื้อลอตโต้',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
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
                  'กรอกเลขลอตเตอร์รี่ที่ต้องการซื้อ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
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
                                  width: 44,
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
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 232, 56),
                            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            textStyle: const TextStyle(fontSize: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8.0), // มุมโค้งของปุ่ม
                            ),
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
                      const SizedBox(height: 10),
                      Text(
                        searchStatus,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "ลอตโต้งวดนี้",
                                style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        const Color.fromARGB(255, 0, 10, 103),
                                    fontWeight: FontWeight.bold),
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
          
          Padding(
            padding: const EdgeInsets.only(top: 300),
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
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: SizedBox(
                                      width: 350,
                                      height: 160,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: e.uidFk == null
                                              ? Colors.white
                                              : Colors
                                                  .grey, // เปลี่ยนสีพื้นหลัง
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Text(
                                                      e.uidFk == null
                                                          ? 'เหลืออยู่'
                                                          : 'ขายแล้ว',
                                                      style: TextStyle(
                                                        color: e.uidFk == null
                                                            ? const Color.fromARGB(
                                                                255, 8, 198, 2)
                                                            : const Color.fromARGB(
                                                                255, 255, 0, 0),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: const Color.fromARGB(
                                                            255, 0, 10, 103),
                                                        borderRadius:
                                                            const BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 1,
                                                            blurRadius: 1,
                                                            offset:
                                                                const Offset(0, 1),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Image.asset(
                                                          'assets/images/logo.png'),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${e.price} บาท',
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 10, 103),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width:40),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: Column(
                                                  children: [
                                                    const Text(
                                                      'LOTTO CLICK',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 190,
                                                      height: 50,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color.fromARGB(
                                                              255, 0, 10, 103),
                                                          borderRadius:
                                                              const BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.3),
                                                              spreadRadius: 1,
                                                              blurRadius: 1,
                                                              offset:
                                                                  const Offset(0, 1),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              e.number,
                                                              style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 30,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    if (e.uidFk == null)
                                                      // ซ่อนปุ่มเลือกถ้าขายแล้ว
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 15),
                                                          child: FilledButton(
                                                            style: FilledButton
                                                                .styleFrom(
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          232,
                                                                          56),
                                                              foregroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              textStyle:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          14),
                                                            ),
                                                            onPressed: () {
                                                              showPurchaseDialog(
                                                                  e); // เรียกใช้ dialog เมื่อกดปุ่มซื้อ
                                                            },
                                                            child: const Text(
                                                              'ซื้อ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
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
    );
  }

  void showPurchaseDialog(NumberGetRespone number) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            'ยืนยันการซื้อ',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          content: Text(
              'คุณต้องการซื้อเลข ${number.number} \nในราคา ${number.price} บาทหรือไม่?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  child: const Text('ยกเลิก',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 10, 103),
                      )),
                  onPressed: () {
                    Navigator.of(context).pop(); // ปิด popup เมื่อกดยกเลิก
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 0, 10, 103),
                        width: 2.0), // สีและความหนาของเส้นขอบ
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // มุมโค้งของปุ่ม
                    ),
                  ),
                ),
                FilledButton(
                  child: const Text('ยืนยัน'),
                  style: FilledButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 10, 103),
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // มุมโค้งของปุ่ม
                      ),
                      elevation: 5),
                  onPressed: () {
                    // ส่งค่า lottoid และ uid ไปที่ API เมื่อยืนยันการซื้อ
                    buylotto(number.lottoid, widget.uid);
                    Navigator.of(context).pop(); // ปิด popup หลังจากยืนยัน
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void buylotto(int lottoid, int uid) async {
    try {
      var config = await Configuration.getConfig();
      var url = config['apiEndpoint'];

      var response = await http.put(
        Uri.parse('$url/number_lotto/update-uid-fk'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'lottoid': lottoid,
          'uid_fk': uid,
        }),
      );

      if (response.statusCode == 200) {
        log('Purchase success: ${response.body}');

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(
                  child: Text(
                'ซื้อลอตโต้สำเร็จ',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              content: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ชอให้โชคดี'),
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
                        Navigator.of(context).pop(); // ปิด popup หลังจากยืนยัน
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
        await getData();
        setState(() {});
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(
                  child: Text(
                'ยอดเงินไม่เพียงพอ',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              content: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('กรุณาเติมเงิน'),
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
                        Navigator.of(context).pop(); // ปิด popup หลังจากยืนยัน
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
        log('Failed to purchase: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred: $e');
    }
  }

  Future<void> getData() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    var response = await http.get(Uri.parse('$url/number_lotto/getallnumber'));
    log(response.body);

    getnumber = numberGetResponeFromJson(response.body);
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
        // ค้นหาตามหมายเลขที่ป้อน
        var searchUrl =
            Uri.parse('$url/number_lotto/searchnumber?number=$number');
        var response = await http.get(searchUrl);

        if (response.statusCode == 200) {
          log(response.body);
          List<NumberGetRespone> results =
              numberGetResponeFromJson(response.body);
          setState(() {
            if (results.isEmpty) {
              searchStatus = 'ไม่มีเลขนี้';
              // แสดง SnackBar ถ้าไม่พบหมายเลข
            } else {
              getnumber = results;
              searchStatus = ''; // รีเซ็ตข้อความสถานะเมื่อพบหมายเลข
            }
          });
        } else {
          log('Request failed with status: ${response.statusCode}.');
          setState(() {
            searchStatus = 'เกิดข้อผิดพลาด'; // แสดงข้อความเมื่อเกิดข้อผิดพลาด
          });
        }
      }
    } catch (e) {
      log('Error occurred: $e');
    }
  }
}
