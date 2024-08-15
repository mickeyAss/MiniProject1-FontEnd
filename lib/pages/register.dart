import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/home.dart';
import 'package:project/pages/login.dart';
import 'package:project/models/requst/user_register_post_req.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  bool isPressed = false;

  var nameCt1 = TextEditingController();
  var surnameCt1 = TextEditingController();
  var phoneNoCtl = TextEditingController();
  var emailCt1 = TextEditingController();
  var passWordCt1 = TextEditingController();
  var passWordConCt1 = TextEditingController();
  var walletCt1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ลงทะเบียนใหม่',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 0, 10, 103),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 0, 10, 103),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 80),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                    ),
                  ),
                  Positioned(
                    left: 60,
                    child: Text(
                      'LOTTO CLICK',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 217, 48)),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: SizedBox(
                height: 550,
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 60, bottom: 80),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextField(
                            controller: nameCt1,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                labelText: 'ชื่อ',
                                prefixIcon: Icon(Icons.person_add_alt_1),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 30))),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: surnameCt1,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                labelText: 'นามสกุล',
                                prefixIcon: Icon(Icons.person_add_alt_1),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 30))),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: phoneNoCtl,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: 'เบอร์โทรศัพท์',
                                prefixIcon: Icon(Icons.phone),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 30))),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: emailCt1,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                labelText: 'email',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 30))),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: passWordCt1,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                labelText: 'รหัสผ่าน',
                                prefixIcon: Icon(Icons.password),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 30))),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: passWordConCt1,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                labelText: 'ยืนยันรหัสผ่าน',
                                prefixIcon: Icon(Icons.password_outlined),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 30))),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: walletCt1,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: 'กรุณากรอกเงินเริ่มต้น',
                                prefixIcon: Icon(Icons.wallet),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 30))),
                          ),
                          SizedBox(height: 20),
                          FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: Color.fromARGB(
                                    255, 255, 213, 0), // สีพื้นหลังของปุ่ม
                                foregroundColor:
                                    Colors.white, // สีข้อความบนปุ่ม
                                padding: EdgeInsets.only(left: 10, right: 10),
                                textStyle:
                                    TextStyle(fontSize: 16), // ขนาดข้อความ
                                elevation: 15),
                            onPressed: register,
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .min, // ทำให้ Row มีขนาดพอดีกับเนื้อหา
                              children: [
                                Icon(
                                  Icons
                                      .check_circle_outline, // เลือกไอคอนที่คุณต้องการ
                                  size: 20, // ปรับขนาดไอคอน
                                ),
                                SizedBox(
                                    width:
                                        8), // เพิ่มระยะห่างระหว่างไอคอนและข้อความ
                                Text(
                                  'ยืนยัน',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              )),
            ],
          )
        ],
      ),
    );
  }

  void login() {
    log("login page");
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  }

  void register() {
    if (nameCt1.text.isEmpty ||
        phoneNoCtl.text.isEmpty ||
        emailCt1.text.isEmpty ||
        passWordCt1.text.isEmpty) {
      log('Fields cannot be empty');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'กรุณากรอกข้อมูลให้ครบทุกช่อง',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    } else {
      if (passWordCt1.text != passWordConCt1.text) {
        log('Passwords do not match');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'รหัสผ่านและการยืนยันรหัสผ่านไม่ตรงกัน',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
        return;
      } else {
        setState(() {
          var model = UserRegisterPostReq(
            name: nameCt1.text,
            phone: phoneNoCtl.text,
            email: emailCt1.text,
            password: passWordCt1.text,
            wallet: walletCt1.text,
            surname: surnameCt1.text,
          );
          http
              .post(
                  Uri.parse(
                      "https://miniproject1-backend-website.onrender.com/user/register"),
                  headers: {"Content-Type": "application/json; charset=utf-8"},
                  body: userRegisterPostReqToJson(model))
              .then(
            (value) {
              log(value.body);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'สมัครสมาชิกเรียบร้อย',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Color.fromARGB(255, 89, 255, 0),
                  duration: Duration(seconds: 3),
                ),
              );
              Future.delayed(const Duration(seconds: 1), () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const HomePage(),
                //   ),
                // );

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (Route<dynamic> route) => false,
                );
              });
            },
          ).catchError((err) {
            log(err.toString());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'เกิดข้อผิดพลาด: ${err.toString()}',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          });
        });
      }
    }
  }
}
