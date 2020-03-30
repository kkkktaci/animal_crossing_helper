import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:json_annotation/json_annotation.dart';

part 'animal.g.dart';

@JsonSerializable()
class Animal extends NameThing {
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
  String goal;
  // 是否关注, 不来自api
  bool isMarked;

  Animal({
    String image,
    String name,
    this.sex,
    this.nature,
    this.race,
    this.birthday,
    this.byword,
    this.motto,
    this.foreignWord,
    this.goal,
    this.isMarked = false
  }) : super(name: name, image: image);

  Animal clone() {
    return Animal(
      image: this.image,
      name: this.name,
      sex: this.sex,
      nature: this.nature,
      race: this.race,
      birthday: this.birthday,
      byword: this.byword,
      motto: this.motto,
      foreignWord: this.foreignWord,
      goal: this.goal,
      isMarked: this.isMarked
    );
  }

  factory Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);
  Map<String, dynamic> toJson() => _$AnimalToJson(this);
}