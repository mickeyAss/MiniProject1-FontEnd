import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/config/config.dart';
import 'package:project/models/respone/number_get_res.dart';

class AdminResultPage extends StatefulWidget {
  const AdminResultPage({super.key});

  @override
  State<AdminResultPage> createState() => _AdminResultPageState();
}

class _AdminResultPageState extends State<AdminResultPage> {
  String selectedValue = 'รางวัลที่ 1'; // ค่าเริ่มต้น

  late Future<void> loadLotto;
  List<NumberGetRespone> getnumber = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLotto = getdataLotto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // รูปพื้นหลัง
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Blue.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // เนื้อหาหลัก
          Column(
            children: [
              // AppBar
              Container(
                color: Colors.transparent, // ทำให้ AppBar โปร่งใส
                child: AppBar(
                  backgroundColor: Colors.transparent, // ทำให้ AppBar โปร่งใส
                  elevation: 0, // ไม่มีเงา
                  iconTheme: IconThemeData(color: Colors.white),
                  title: Text(
                    'ย้อนกลับ',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            height:
                                5), // เพิ่มช่องว่างด้านบนเพื่อให้ไม่ทับ AppBar
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 15),
                          child: Column(
                            children: [
                              Text(
                                'ทำการออกรางวัล',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // จัดตำแหน่งให้มีช่องว่างระหว่างปุ่ม
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 207,
                                            207, 207), // กำหนดสีเทาสำหรับปุ่ม
                                        borderRadius: BorderRadius.circular(
                                            20), // ทำให้มุมมน
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 0), // ลดขนาด padding
                                      child: DropdownButtonHideUnderline(
                                        // ซ่อนเส้นใต้ของ DropdownButton
                                        child: DropdownButton<String>(
                                          value: selectedValue,
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedValue = newValue!;
                                            });
                                          },
                                          items: [
                                            'รางวัลที่ 1',
                                            'รางวัลที่ 2',
                                            'รางวัลที่ 3',
                                            'รางวัลที่ 4',
                                            'รางวัลที่ 5'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          isExpanded: true,
                                          style: TextStyle(color: Colors.black),
                                          dropdownColor: Colors.white,
                                          icon: Icon(Icons.arrow_drop_down,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: 10), // เพิ่มช่องว่างระหว่างปุ่ม
                                  Expanded(
                                    child: FilledButton(
                                      style: FilledButton.styleFrom(
                                        backgroundColor: Color.fromARGB(255,
                                            255, 232, 56), // สีพื้นหลังของปุ่ม
                                        foregroundColor: const Color.fromARGB(
                                            255, 0, 0, 0), // สีข้อความบนปุ่ม
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                9), // ปรับ padding ให้เหมาะสม
                                        textStyle: TextStyle(
                                            fontSize: 16), // ขนาดข้อความ
                                        elevation: 15,
                                      ),
                                      onPressed: result,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.change_circle_outlined,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          Text(
                                            'ทำการออกรางวัล',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 350,
                          height: 400,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(0, 1))
                                ]),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    'ผลการออกรางวัล',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 40, right: 40),
                                        child: FutureBuilder(
                                          future: loadLotto,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState !=
                                                ConnectionState.done) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }

                                            if (getnumber.isEmpty) {
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

                                            // แยกข้อมูลตามคอลัมน์
                                            List<Widget> column1 = [];
                                            List<Widget> column2 = [];
                                            List<Widget> column3 = [];

                                            for (var e in getnumber) {
                                              if (e.result == 'รางวัลที่ 2' ||
                                                  e.result == 'รางวัลที่ 4') {
                                                column1.add(Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 40),
                                                  child: Column(
                                                    children: [
                                                      Text(e.result),
                                                      Text(
                                                        e.number,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(height: 10),
                                                    ],
                                                  ),
                                                ));
                                              } else if (e.result ==
                                                  'รางวัลที่ 1') {
                                                column2.add(Column(
                                                  children: [
                                                    Text(e.result),
                                                    Text(
                                                      e.number,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 10),
                                                  ],
                                                ));
                                              } else {
                                                column3.add(Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 40),
                                                  child: Column(
                                                    children: [
                                                      Text(e.result),
                                                      Text(
                                                        e.number,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(height: 10),
                                                    ],
                                                  ),
                                                ));
                                              }
                                            }

                                            return Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: column1,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                    ],
                                  ),
                                ),
                              ],
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
        ],
      ),
    );
  }

  void result() async {
    try {
      var config = await Configuration.getConfig();
      var url = config['apiEndpoint'];

      var response = await http.put(
        Uri.parse('$url/number_lotto/update-result'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'result': selectedValue, // ส่งฟิลด์ 'result' ไปยัง API
        }),
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // รีเฟรชข้อมูลหลังการออกรางวัล
        setState(() {
          loadLotto = getdataLotto(); // รีเฟรช Future ที่ใช้ใน FutureBuilder
        });

        // แสดง AlertDialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                  child: Text(
                'ออก${selectedValue} เรียบร้อย',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton(
                      child: Text('ตกลง'),
                      style: FilledButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 10, 103),
                          foregroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          textStyle: TextStyle(fontSize: 14),
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
      } else if (response.statusCode == 400 &&
          response.body.contains('Duplicate result detected.')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('รางวัลนี้ถูกออกรางวัลไปแล้ว')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ไม่มีเลขลอตโต้ให้ออกรางวัล')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
      );
      log('Exception: $e');
    }
  }

  Future<void> getdataLotto() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];
    var res = await http.get(Uri.parse('$url/number_lotto/getnumber'));
    log(res.body);
    getnumber = numberGetResponeFromJson(res.body);

    // Log the 'result' field for each item in getnumber
    for (var number in getnumber) {
      log(number.result.toString());
    }
  }
}
