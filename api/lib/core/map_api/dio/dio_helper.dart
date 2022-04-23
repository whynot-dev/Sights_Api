import 'package:dio/dio.dart';

class DioHelper {
  static const baseUrl = 'https://api.opentripmap.com/0.1/';

  static const timeout = 30000;

  static Dio getDio() {
    Dio dio = Dio()
      ..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ))
      ..options.receiveDataWhenStatusError = true
      ..options.baseUrl = baseUrl
      ..options.sendTimeout = timeout
      ..options.connectTimeout = timeout
      ..options.receiveTimeout = timeout;
    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
          handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) async {
          handler.next(response);
        },
        onError: (DioError error, ErrorInterceptorHandler handler) async {
          print('---error response: ${error.message}');
        },
      ),
    );
    return dio;
  }
}