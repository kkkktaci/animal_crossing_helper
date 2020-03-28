import 'package:json_annotation/json_annotation.dart';

part 'animal.g.dart';

@JsonSerializable()
class Animal {
  String image;
  String name;
  String sex;
  // 性格
  String nature;
  // 种族
  String race;
  String birthday;
  // 口头禅
  String byword;
  // 座右铭
  String motto;
  // 外文名称
  String foreignWord;

  Animal({this.image, this.name, this.sex, this.nature, this.race, this.birthday, this.byword, this.motto, this.foreignWord});

  factory Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);
  Map<String, dynamic> toJson() => _$AnimalToJson(this);
}