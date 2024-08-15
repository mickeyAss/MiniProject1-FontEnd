import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/home.dart';
import 'package:project/pages/admin.dart';
import 'package:project/pages/register.dart';
import 'package:project/pages/admin_random.dart';
import 'package:project/models/requst/user_login_post_req.dart';
// import 'dart:math';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPressed = false;
  TextEditingController phoneNoCt1 = TextEditingController();
  TextEditingController passwordNoCt1 = TextEditingController();

  final GlobalKey<State<StatefulWidget>> _sizedBoxKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Color.fromARGB(255, 0, 10, 103),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                ),
                Text(
                  'Lotto Click',
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
                Text(
                  'Walcome to Lotto Click',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
                FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Color.fromARGB(
                            255, 255, 255, 255), // สีพื้นหลังของปุ่ม
                        foregroundColor:
                            Color.fromARGB(255, 0, 10, 103), // สีข้อความบนปุ่ม
                        padding: EdgeInsets.only(left: 100, right: 100),
                        textStyle: TextStyle(fontSize: 16),
                        elevation: 15),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              key: _sizedBoxKey,
                              height: 450,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 50),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextField(
                                      controller: phoneNoCt1,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          labelText: 'หมายเลขโทรศัพท์',
                                          prefixIcon: Icon(
                                              Icons.phone_android_outlined),
                                          border: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(width: 30))),
                                    ),
                                    SizedBox(height: 20),
                                    TextField(
                                      controller: passwordNoCt1,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          labelText: 'รหัสผ่าน',
                                          prefixIcon: Icon(Icons.password),
                                          border: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(width: 30))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: FilledButton(
                                        style: FilledButton.styleFrom(
                                            backgroundColor: Color.fromARGB(
                                                255,
                                                0,
                                                10,
                                                103), // สีพื้นหลังของปุ่ม
                                            foregroundColor:
                                                Colors.white, // สีข้อความบนปุ่ม
                                            padding: EdgeInsets.only(
                                                left: 100, right: 100),
                                            textStyle: TextStyle(fontSize: 16),
                                            elevation: 15),
                                        onPressed: login,
                                        child: Text(
                                          'เข้าสู่ระบบ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    FilledButton(
                                      style: FilledButton.styleFrom(
                                          backgroundColor: Color.fromARGB(255,
                                              98, 98, 98), // สีพื้นหลังของปุ่ม
                                          foregroundColor:
                                              Colors.white, // สีข้อความบนปุ่ม
                                          padding: EdgeInsets.only(
                                              left: 100, right: 100),
                                          textStyle: TextStyle(
                                              fontSize: 16), // ขนาดข้อความ
                                          elevation: 15),
                                      onPressed: register,
                                      child: Text(
                                        'ลงทะเบียน',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text('หากยังไม่สมัครสมาชิก ?')
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Text(
                      'LOGIN',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ],
        ),
      ]),
    );
  }

  void login() async {
    UserLoginPostReq model = UserLoginPostReq(
      phone: phoneNoCt1.text,
      password: passwordNoCt1.text,
    );

    if (phoneNoCt1.text.isEmpty || passwordNoCt1.text.isEmpty) {
      log('Fields cannot be empty');
      _showSnackBar('กรุณากรอกข้อมูลให้ครบทุกช่อง');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
            "https://miniproject1-backend-website.onrender.com/user/login"),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode(
            model.toJson()), // ตรวจสอบว่ามีฟังก์ชัน toJson() ในโมเดลหรือไม่
      );

      if (response.statusCode == 200) {
        final responseData =
            jsonDecode(response.body); // แปลงข้อมูลตอบกลับเป็น JSON

        // ตรวจสอบข้อความที่ส่งกลับมา
        if (responseData['message'] == 'Login successfully') {
          if (responseData['userType'] == 'admin') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminPages(),
              ),
            );
          } else if (responseData['userType'] == 'user') {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,
            );
          }

          log('Login successful: ${response.body}');
        } else {
          _showSnackBar('ข้อมูลเข้าสู่ระบบไม่ถูกต้อง');
          log('Login failed: ${response.body}');
        }
      } else {
        _showSnackBar('เกิดข้อผิดพลาดในการเข้าสู่ระบบ');
        log('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      _showSnackBar('เกิดข้อผิดพลาดในการเชื่อมต่อ');
      log('Error: $error');
    }
  }

  void _showSnackBar(String message, {Color backgroundColor = Colors.red}) {
    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: backgroundColor,
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context)?.insert(_overlayEntry!);
    Future.delayed(Duration(seconds: 3), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  void register() {
    log("register page");
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterPage(),
        ));
  }
}
