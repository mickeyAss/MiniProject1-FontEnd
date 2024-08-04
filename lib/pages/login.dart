// import 'dart:math';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project/pages/home.dart';
import 'package:project/pages/register.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigo.shade900,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 200,
                    ),
                  ),
                  Text(
                    "LOTTO CLICK",
                    style: TextStyle(color: Colors.pink.shade200),
                  ),
                  const Text(
                    "Welcome to Lotto click",
                    style: TextStyle(
                        fontSize: 24, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "password",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: isPressed ? Colors.black : Colors.pink),
                      onPressed: login,
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("หากยังไม่มีบัญชี ?",
                          style: TextStyle(
                            color: Colors.pink.shade200,
                          )),
                      TextButton(
                        onPressed: register,
                        child: const Text(
                          'ลงทะเบียน',
                          style:
                              TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      )
                    ],
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
    setState(() {
      isPressed = !isPressed;
    });
     
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
        log("login");
  }

  void register() {
    log("register");
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        ));
  }
}
