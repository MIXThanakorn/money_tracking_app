import 'package:flutter/material.dart';
import 'package:money_tracking_app/constants/baseurl_constanst.dart';
import 'package:money_tracking_app/constants/color_constant.dart';
import 'package:money_tracking_app/models/user.dart';
import 'package:money_tracking_app/views/sub_home_01_ui.dart';
import 'package:money_tracking_app/views/sub_home_02_ui.dart';
import 'package:money_tracking_app/views/sub_home_03_ui.dart';

class HomeUi extends StatefulWidget {
  User? user;

  HomeUi({super.key, this.user});

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  int _selectedIndex = 1;

  List showUI = [
    SubHome01Ui(),
    SubHome02Ui(),
    SubHome03Ui(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text('First name', style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: widget.user!.userImage == null
                  ? Image.asset(
                      'assets/images/user_camera.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      '$baseUrl/images/users/${widget.user!.userImage}',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )),
          SizedBox(width: 25),
        ],
        backgroundColor: Color(mainColor),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              decoration: BoxDecoration(
                color: Color(mainColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "ยอดเงินคงเหลือ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    "xxxxx",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_circle_down_outlined,
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
                            "xxxxx",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                            "xxxxx",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: showUI[_selectedIndex]),
          ],
        ),
      ),
    );
  }
}
