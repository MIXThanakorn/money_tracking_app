import 'package:flutter/material.dart';
import 'package:money_tracking_app/constants/color_constant.dart';
import 'package:money_tracking_app/views/login_ui.dart';
import 'package:money_tracking_app/views/register_ui.dart';

class WelcomeUi extends StatefulWidget {
  const WelcomeUi({super.key});

  @override
  State<WelcomeUi> createState() => _WelcomeUiState();
}

class _WelcomeUiState extends State<WelcomeUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/moneyimg01.png",
                  width: 525,
                  height: 525,
                ),
                Text('บันทึก\nรายรับรายจ่าย',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Color(mainColor),
                    )),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shadowColor: Colors.black,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: Color(mainColor)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginUi()));
                    },
                    child: Text(
                      'เริ่มต้นใช้งานแอปพลิเคชัน',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'มีบัญชีอยู่แล้ว ? ',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterUi()));
                      },
                      child: Text('ลงทะเบียน',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(mainColor),
                              fontWeight: FontWeight.bold)))
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
