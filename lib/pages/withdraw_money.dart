import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/wallet.dart';
import 'package:project/config/config.dart';

class WithdrawMoney extends StatefulWidget {
  int uid = 0;
  WithdrawMoney({super.key, required this.uid});

  @override
  State<WithdrawMoney> createState() => _WithdrawMoneyState();
}

class _WithdrawMoneyState extends State<WithdrawMoney> {
  TextEditingController walletNoCt1 = TextEditingController();
  TextEditingController passwordNoCt1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // ทำให้ AppBar อยู่บนภาพพื้นหลัง
      appBar: AppBar(
        backgroundColor: Colors.transparent, // ทำให้ AppBar โปร่งใส
        elevation: 0, // ไม่มีเงา
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'ย้อนกลับ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
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
                  padding: const EdgeInsets.only(top: 100),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ถอนเงินใน WALLET",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ]),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 90, 0, 50),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: Image.asset(
                            "assets/images/user.png",
                            width: 180,
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Text(
                                    "จำนวนที่ต้องการถอน (บาท)",
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 15),
                                  child: TextField(
                                    controller: walletNoCt1,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Text(
                                    "รหัสผ่าน",
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                  child: TextField(
                                    obscureText: true, // ซ่อนรหัสผ่าน
                                    controller: passwordNoCt1,
                                    keyboardType: TextInputType.number,
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
                  onPressed: deduct,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shadowColor: Colors.black, // สีเงา
                    elevation: 8, // ความสูงของเงา (ยิ่งสูง เงายิ่งเข้ม)
                  ),
                  child: const Text(
                    'ถอนเงิน',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deduct() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    var json = {
      "wallet": walletNoCt1.text,
      "password": passwordNoCt1.text,
    };

    try {
      // ตรวจสอบว่ารหัสผ่านถูกกรอกหรือไม่
      if (passwordNoCt1.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('กรุณาใส่รหัสผ่าน')),
        );
        return;
      }

      // เรียกใช้งาน API
      var res = await http.post(
        Uri.parse('$url/user/deduct-wallet/${widget.uid}'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode(json), // ส่งเป็น JSON object
      );

      var v = jsonDecode(res.body);

      // ตรวจสอบสถานะการตอบกลับจาก API
      if (res.statusCode == 200) {
        log('Success: ${v['message']}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  'ถอนเงินสำเร็จ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
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
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 5,
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
      } else if (res.statusCode == 400) {
        log('Error: ${v['error']}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ยอดเงินใน wallet มีไม่พอ')),
        );
      } else if (res.statusCode == 401) {
        log('Error: Incorrect password');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('รหัสผ่านไม่ถูกต้อง')),
        );
      } else if (res.statusCode == 404) {
        log('Error: ${v['message']}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ไม่พบผู้ใช้: ${v['message']}')),
        );
      } else {
        log('Unexpected Error: ${v['error']}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาด: ${v['error']}')),
        );
      }
    } catch (e) {
      log('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
      );
    }
  }
}
