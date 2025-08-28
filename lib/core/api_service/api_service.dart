import 'package:digital_hub_task/core/api_service/api_constant.dart';
import 'package:dio/dio.dart';

abstract class ApiService {
 static Dio dio = Dio(BaseOptions(baseUrl: ApiConstant.baseUrl));

  static Future get(String endPoint, Map<String, dynamic> queryParameters) async {
    var response = await dio.get(endPoint, queryParameters: queryParameters);
    return response.data;
  }
}
