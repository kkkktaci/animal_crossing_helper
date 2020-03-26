import 'package:json_annotation/json_annotation.dart';

part 'catchable.g.dart';

@JsonSerializable()

class Catchable {
  Catchable({this.name, this.image, this.price, this.north, this.south, this.time, this.activePlace, this.extra});

  String name;
  String image;
  String price;
  // 北半球出现月份
  List<String> north;
  // 南半球出现月份
  List<String> south;
  // 出现时间
  List<String> time;
  // 出现地点
  String activePlace;
  // 鱼影 或 昆虫出现天气
  String extra;

  factory Catchable.fromJson(Map<String, dynamic> json) => _$CatchableFromJson(json);
  Map<String, dynamic> toJson() => _$CatchableToJson(this);
}