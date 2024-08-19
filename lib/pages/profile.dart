import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/config/config.dart';
import 'package:project/models/respone/user_get_uid_res.dart';



class ProfilePage extends StatefulWidget {
  int uid = 0;
  ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        body: FutureBuilder(
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
                    Stack(children: [
                      Image.asset(
                        "assets/images/bg1.jpg",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 80, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/logo.png",
                              height: 80,
                            ),
                            const Text(
                              "LOTTO CLICK PROFILE",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )
                          ],
                        ),
                      )
                    ]),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Image.network(
                                            user.image,
                                            width: 150,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                            child: Text(
                                              "ข้อมูลส่วนตัว",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                  child: Text(
                                    "ชื่อ-นามสกุล",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 0, 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        user.name,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 22),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
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
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: Divider(
                                    // เส้นแบ่งระหว่างข้อมูล
                                    color: Colors.black26, // สีของเส้นแบ่ง
                                    thickness: 1.0, // ความหนาของเส้นแบ่ง
                                   
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                  child: Text(
                                    "หมายเลขโทรศัพท์",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 0, 5),
                                  child: Text(
                                    user.phone,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 22),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: Divider(
                                    // เส้นแบ่งระหว่างข้อมูล
                                    color: Colors.black26, // สีของเส้นแบ่ง
                                    thickness: 1.0, // ความหนาของเส้นแบ่ง
                                  
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                  child: Text(
                                    "อีเมล์",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 0, 5),
                                  child: Text(
                                    user.email,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 22),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: Divider(
                                    // เส้นแบ่งระหว่างข้อมูล
                                    color: Colors.black26, // สีของเส้นแบ่ง
                                    thickness: 1.0, // ความหนาของเส้นแบ่ง
                                   
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
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
