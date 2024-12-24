import 'package:dio/dio.dart';
class Dioconfig extends InterceptorsWrapper {

  onRequest(RequestOptions options, handler) async {
    ///超时
    options.connectTimeout = const Duration(seconds: 30) ;
    options.receiveTimeout = const Duration(seconds: 30) ;

    return super.onRequest(options, handler);
  }
}