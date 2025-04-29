import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracking_app/models/money.dart';
import 'package:money_tracking_app/service/money_api.dart';

class SubHome02Ui extends StatefulWidget {
  final int userID;
  const SubHome02Ui({super.key, required this.userID});

  @override
  State<SubHome02Ui> createState() => _SubHome02UiState();
}

class _SubHome02UiState extends State<SubHome02Ui> {
  late Future<List<Money>> moneyAllData;
  Future<List<Money>> getMoneyByUserId() async {
    return await MoneyAPI().getMoneyByUserID(widget.userID);
  }

  void refreshData() {
    setState(() {
      moneyAllData = getMoneyByUserId(); // Trigger a refresh of the data
    });
  }

  @override
  void initState() {
    refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "เงินเข้า/เงินออก",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder(
                future: moneyAllData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    ); // แสดง loading
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: snapshot.data![index].moneyType == 1
                              ? Icon(
                                  Icons.arrow_circle_down_outlined,
                                  color: Colors.green,
                                  size: 36,
                                )
                              : Icon(
                                  Icons.arrow_circle_up_outlined,
                                  color: Colors.red,
                                  size: 36,
                                ),
                          title: Text(
                            '${snapshot.data![index].moneyDetail}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${snapshot.data![index].moneyDate}',
                            style: TextStyle(fontSize: 12),
                          ),
                          trailing: snapshot.data![index].moneyType == 1
                              ? Text(
                                  "+${NumberFormat('#,###').format(snapshot.data![index].moneyInOut)}",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                  ),
                                )
                              : Text(
                                  "-${NumberFormat('#,###').format(snapshot.data![index].moneyInOut)}",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                  ),
                                ),
                        );
                      },
                    );
                  }
                  return Text('ไม่มีข้อมูล');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
