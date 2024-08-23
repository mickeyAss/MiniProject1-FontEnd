import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/wallet.dart';
import 'package:project/config/config.dart';
import 'package:project/models/respone/user_get_uid_res.dart';

class TopUpPage extends StatefulWidget {
  int uid = 0;
  TopUpPage({super.key, required this.uid});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  String url = "";
  late UserlGetUidRespone user;
  late Future<void> loadData;
  int? selectedAmount;
  TextEditingController passwordController = TextEditingController();
  int? selectedButton;

  @override
  void initState() {
    log(widget.uid.toString());
    super.initState();
    loadData = loadDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // ทำให้ AppBar อยู่บนภาพพื้นหลัง
      appBar: AppBar(
        backgroundColor: Colors.transparent, // ทำให้ AppBar โปร่งใส
        elevation: 0, // ไม่มีเงา
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'ย้อนกลับ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: loadData,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
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
                          padding: const EdgeInsets.fromLTRB(0, 100, 0, 10),
                          child: Column(
                            children: [
                              const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "เติมเงินเข้า WALLET",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ]),
                              Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Image.network(
                                  user.image,
                                  width: 180,
                                ),
                              ),
                              SingleChildScrollView(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 60, 30, 50),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 10),
                                        child: Text(
                                          "จำนวนที่ต้องการเติมเงิน (บาท)",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        selectedButton == 100
                                                            ? Colors.amber
                                                            : Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedAmount = 100;
                                                      selectedButton = 100;
                                                    });
                                                  },
                                                  child: const Text('100')),
                                              OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        selectedButton == 150
                                                            ? Colors.amber
                                                            : Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedAmount = 150;
                                                      selectedButton = 150;
                                                    });
                                                  },
                                                  child: const Text('150')),
                                              OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        selectedButton == 200
                                                            ? Colors.amber
                                                            : Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedAmount = 200;
                                                      selectedButton = 200;
                                                    });
                                                  },
                                                  child: const Text('200')),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        selectedButton == 250
                                                            ? Colors.amber
                                                            : Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedAmount = 250;
                                                      selectedButton = 250;
                                                    });
                                                  },
                                                  child: const Text('250')),
                                              OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        selectedButton == 300
                                                            ? Colors.amber
                                                            : Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedAmount = 300;
                                                      selectedButton = 300;
                                                    });
                                                  },
                                                  child: const Text('300')),
                                              OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        selectedButton == 500
                                                            ? Colors.amber
                                                            : Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedAmount = 500;
                                                      selectedButton = 500;
                                                    });
                                                  },
                                                  child: const Text('500')),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 20, 10, 0),
                                        child: Text(
                                          "รหัสผ่าน",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 5),
                                        child: TextField(
                                          controller: passwordController,
                                          obscureText: true, // ซ่อนรหัสผ่าน
                                          decoration: const InputDecoration(
                                            hintText:
                                                "กรุณากรอกรหัสผ่านเพื่อยืนยันการเติมเงิน",
                                            hintStyle: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 198, 198, 198),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        onPressed: () {
                          if (selectedAmount == null) {
                            // แสดงข้อความหรือ Dialog แจ้งผู้ใช้ให้เลือกจำนวนเงิน
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('กรุณาเลือกจำนวนเงิน')),
                            );
                            return;
                          }

                          if (passwordController.text.isEmpty) {
                            // แสดงข้อความหรือ Dialog แจ้งผู้ใช้ให้กรอกรหัสผ่าน
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('กรุณากรอกรหัสผ่าน')),
                            );
                            return;
                          }

                          _showConfirmationDialog();
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shadowColor: Colors.black, // สีเงา
                          elevation: 8, // ความสูงของเงา (ยิ่งสูง เงายิ่งเข้ม)
                        ),
                        child: const Text(
                          'เติมเงิน',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }

  //โหลดข้อมูล
  Future<void> loadDataAsync() async {
    await Future.delayed(const Duration(seconds: 1), () => print("AAA"));
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var value = await http.get(Uri.parse(("$url/get/${widget.uid}")));
    user = userlGetUidResponeFromJson(value.body);
  }

  void update() async {
    try {
      var config = await Configuration.getConfig();
      var url = config['apiEndpoint'];
      var res = await http.post(
        Uri.parse('$url/user/add-wallet/${widget.uid}'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode({
          "wallet": selectedAmount,
          "password": passwordController.text,
        }),
      );

      log('HTTP status code: ${res.statusCode}'); // เพิ่มการตรวจสอบสถานะการตอบสนอง
      var response = jsonDecode(res.body);

      log('Full response: $response'); // Log response ทั้งหมดออกมา

      if (response.containsKey('message') &&
          response['message'] == 'Wallet updated successfully') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('เติมเงินสำเร็จแล้ว')),
        );
      } else if (response.containsKey('error')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เติมเงินผิดพลาด: ${response['error']}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('เกิดข้อผิดพลาดที่ไม่คาดคิด')),
        );
      }
    } catch (e, stackTrace) {
      log('Exception caught: $e');
      log('Stack trace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('เกิดข้อผิดพลาด กรุณาลองอีกครั้ง.')),
      );
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการเติมเงิน'),
          content:
              Text('คุณต้องการเติมเงินจำนวน ${selectedAmount} บาท ใช่หรือไม่?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิดไดอาล็อก
              },
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // ปิดไดอาล็อก
                update(); // เรียกฟังก์ชันเติมเงิน
              },
              child: const Text('ยืนยัน'),
            ),
          ],
        );
      },
    );
  }
}
