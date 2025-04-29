import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracking_app/constants/baseurl_constanst.dart';
import 'package:money_tracking_app/constants/color_constant.dart';
import 'package:money_tracking_app/models/money.dart';
import 'package:money_tracking_app/service/money_api.dart';
import 'package:money_tracking_app/views/sub_home_01_ui.dart';
import 'package:money_tracking_app/views/sub_home_02_ui.dart';
import 'package:money_tracking_app/views/sub_home_03_ui.dart';

class HomeUi extends StatefulWidget {
  final String? userName;
  final String? userImage;
  final int? userID;

  const HomeUi({super.key, this.userName, this.userImage, this.userID});

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  int _selectedIndex = 1;

  late Future<List<Money>> moneyAllData;

  List showUI = [];
  Future<List<Money>> getMoneyByUserId() async {
    return await MoneyAPI().getMoneyByUserID(widget.userID!);
  }

  void refreshData() {
    setState(() {
      moneyAllData = getMoneyByUserId(); // Trigger a refresh of the data
    });
  }

  void initState() {
    refreshData();
    showUI = [
      SubHome01Ui(userID: widget.userID!, refreshData: refreshData),
      SubHome02Ui(userID: widget.userID!),
      SubHome03Ui(userID: widget.userID!, refreshData: refreshData),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalMoney = 0.0;
    double totalIncome = 0.0;
    double totalExpanse = 0.0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              widget.userName.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: widget.userImage!.isEmpty == true
                  ? Image.asset(
                      'assets/images/user_camera.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      '$baseUrl/images/users/${widget.userImage}',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    )),
          SizedBox(width: 25),
        ],
        backgroundColor: Color(subColor),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(mainColor),
        ),
        child: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_down_outlined, size: 45),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 45),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_up_outlined, size: 45),
                label: '',
              ),
            ]),
      ),
      body: Column(
        children: [
          FutureBuilder(
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
                  // ตัวแปรนี้จะทำการคำนวณยอดเงินคงเหลือ
                  snapshot.data!.forEach((x) {
                    if (x.moneyType == 1) {
                      totalMoney += x.moneyInOut!;
                      totalIncome += x.moneyInOut!;
                    } else {
                      totalExpanse += x.moneyInOut!;
                      totalMoney -= x.moneyInOut!;
                    }
                  });
                  return Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Color(subColor),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(24)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Align(
                          alignment: Alignment.center,
                          child: Material(
                            elevation: 8,
                            color: Color(mainColor),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.93,
                              height: 200,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 25),
                              decoration: BoxDecoration(
                                color: Color(mainColor),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "ยอดเงินคงเหลือ",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Text(
                                    "${NumberFormat("#,###").format(totalMoney)} บาท",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .arrow_circle_down_outlined,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "ยอดเงินเข้าร่วม",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${NumberFormat('#,###').format(totalIncome)}  บาท",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "ยอดเงินออกร่วม",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Icon(
                                                Icons.arrow_circle_up_outlined,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${NumberFormat('#,###').format(totalExpanse)}  บาท",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Center(child: Text('ไม่มีข้อมูล'));
              }),
          Expanded(child: showUI[_selectedIndex]),
        ],
      ),
    );
  }
}
