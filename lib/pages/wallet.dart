import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/top_up.dart';
import 'package:project/config/config.dart';
import 'package:project/pages/withdraw_money.dart';
import 'package:project/models/respone/user_get_uid_res.dart';

class WalletPage extends StatefulWidget {
  int uid = 0;
  WalletPage({super.key, required this.uid});

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

  Future<void> _refreshData() async {
    setState(() {
      loadData = loadDataAsync();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder(
          future: loadData,
          builder: (context, snapshot) {
            // If load data is in process
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // If loadData successfully
            return ListView(
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
                      padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "LOTTO CLICK",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
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
                              SizedBox(width: 15),
                              Text(
                                'WALLET',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                child: SizedBox(
                                  width: 350,
                                  height: 400,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 0),
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
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        WithdrawMoney(
                                                            uid: widget.uid),
                                                  ),
                                                );
                                              },
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.amber,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        35, 0, 35, 5),
                                                shadowColor: Colors.black,
                                                elevation: 8,
                                              ),
                                              child: const Text(
                                                'ถอนเงิน',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            FilledButton(
                                              onPressed: () {
                                                 Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        TopUpPage(
                                                            uid: widget.uid),
                                                  ),
                                                );
                                              },
                                              style: FilledButton.styleFrom(
                                                backgroundColor: Colors.amber,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        35, 0, 35, 5),
                                                shadowColor: Colors.black,
                                                elevation: 8,
                                              ),
                                              child: const Text(
                                                'เติมเงิน',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
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
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> loadDataAsync() async {
    await Future.delayed(const Duration(seconds: 1), () => print("AAA"));
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var value = await http.get(Uri.parse(("$url/get/${widget.uid}")));
    user = userlGetUidResponeFromJson(value.body);
    log(widget.uid.toString());
  }
}
