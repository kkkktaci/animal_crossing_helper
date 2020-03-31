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
    activePlace: json['place'] as String,
    extra: json['extra'] as String,
    type: _$enumDecodeNullable(_$TYPEEnumMap, json['type']),
  );
}

Map<String, dynamic> _$CatchableToJson(Catchable instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'north': instance.north,
      'south': instance.south,
      'time': instance.time,
      'place': instance.activePlace,
      'extra': instance.extra,
      'type': _$TYPEEnumMap[instance.type],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$TYPEEnumMap = {
  TYPE.FISH: 'FISH',
  TYPE.INSECT: 'INSECT',
};
