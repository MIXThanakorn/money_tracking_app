import 'package:flutter/material.dart';
import 'package:money_tracking_app/constants/color_constant.dart';
import 'package:money_tracking_app/models/user.dart';
import 'package:money_tracking_app/service/user_api.dart';
import 'package:money_tracking_app/views/home_ui.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({super.key});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  TextEditingController userNameCtrl = TextEditingController(text: '');
  TextEditingController passwordCtrl = TextEditingController(text: '');

  bool isVislable = true;

  showwarningsnackbar(context, mes) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        mes,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(mainColor),
        appBar: AppBar(
          backgroundColor: Color(mainColor),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('เข้าใช้งาน Money Tracking',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18)),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Container(
                height: 40,
                color: Color(mainColor),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      Image.asset(
                        "assets/images/moneyimg01.png",
                        width: 400,
                        height: 400,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: userNameCtrl,
                        decoration: InputDecoration(
                          labelText: 'ชื่อผู้ใช้',
                          hintText: 'USERNAME',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(mainColor), width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(mainColor), width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: isVislable,
                        controller: passwordCtrl,
                        decoration: InputDecoration(
                          labelText: 'รหัสผ่าน',
                          hintText: 'PASSWORD',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVislable = !isVislable;
                              });
                            },
                            icon: Icon(isVislable == false
                                ? Icons.remove_red_eye_outlined
                                : Icons.visibility_sharp),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(mainColor), width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(mainColor), width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shadowColor: Colors.black,
                              minimumSize: Size(double.infinity, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              backgroundColor: Color(mainColor)),
                          onPressed: () async {
                            if (userNameCtrl.text.trim().isEmpty) {
                              showwarningsnackbar(
                                  context, 'กรุณากรอกชื่อผู้ใช้');
                            } else if (passwordCtrl.text.trim().isEmpty) {
                              showwarningsnackbar(context, 'กรุณากรอกรหัสผ่าน');
                            } else {
                              User user = User(
                                userName: userNameCtrl.text,
                                userPassword: passwordCtrl.text,
                              );
                              user = await UserAPI().checkLogin(user);
                              if (user.userID != null) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeUi(
                                            userName: user.userFullName,
                                            userImage: user.userImage,
                                            userID: int.parse(
                                                user.userID.toString()))));
                              } else {
                                showwarningsnackbar(
                                    context, 'Incorrect Username or Password');
                              }
                            }
                          },
                          child: Text(
                            'เข้าใช้งาน',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
