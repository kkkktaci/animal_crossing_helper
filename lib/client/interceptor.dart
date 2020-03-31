import 'package:dio/dio.dart';

class MyInterceptor extends Interceptor {
  @override
  Future onResponse(Response response) async {
    response.headers.removeAll('content-type');
    response.headers.add('content-type', 'application/json; charset=utf-8');
    response.headers.add('contentType', 'application/json; charset=utf-8');
    return response;
  }
}