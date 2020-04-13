import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_test/model/app_data_model.dart';

class Service {
  static const url = "http://backend.ugbazaar.com/api/y2y?apiKey=112233445500";
  // static const url =
  //     "https://jsonblob.com/api/jsonBlob/453a628d-7c85-11ea-8070-fbc26612a2b7";

  Future<AppDataModel> getTestData() async {
    print('here');
    var response = await http.get(url);
    print('there');
    print("ResponseBody ===>>  ${response.body.toString()}");
    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      AppDataModel result = AppDataModel.fromJson(responseMap);
      return result;
    }
  }
}
