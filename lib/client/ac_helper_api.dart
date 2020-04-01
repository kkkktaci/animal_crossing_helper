import 'dart:convert';

import 'package:animal_crossing_helper/env.dart';
import 'package:animal_crossing_helper/models/animal.dart';
import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/models/type.dart';
import 'package:animal_crossing_helper/parsers/parse_animal_detail.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class Api {
  Dio htmlDio;
  Dio apiDio;

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
      baseUrl: WIKI_BASE_URL,
    ));
    htmlDio.interceptors.add(loggerInterceptor);

    apiDio = new Dio(BaseOptions(
      baseUrl: API_BASE_URL,
    ));
    apiDio.interceptors.add(loggerInterceptor);
  }

  static Api _apiInstance = Api._();
  factory Api() => _apiInstance;

  Future<List<Catchable>> getFishList() async {
    var html = await apiDio.get('/fish.html');
    return jsonDecode(html.data).map<Catchable>((item) {
      return Catchable.fromJson(item)..type = TYPE.FISH;
    }).toList();
  }

  Future<List<Catchable>> getInsectList() async {
    var html = await apiDio.get('/insect.html');
    return jsonDecode(html.data).map<Catchable>((item) {
      return Catchable.fromJson(item)..type = TYPE.INSECT;
    }).toList();
  }

  Future<List<Animal>> getAnimalList() async {
    var html = await apiDio.get('/animal.html');
    return jsonDecode(html.data).map<Animal>((item) => Animal.fromJson(item)..isMarked=false).toList();
  }

  Future<Animal> getAnimalDetail(String animalName) async {
    var html = await htmlDio.get('/$animalName');
    return parseAnimalDetail(html.data);
  }
}
