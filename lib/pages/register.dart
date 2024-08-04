import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project/pages/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("ลงทะเบียนสมาชิกใหม่", style: TextStyle(fontSize: 20, color: Colors.pink.shade200)),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: Container(
        color: Colors.indigo.shade900,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      "ชื่อ-นามสกุล",
                      style: TextStyle(fontSize: 16, color: Colors.pink.shade200),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(15.0)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      "หมายเลขโทรศัพท์",
                      style: TextStyle(fontSize: 16, color: Colors.pink.shade200),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(15.0)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      "อีเมล์",
                      style: TextStyle(fontSize: 16, color: Colors.pink.shade200),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(15.0)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      "รหัสผ่าน",
                      style: TextStyle(fontSize: 16, color: Colors.pink.shade200),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(15.0)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      "ยืนยันรหัสผ่าน",
                      style: TextStyle(fontSize: 16, color: Colors.pink.shade200),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(15.0)))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: isPressed ? Colors.black : Colors.pink),
                          onPressed: register,
                          child: const Text(
                            'สมัครสมาชิก',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("หากยังมีบัญชีแล้ว ?",
                            style: TextStyle(
                              color: Colors.pink.shade200,
                            )),
                        TextButton(
                          onPressed: login,
                          child: const Text(
                            'เข้าสู่ระบบ',
                            style:
                                TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        )
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

  void login() {
    log("login");
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  LoginPage(),
        )); 
  }

  void register() {
    setState(() {
      isPressed = !isPressed;
    });
  }
}
