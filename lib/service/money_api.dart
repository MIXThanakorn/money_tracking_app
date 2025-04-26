import 'package:dio/dio.dart';
import 'package:money_tracking_app/constants/baseurl_constanst.dart';
import 'package:money_tracking_app/models/money.dart';

class MoneyAPI {
  final dio = Dio();
  Future<bool> addMoney(Money money) async {
    try {
      final responseData = await dio.post(
        '${baseUrl}/money/',
        data: money.toJson(),
      );
      if (responseData.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Exception: ${err}');
      return false;
    }
  }
}
