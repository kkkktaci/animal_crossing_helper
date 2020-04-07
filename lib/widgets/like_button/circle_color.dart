import 'package:flutter/material.dart';

class CircleColor {
  final Color start;
  final Color end;

  const CircleColor({@required this.start, @required this.end});

  @override
  bool operator ==(Object other) =>
  identical(this, other) ||
  other is CircleColor &&
    runtimeType == other.runtimeType &&
    start == other.start &&
    end == other.end;

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}