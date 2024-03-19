import 'package:dio/dio.dart';
import 'package:weather_app/res/constants.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      'apikey': API_KEY,
    });
    return handler.next(options);
  }
}
