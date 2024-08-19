import 'package:flutter/material.dart';

class WithdrawMoney extends StatefulWidget {
  const WithdrawMoney({super.key});

  @override
  State<WithdrawMoney> createState() => _WithdrawMoneyState();
}

class _WithdrawMoneyState extends State<WithdrawMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                    child: Column(
                      children: [
                        const Row(
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
                        Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: Image.asset(
                            "assets/images/user.png",
                            width: 180,
                          ),
                        ),
                        const SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 100, 30, 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Text(
                                    "จำนวนที่ต้องการถอน (บาท)",
                                    style: TextStyle(color: Colors.black38,fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 15),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Text(
                                    "รหัสผ่าน",
                                    style: TextStyle(color: Colors.black38,fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                  child: TextField(),
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
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  shadowColor: Colors.black, // สีเงา
                                        elevation:
                                            8, // ความสูงของเงา (ยิ่งสูง เงายิ่งเข้ม)
                                      
                                ),
                                child: const Text(
                                  'ถอนเงิน',
                                  style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.black),
                                ),
                              ),
                   ],
                 ),
          ],
        ),
      ),
    );
  }
}
