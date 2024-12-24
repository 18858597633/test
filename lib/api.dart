import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:nbut_take_out/dioConfig.dart';
class HttpManager{
  final Dio _dio=Dio();
  
  HttpManage(){
    _dio.interceptors.add(Dioconfig());
  }
  Future<Response?> netFetch( 
    url, params, Map<String, dynamic>? header, Options? option,{noTip = false}
    ) async {
      Response response;
      response=await  _dio.request(url,data: params, options: option);
      return response;
  }
}