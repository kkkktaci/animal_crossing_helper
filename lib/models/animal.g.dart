// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Animal _$AnimalFromJson(Map<String, dynamic> json) {
  return Animal(
    image: json['image'] as String,
    name: json['name'] as String,
    sex: json['sex'] as String,
    nature: json['nature'] as String,
    race: json['race'] as String,
    birthday: json['birthday'] as String,
    byword: json['byword'] as String,
    motto: json['motto'] as String,
    foreignWord: json['foreignWord'] as String,
  )..goal = json['goal'] as String;
}

Map<String, dynamic> _$AnimalToJson(Animal instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'sex': instance.sex,
      'nature': instance.nature,
      'race': instance.race,
      'birthday': instance.birthday,
      'byword': instance.byword,
      'motto': instance.motto,
      'foreignWord': instance.foreignWord,
      'goal': instance.goal,
    };
