import 'package:dio/dio.dart';
import 'package:money_tracking_app/constants/baseurl_constanst.dart';
import 'package:money_tracking_app/models/money.dart';

class MoneyAPI {
  final dio = Dio();

  Future<List<Money>> getMoneyByUserID(int userID) async {
    try {
      final responseData = await dio.get('$baseUrl/money/$userID');
      if (responseData.statusCode == 200) {
        return (responseData.data['info'] as List)
            .map((money) => Money.fromJson(money))
            .toList();
      } else {
        return <Money>[];
      }
    } catch (err) {
      print('ERRORs: ${err.toString()}');
      return <Money>[];
    }
  }

  Future<List<Money>> getMoneyByType(Money money) async {
    try {
      final Map<String, dynamic> requestBody = {
        'moneyType': money.moneyType,
        'userId': money.userID,
      };
      final responseData = await dio.get(
        '$baseUrl/money/',
        data: requestBody,
        options: Options(headers: {'content-type': 'application/json'}),
      );
      if (responseData.statusCode == 200) {
        return List<Money>.from(
          responseData.data.map((x) => Money.fromJson(x)),
        );
      } else {
        return [];
      }
    } catch (err) {
      print('ERROR: ${err.toString()}');
      return [];
    }
  }

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
