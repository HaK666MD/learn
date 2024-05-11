import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:learn/config/network/constants.dart';

@module
abstract class DioClient {
  @lazySingleton
  Dio dio() => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 10),
        ),
      )..interceptors.add(LogInterceptor());
}
