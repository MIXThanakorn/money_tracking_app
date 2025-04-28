import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracking_app/constants/color_constant.dart';
import 'package:money_tracking_app/models/money.dart';
import 'package:money_tracking_app/service/money_api.dart';

class SubHome01Ui extends StatefulWidget {
  final int? userID;
  Function refreshData;

  SubHome01Ui({super.key, required this.userID, required this.refreshData});

  @override
  State<SubHome01Ui> createState() => _SubHome01UiState();
}

class _SubHome01UiState extends State<SubHome01Ui> {
  TextEditingController moneyDetailCtrl = TextEditingController(text: '');
  TextEditingController moneyInCtrl = TextEditingController(text: '');
  TextEditingController moneyDateCtrl = TextEditingController(text: '');

  DateTime? selectedDate;

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime(2026),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        moneyDateCtrl.text = formattedDate;
      });
    }
  }

  String get formattedDate {
    final date = selectedDate ?? DateTime.now();
    return DateFormat('dd/MM/yyyy').format(date);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text('เงินเข้า',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 35),
                  TextFormField(
                    controller: moneyDetailCtrl,
                    decoration: InputDecoration(
                      labelText: 'รายการเงินเข้า',
                      hintText: 'DETAILS',
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
                  SizedBox(height: 20),
                  TextFormField(
                    controller: moneyInCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'จำนวนเงินเข้า',
                      hintText: '0.00',
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
                  SizedBox(height: 20),
                  TextFormField(
                    controller: moneyDateCtrl,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      labelText: 'วัน/เดือน/ปี ที่เงินเข้า',
                      hintText: 'DATE INCOME',
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
                      suffixIcon: IconButton(
                        onPressed: () {
                          _pickDate();
                        },
                        icon: Icon(Icons.calendar_month_outlined),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          shadowColor: Colors.black,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: Color(mainColor)),
                      onPressed: () async {
                        if (moneyDetailCtrl.text.isEmpty) {
                          showwarningsnackbar(
                              context, 'กรุณากรอกรายการเงินเข้า');
                        } else if (moneyInCtrl.text.isEmpty) {
                          showwarningsnackbar(
                              context, 'กรุณากรอกจํานวนเงินเข้า');
                        } else if (moneyDateCtrl.text.isEmpty) {
                          showwarningsnackbar(
                              context, 'กรุณากรอกวัน/เดือน/ปี ที่เงินเข้า');
                        } else {
                          Money money = Money(
                            moneyDetail: moneyDetailCtrl.text,
                            moneyInOut: double.parse(moneyInCtrl.text.trim()),
                            moneyDate: moneyDateCtrl.text,
                            moneyType: 1,
                            userID: widget.userID,
                          );
                          if (await MoneyAPI().addMoney(money)) {
                            showcompletesnackbar(
                                context, 'บันทึกเงินเข้าเรียบร้อย');
                            moneyDetailCtrl.clear();
                            moneyInCtrl.clear();
                            moneyDateCtrl.clear();
                            widget.refreshData();
                          } else {
                            showwarningsnackbar(
                                context, 'บันทึกเงินเข้าไม่สําเร็จ');
                          }
                        }
                      },
                      child: Text(
                        'บันทึกเงินเข้า',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ),
        )));
  }
}
