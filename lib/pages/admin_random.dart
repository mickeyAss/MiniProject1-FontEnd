import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/config/config.dart';
import 'package:project/models/respone/lottonumber_get_res.dart';

class AdminRandomPages extends StatefulWidget {
  AdminRandomPages({super.key});

  @override
  State<AdminRandomPages> createState() => _AdminRandomPagesState();
}

class _AdminRandomPagesState extends State<AdminRandomPages> {
  List<String> randomNumbers = [];

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
                    'Lotto click',
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
                        Text(
                          'หมุนลอตโต้',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 350,
                          height: 320,
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
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Text('ทำการหมุนลอตโต้เพื่อออกขาย',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 0, 10, 103),
                                          )),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/fortune-wheel (1).png',
                                  width: 170,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FilledButton(
                                  style: FilledButton.styleFrom(
                                      backgroundColor: Color.fromARGB(
                                          255, 0, 10, 103), // สีพื้นหลังของปุ่ม
                                      foregroundColor:
                                          Colors.white, // สีข้อความบนปุ่ม
                                      padding:
                                          EdgeInsets.only(left: 50, right: 50),
                                      textStyle: TextStyle(
                                          fontSize: 16), // ขนาดข้อความ
                                      elevation: 15),
                                  onPressed: randomnumber,
                                  child: Text(
                                    'หมุน',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 350,
                          height: 250,
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
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('ชุดเลขลอตโต้ที่จะออกจำหน่าย',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 0, 10, 103),
                                          )),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: FutureBuilder<
                                      List<LottoNumberGetRespone>>(
                                    future: getData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text('ไม่มีข้อมูล'));
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return Center(
                                            child: Text('No data found'));
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              bottom: 8.0),
                                          child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  5, // จำนวนคอลัมน์ที่ต้องการ
                                              crossAxisSpacing:
                                                  10, // ระยะห่างระหว่างคอลัมน์
                                              mainAxisSpacing:
                                                  10, // ระยะห่างระหว่างแถว
                                              childAspectRatio:
                                                  2.0, // อัตราส่วนระหว่างความกว้างกับความสูง
                                            ),
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors
                                                      .yellow, // สีพื้นหลังของเซลล์
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10), // ขอบมน
                                                ),
                                                child: Text(
                                                  snapshot.data![index].number,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
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

  void randomnumber() async {
    final random = Random();
    final List<String> randomNumbers = [];

    for (int i = 0; i < 100; i++) {
      final number = List.generate(6, (index) => random.nextInt(10)).join();
      randomNumbers.add(number); // เพิ่มเฉพาะเลขที่สุ่มได้
    }

    setState(() {
      this.randomNumbers = randomNumbers;
    });

    // แสดง popup
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(
              255, 255, 255, 255), // ตั้งค่าสีพื้นหลังของ AlertDialog
          title: Text(
            'ผลลัพธ์การหมุนลอตโต้',
            style: TextStyle(color: Colors.black),
          ),
          content: Container(
            width: 300,
            height: 300,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // จำนวนคอลัมน์
                crossAxisSpacing: 10, // ระยะห่างแนวนอน
                mainAxisSpacing: 10, // ระยะห่างแนวตั้ง
              ),
              itemCount: randomNumbers.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.yellow, // สีพื้นหลังของเซลล์
                    borderRadius: BorderRadius.circular(10), // ขอบมน
                  ),
                  child: Text(
                    randomNumbers[index],
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
          actions: [
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 10, 103),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // ปิด popup
              },
              child: Text('ตกลง'),
            ),
          ],
        );
      },
    );

    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    // ส่งข้อมูลที่สุ่มไปยังเซิร์ฟเวอร์
    for (var number in randomNumbers) {
      var response = await http.post(
        Uri.parse('$url/number_lotto/insertnumber'),
        headers: {
          'Content-Type': 'application/json', // ตั้งค่า header
        },
        body: jsonEncode({'number': number}), // ส่งข้อมูลในรูปแบบ JSON
      );

      if (response.statusCode == 200) {
        print('ข้อมูลถูกส่งสำเร็จ');
      } else {
        print('เกิดข้อผิดพลาด: ${response.reasonPhrase}');
      }
    }
  }

  Future<List<LottoNumberGetRespone>> getData() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    var response = await http.get(Uri.parse('$url/number_lotto/getallnumber'));

    // Log ค่า response.body ออกมา
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return lottoNumberGetResponeFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
