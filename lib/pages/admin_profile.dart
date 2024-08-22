import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/login.dart';
import 'package:project/config/config.dart';
import 'package:project/models/respone/user_get_uid_res.dart';

class AdminProfilePage extends StatefulWidget {
  int uid = 0;
  AdminProfilePage({super.key, required this.uid});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  String url = "";
  late UserlGetUidRespone user;
  late Future<void> loadData;

  @override
  void initState() {
    log(widget.uid.toString());
    super.initState();
    loadData = loadDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent, // ทำให้ AppBar โปร่งใส
          elevation: 0, // ไม่มีเงา
          iconTheme: IconThemeData(color: Colors.white),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PROFILE',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Center(
                                child: Text(
                              'ยืนยันการออกจากระบบ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  OutlinedButton(
                                    child: Text('ยกเลิก',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 0, 10, 103),
                                        )),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // ปิด popup เมื่อกดยกเลิก
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          color:
                                              Color.fromARGB(255, 0, 10, 103),
                                          width: 2.0), // สีและความหนาของเส้นขอบ
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8.0), // มุมโค้งของปุ่ม
                                      ),
                                    ),
                                  ),
                                  FilledButton(
                                    child: Text('ยืนยัน'),
                                    style: FilledButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 0, 10, 103),
                                        foregroundColor: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        textStyle: TextStyle(fontSize: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8.0), // มุมโค้งของปุ่ม
                                        ),
                                        elevation: 5),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.logout), // หรือ Icons.exit_to_app
                    tooltip: 'Logout', // คำอธิบายเมื่อวางเมาส์บนปุ่ม (ถ้ามี)
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Blue.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            FutureBuilder(
                future: loadData,
                builder: (contex, snapshot) {
                  //if load data in process
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  //if loaddata successfully
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 0, 10, 103),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child:
                                          Image.asset('assets/images/logo.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'LOTTO CLICK',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              SingleChildScrollView(
                                child: SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  ClipOval(
                                                    child: Image.network(
                                                      user.image,
                                                      width: 120,
                                                      height: 120,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 20, 0, 20),
                                                    child: Text(
                                                      "ข้อมูลส่วนตัว",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 10, 0),
                                          child: Text(
                                            "ชื่อ-นามสกุล",
                                            style: TextStyle(
                                                color: Colors.black38),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 0, 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                user.name,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Text(
                                                  user.surname,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 0, 20, 20),
                                          child: Divider(
                                            // เส้นแบ่งระหว่างข้อมูล
                                            color:
                                                Colors.black26, // สีของเส้นแบ่ง
                                            thickness:
                                                1.0, // ความหนาของเส้นแบ่ง
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 10, 0),
                                          child: Text(
                                            "หมายเลขโทรศัพท์",
                                            style: TextStyle(
                                                color: Colors.black38),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 0, 5),
                                          child: Text(
                                            user.phone,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 22),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 0, 20, 20),
                                          child: Divider(
                                            // เส้นแบ่งระหว่างข้อมูล
                                            color:
                                                Colors.black26, // สีของเส้นแบ่ง
                                            thickness:
                                                1.0, // ความหนาของเส้นแบ่ง
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 10, 0),
                                          child: Text(
                                            "อีเมล์",
                                            style: TextStyle(
                                                color: Colors.black38),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 0, 5),
                                          child: Text(
                                            user.email,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 22),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 0, 20, 20),
                                          child: Divider(
                                            // เส้นแบ่งระหว่างข้อมูล
                                            color:
                                                Colors.black26, // สีของเส้นแบ่ง
                                            thickness:
                                                1.0, // ความหนาของเส้นแบ่ง
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ));
  }

  //โหลดข้อมูล
  Future<void> loadDataAsync() async {
    await Future.delayed(const Duration(seconds: 1), () => print("AAA"));
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var value = await http.get(Uri.parse(("$url/get/${widget.uid}")));
    user = userlGetUidResponeFromJson(value.body);
    log(widget.uid.toString());
  }
}
