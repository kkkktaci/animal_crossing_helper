// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catchable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Catchable _$CatchableFromJson(Map<String, dynamic> json) {
  return Catchable(
    name: json['name'] as String,
    image: json['image'] as String,
    price: json['price'] as String,
    north: (json['north'] as List)?.map((e) => e as String)?.toList(),
    south: (json['south'] as List)?.map((e) => e as String)?.toList(),
    time: (json['time'] as List)?.map((e) => e as String)?.toList(),
    activePlace: json['activePlace'] as String,
    extra: json['extra'] as String,
  );
}

Map<String, dynamic> _$CatchableToJson(Catchable instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'north': instance.north,
      'south': instance.south,
      'time': instance.time,
      'activePlace': instance.activePlace,
      'extra': instance.extra,
    };
