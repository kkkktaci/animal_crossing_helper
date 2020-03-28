import 'package:animal_crossing_helper/env.dart';
import 'package:animal_crossing_helper/models/animal.dart';
import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/models/type.dart';
import 'package:animal_crossing_helper/parsers/parse_animal_list.dart';
import 'package:animal_crossing_helper/parsers/parse_catchable_list.dart';
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
    return parseCatchableList(html.data, TYPE.FISH);
  }

  Future<List<Catchable>> getInsectList() async {
    var html = await htmlDio.get('/虫图鉴');
    return parseCatchableList(html.data, TYPE.INSECT);
  }

  Future<List<Animal>> getAnimalList() async {
    var html = await htmlDio.get('/小动物图鉴');
    return parseAnimalList(html.data);
  }

  // Future<List<Catchable>> getAnimalDetail(String animalName) async {
  //   var html = await htmlDio.get('/$animalName');
  // }
}
