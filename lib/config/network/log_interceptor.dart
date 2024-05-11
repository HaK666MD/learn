import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('PATH: [${options.path}]\nMETHOD: [${options.method}]');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('CODE: [${response.statusCode}],');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('ERROR CODE: [${err.response?.statusCode}]\nERROR MESSAGE: [${err.message}],');
    super.onError(err, handler);
  }
}