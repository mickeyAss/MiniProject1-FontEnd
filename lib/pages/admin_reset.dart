import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/config/config.dart';

class AdminResetPage extends StatefulWidget {
  const AdminResetPage({super.key});

  @override
  State<AdminResetPage> createState() => _AdminResetPageState();
}

class _AdminResetPageState extends State<AdminResetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รีเซ็ตระบบ'),
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
      builder: (context) => AlertDialog(
        title: Text('ยืนยันรีเซ็ท'),
        content: Text('คุณต้องการรีเซ็ทระบบหรือไม่?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // ยกเลิกการลบ
            },
            child: Text('ยกเลิก'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(true); // ยืนยันการลบ
            },
            child: Text('ยืนยัน'),
          ),
        ],
      ),
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
          builder: (context) => AlertDialog(
            title: const Text('สำเร็จ'),
            content: Text('รีเซ็ทระบบสำเร็จ'),
            actions: [
              FilledButton(
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      (route) => route.isFirst,
                    );
                  },
                  child: const Text('ตกลง'))
            ],
          ),
        );
      } else if (res.statusCode == 404) {
        // ไม่มีข้อมูลให้ลบ
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('ผิดพลาด'),
            content: Text('ไม่มีข้อมูลให้รีเซ็ท'),
            actions: [
              FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('ปิด'))
            ],
          ),
        );
      } else {
        // ข้อผิดพลาดอื่น ๆ
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('ผิดพลาด'),
            content: Text('รีเซ็ทระบบไม่สำเร็จ'),
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
  }
}
