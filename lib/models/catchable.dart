import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/models/type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'catchable.g.dart';

@JsonSerializable()

class Catchable extends NameThing {
  Catchable({
    String name,
    String image,
    this.price,
    this.north,
    this.south,
    this.time,
    this.activePlace,
    this.extra,
    this.type
  }) : super(name: name, image: image);
  
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
  TYPE type;

  factory Catchable.fromJson(Map<String, dynamic> json) => _$CatchableFromJson(json);
  Map<String, dynamic> toJson() => _$CatchableToJson(this);
}