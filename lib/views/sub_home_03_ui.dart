import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracking_app/constants/color_constant.dart';
import 'package:money_tracking_app/models/money.dart';
import 'package:money_tracking_app/service/money_api.dart';

class SubHome03Ui extends StatefulWidget {
  final int? userID;
  Function refreshData;

  SubHome03Ui({super.key, required this.userID, required this.refreshData});

  @override
  State<SubHome03Ui> createState() => _SubHome03UiState();
}

class _SubHome03UiState extends State<SubHome03Ui> {
  TextEditingController moneyDetailCtrl = TextEditingController(text: '');
  TextEditingController moneyOutCtrl = TextEditingController(text: '');
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
                  Text('เงินออก',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 35),
                  TextFormField(
                    controller: moneyDetailCtrl,
                    decoration: InputDecoration(
                      labelText: 'รายการเงินออก',
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
                    controller: moneyOutCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'จำนวนเงินออก',
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
                      labelText: 'วัน/เดือน/ปี ที่เงินออก',
                      hintText: 'DATE OUTCOME',
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
                              context, 'กรุณากรอกรายการเงินออก');
                        } else if (moneyOutCtrl.text.isEmpty) {
                          showwarningsnackbar(
                              context, 'กรุณากรอกจํานวนเงินออก');
                        } else if (moneyDateCtrl.text.isEmpty) {
                          showwarningsnackbar(
                              context, 'กรุณากรอกวัน/เดือน/ปี ที่เงินออก');
                        } else {
                          Money money = Money(
                            moneyDetail: moneyDetailCtrl.text,
                            moneyInOut: double.parse(moneyOutCtrl.text.trim()),
                            moneyDate: moneyDateCtrl.text,
                            moneyType: 2,
                            userID: widget.userID,
                          );
                          if (await MoneyAPI().addMoney(money)) {
                            showcompletesnackbar(
                                context, 'บันทึกเงินออกเรียบร้อย');
                            moneyDetailCtrl.clear();
                            moneyOutCtrl.clear();
                            moneyDateCtrl.clear();
                            widget.refreshData();
                          } else {
                            showwarningsnackbar(
                                context, 'บันทึกเงินออกไม่สําเร็จ');
                          }
                        }
                      },
                      child: Text(
                        'บันทึกเงินออก',
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
