import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/config/config.dart';
import 'package:project/pages/withdraw_money.dart';
import 'package:project/models/respone/user_get_uid_res.dart';



class WalletPage extends StatefulWidget {
  int uid = 0;
   WalletPage({super.key,required this.uid});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
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
          builder: (context,snapshot) {
            //if load data in process
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              //if loaddata successfully
            return Column(
                  children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/bg1.jpg",
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(30, 50, 0, 0),
                    child:
                        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text(
                        "LOTTO CLICK",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ])),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            child: SizedBox(
                              width: 350,
                              height: 400,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Image.asset(
                                      "assets/images/wallet.png",
                                      width: 200,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "YOUR WALLET",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                   Text(
                                    "${user.wallet} Bath",
                                    style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        FilledButton(
                                          onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const WithdrawMoney(),));
                                          },
                                          style: FilledButton.styleFrom(
                                            backgroundColor: Colors.amber,
                                            padding: const EdgeInsets.fromLTRB(
                                                35, 0, 35, 5),
                                            shadowColor: Colors.black, // สีเงา
                                            elevation:
                                                8, // ความสูงของเงา (ยิ่งสูง เงายิ่งเข้ม)
                                          ),
                                          child: const Text(
                                            'ถอนเงิน',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        FilledButton(
                                          onPressed: () {},
                                          style: FilledButton.styleFrom(
                                            backgroundColor: Colors.amber,
                                            padding: const EdgeInsets.fromLTRB(
                                                35, 0, 35, 5),
                                            shadowColor: Colors.black, // สีเงา
                                            elevation:
                                                8, // ความสูงของเงา (ยิ่งสูง เงายิ่งเข้ม)
                                          ),
                                          child: const Text(
                                            'เติมเงิน',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "ประวัติการทำรายการ",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 350,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black26, // สีของเส้นขอบ
                    width: 1.0, // ความกว้างของเส้นขอบ
                  ),
                  borderRadius:
                      BorderRadius.circular(10.0), // กำหนดขอบมน (ถ้าต้องการ)
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/moneyout.png",
                                  width: 50,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "เงินออก",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.watch_later),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                            child: Text("10 ก.ค. 2567"),
                                          ),
                                          Text("10 : 44")
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              "-฿ 160",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Divider(
                            // เส้นแบ่งระหว่างข้อมูล
                            color: Colors.black26, // สีของเส้นแบ่ง
                            thickness: 1.0, // ความหนาของเส้นแบ่ง
                            height:
                                30.0, // ความสูงระหว่างเส้นแบ่งกับส่วนที่อยู่ด้านบนและล่าง
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/moneyin.png",
                                  width: 50,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "เงินเข้า",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.watch_later),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                            child: Text("8 ก.ค. 2567"),
                                          ),
                                          Text("16 : 44")
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              "+฿ 200",
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
                  ],
                );
          }
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
