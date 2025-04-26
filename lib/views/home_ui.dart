import 'package:flutter/material.dart';

import 'package:money_tracking_app/constants/color_constant.dart';
import 'package:money_tracking_app/views/sub_home_01_ui.dart';
import 'package:money_tracking_app/views/sub_home_02_ui.dart';
import 'package:money_tracking_app/views/sub_home_03_ui.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({super.key});

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
      body: showUI[_selectedIndex],
    );
  }
}
