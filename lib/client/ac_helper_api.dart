import 'package:animal_crossing_helper/env.dart';
import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/parsers/parse_fish_list.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class Api {
  Dio htmlDio;

  Api._() {
    var loggerInterceptor = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: false,
      error: true,
      compact: true,
      maxWidth: 90
    );

    htmlDio = new Dio(BaseOptions(
      baseUrl: BASE_URL,
    ));
    htmlDio.interceptors.add(loggerInterceptor);
  }

  static Api _apiInstance = Api._();
  factory Api() => _apiInstance;

  Future<List<Catchable>> getFishList() async {
    var html = await htmlDio.get('/博物馆图鉴');
    return parseFishList(html.data);
  }
}
