import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/admin.dart';
import 'package:project/pages/login.dart';
import 'package:project/config/config.dart';

class AdminResetPage extends StatefulWidget {
  int uid = 0;
  AdminResetPage({super.key, required this.uid});

  @override
  State<AdminResetPage> createState() => _AdminResetPageState();
}

class _AdminResetPageState extends State<AdminResetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ย้อนกลับ'),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Center(
              child: Column(
            children: [
              Image.asset(
                'assets/images/crisis.png',
                width: 100,
              ),
              Text(
                'รีเซ็ทระบบ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50, right: 50, top: 20, bottom: 20),
                child: Center(
                  child: Text(
                    'การรีเซ็ทระบบจะทำให้ข้อมูลทั้งหมดหายไปโปรดมั่นใจที่จะรีเซ็ท',
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center, // Center the text horizontally
                  ),
                ),
              ),
              Divider(
                color: Colors.grey, // You can customize the color
                thickness: 1, // You can customize the thickness
                indent: 40, // Match the padding from the Row
                endIndent: 40, // Match the padding from the Row
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/password.png',
                      width: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                              'ฉลากทั้งหมดในระบบจะถูกลบออกหลังจากนี้ข้อมูลจะไม่มีการแสดงฉลากอีกต่อไปโปรดทราบว่าการลบฉลากนี้เป็นการถาวรและไม่สามารถกู้คืนได้ดังนั้นกรุณาตรวจสอบให้แน่ใจก่อนดำเนินการ'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/report.png',
                      width: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                              'ผลลอตโต้ทั้งหมดในระบบจะถูกลบออกหลังจากนี้ข้อมูลเกี่ยวกับผลลอตโต้ที่บันทึกไว้จะไม่สามารถเข้าถึงได้อีกโปรดตรวจสอบให้แน่ใจก่อนดำเนินการลบเนื่องจากการลบนี้เป็นการถาวรและไม่สามารถกู้คืนได้'),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 199, 0, 0), // สีพื้นหลังของปุ่ม
                  foregroundColor: Colors.white, // สีข้อความบนปุ่ม

                  textStyle: TextStyle(fontSize: 16), // ขนาดข้อความ
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // มุมโค้งของปุ่ม
                  ),
                ),
                onPressed: delete,
                child: Text(
                  'ดำเนินการ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          16), // Increased font size for better visibility
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void delete() async {
    // แสดงการยืนยันก่อนลบ
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'ยืนยันการรเซ็ทระบบ',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('คุณต้องการที่จะรีเซ็ตระบบจริงหรือไม่ ?'),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  child: Text('ยกเลิก',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 10, 103),
                      )),
                  onPressed: () {
                    Navigator.of(context).pop(false); // ยกเลิกการลบ
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: Color.fromARGB(255, 0, 10, 103),
                        width: 2.0), // สีและความหนาของเส้นขอบ
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // มุมโค้งของปุ่ม
                    ),
                  ),
                ),
                FilledButton(
                  child: Text('รีเซ็ท'),
                  style: FilledButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 10, 103),
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      textStyle: TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // มุมโค้งของปุ่ม
                      ),
                      elevation: 5),
                  onPressed: () {
                    Navigator.of(context).pop(true); // ยกเลิกการลบ
                  },
                ),
              ],
            ),
          ],
        );
      },
    );

    // ถ้าผู้ใช้ยืนยันการลบ
    if (confirmDelete == true) {
      var config = await Configuration.getConfig();
      var url = config['apiEndpoint'];

      // ทำการลบข้อมูลผ่าน API
      var res = await http.delete(Uri.parse('$url/number_lotto/deletenumber'));
      final responseJson = res.body;

      if (res.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                  child: Text(
                'สำเร็จ',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('รีเซ็ทระบบสำเร็จ'),
                ],
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
                            borderRadius:
                                BorderRadius.circular(8.0), // มุมโค้งของปุ่ม
                          ),
                          elevation: 5),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminPages(uid: widget.uid),
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
      } else if (res.statusCode == 500) {
        // ไม่มีข้อมูลให้ลบ
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                  child: Text(
                'ผิลพลาด',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ไม่มีข้อมูลให้รีเซ็ต'),
                ],
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
                            borderRadius:
                                BorderRadius.circular(8.0), // มุมโค้งของปุ่ม
                          ),
                          elevation: 5),
                      onPressed: () {
                        Navigator.of(context).pop(); // ปิด popup หลังจากยืนยัน
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      } else {
        // ข้อผิดพลาดอื่น ๆ
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                  child: Text(
                'ผิลพลาด',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('รีเซ็ทระบบไม่สำเร็จ'),
                ],
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
                            borderRadius:
                                BorderRadius.circular(8.0), // มุมโค้งของปุ่ม
                          ),
                          elevation: 5),
                      onPressed: () {
                        Navigator.of(context).pop(); // ปิด popup หลังจากยืนยัน
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }
    }
  }
}
