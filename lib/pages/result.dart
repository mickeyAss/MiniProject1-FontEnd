import 'dart:convert';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/home.dart';
import 'package:project/config/config.dart';
import 'package:project/models/respone/user_my_reslt_res.dart';

class ResultPage extends StatefulWidget {
  int uid = 0;
  int lottoid = 0;
  ResultPage({super.key, required this.uid, required this.lottoid});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late Future<void> loadData;
  late UserMyresultRespone userMyresultRespone;
  bool isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData = getData();
  }

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
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 10, 103),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'LOTTO CLICK',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'ขึ้นเงินรางวัล',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilder(
                  future: loadData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: 350,
                            height: 200,
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
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 0, 10, 103),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: Image.asset(
                                                'assets/images/logo.png'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'LOTTO CLICK',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 0, 10, 103),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('เลขลอตโต้'),
                                        Text(
                                            '${userMyresultRespone.result[0].number}')
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('รางวัล'),
                                        Text(
                                            '${userMyresultRespone.result[0].result}')
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('เงินรางวัล'),
                                        Text(
                                            '${userMyresultRespone.prizeAmount} บาท')
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: 350,
                            height: 300,
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 211, 34),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(0, 1))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // จัดวางให้ชิดซ้าย
                                  children: [
                                    Text(
                                      'ช่องทางการชำระเงิน',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            10.0), // เพิ่มระยะห่างระหว่างข้อความและกรอบ
                                    Container(
                                      padding: EdgeInsets.all(
                                          10.0), // ระยะห่างภายในกรอบให้เท่ากันทุกด้าน
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color.fromARGB(255, 255,
                                              255, 255), // สีของเส้นกรอบ
                                          width: 1.0, // ความหนาของเส้นกรอบ
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            20.0), // มุมโค้งของกรอบ
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                value:
                                                    isChecked, // ค่าของ Checkbox จะเก็บอยู่ในตัวแปรนี้
                                                onChanged: (bool? newValue) {
                                                  setState(() {
                                                    isChecked = newValue!;
                                                  });
                                                },
                                                activeColor: Colors
                                                    .white, // สีของ Checkbox เมื่อถูกติ๊ก
                                                checkColor: Colors
                                                    .black, // สีของเครื่องหมายถูก
                                              ),
                                              Image.asset(
                                                'assets/images/wallet.png',
                                                width: 50,
                                              ),
                                              SizedBox(width: 5.0),
                                              Text(
                                                'บัญชี wallet ของคุณ',
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(40.0),
                                        child: Column(
                                          children: [
                                            FilledButton(
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255,
                                                    0,
                                                    10,
                                                    103), // สีพื้นหลังของปุ่ม
                                                foregroundColor: Colors
                                                    .white, // สีข้อความบนปุ่ม
                                                padding: EdgeInsets.only(
                                                    left: 50, right: 50),
                                                textStyle: TextStyle(
                                                    fontSize:
                                                        16), // ขนาดข้อความ
                                                elevation: 15,
                                              ),
                                              onPressed: () {
                                                if (!isChecked) {
                                                  // แสดง Snackbar เตือนหาก Checkbox ไม่ถูกติ๊ก
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'กรุณาเลือกช่องทางการชำระเงิน'),
                                                    ),
                                                  );
                                                } else {
                                                  // ถ้า Checkbox ถูกติ๊กแล้ว ให้เรียกฟังก์ชัน update
                                                  update();
                                                }
                                              },
                                              child: Text(
                                                'ขึ้นเงิน',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              '*กดขึ้นเงินเพื่อรับเงินรางวัล',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: const Color.fromARGB(
                                                    255, 67, 67, 67),
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
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void update() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];
    var res = await http.post(
        Uri.parse('$url/user/update-wallet/${widget.uid}'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode({
          "prizeAmount": userMyresultRespone.prizeAmount
        })); // ส่งเป็น JSON object
    var v = jsonDecode(res.body);
    log(v['message']); // แก้ไขจาก 'messsage' เป็น 'message'

    try {
      if (v['message'] == 'Wallet updated successfully') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('สำเร็จ'),
            content: const Text('ขึ้นเงินเรียบร้อย'),
            actions: [
              FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(uid: widget.uid),
                      ),
                    );
                  },
                  child: const Text('ปิด'))
            ],
          ),
        );
      } else {
        log('ไม่สามารถขึ้นเงินได้');
      }
    } catch (err) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('ผิดพลาด'),
          content: Text('ไม่สามารถขึ้นเงินได้ ' + err.toString()),
          actions: [
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ปิด'))
          ],
        ),
      );
    }
  }

  Future<void> getData() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    var response = await http.get(
        Uri.parse('$url/user/check-uidfk/${widget.uid}/${widget.lottoid}'));
    log(response.body);
    userMyresultRespone = userMyresultResponeFromJson(response.body);
    log(userMyresultRespone.result[0].number);
  }
}
