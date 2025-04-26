import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_tracking_app/constants/color_constant.dart';

class RegisterUi extends StatefulWidget {
  const RegisterUi({super.key});

  @override
  State<RegisterUi> createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {
  bool isVislable = true;
  TextEditingController userFullnameCtrl = TextEditingController(text: '');
  TextEditingController birthdateCtrl = TextEditingController(text: '');
  TextEditingController userNameCtrl = TextEditingController(text: '');
  TextEditingController passwordCtrl = TextEditingController(text: '');

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

  showcompletesnackbar(context, mes) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        mes,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: const Color.fromARGB(255, 6, 107, 9),
    ));
  }

  File? userFile;
  Future<void> openCamera() async {
    final img = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 75,
    );
    if (img == null) return;

    setState(() {
      userFile = File(img.path);
    });
  }

  final _formKey = GlobalKey<FormState>();

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
        title: Text('ลงทะเบียน',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                  onTap: () async {
                                    await (openCamera());
                                  },
                                  child: userFile == null
                                      ? Icon(
                                          Icons.camera_alt,
                                          size: 225,
                                          color: Color(mainColor),
                                        )
                                      : Image.file(
                                          userFile!,
                                          width: 225,
                                          height: 225,
                                          fit: BoxFit.cover,
                                        )),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      _buildTextField(
                          'ชื่อ-สกุล', 'YOUR FULLNAME', userFullnameCtrl),
                      SizedBox(height: 15),
                      _buildTextField(
                          'วัน/เดือน/ปี เกิด', '(DD/MM/YYYY)', birthdateCtrl),
                      SizedBox(height: 15),
                      _buildTextField(
                        'ชื่อผู้ใช้',
                        'USERNAME',
                        userNameCtrl,
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        obscureText: isVislable,
                        controller: passwordCtrl,
                        decoration: InputDecoration(
                          labelText: 'รหัสผ่าน',
                          hintText: 'PASSWORD',
                          prefixIcon: Icon(Icons.lock),
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
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
                            // if (_formKey.currentState!.validate()) {
                            //   registerUser(context);
                            // }
                          },
                          child: Text(
                            'ลงทะเบียน',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller,
      {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
