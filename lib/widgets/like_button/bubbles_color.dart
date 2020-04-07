import 'package:flutter/material.dart';

class BubblesColor {
  final Color bubblePrimaryColor;
  final Color bubbleSecondColor;
  final Color bubbleThirdColor;
  final Color bubbleFourthColor;

  const BubblesColor({
    @required this.bubblePrimaryColor,
    @required this.bubbleSecondColor,
    this.bubbleThirdColor,
    this.bubbleFourthColor
  });

  Color get getBubbleThirdColor =>
    bubbleThirdColor == null ? bubblePrimaryColor : bubbleThirdColor;

  Color get getBubbleFourthColor =>
    bubbleFourthColor == null ? bubbleSecondColor : bubbleFourthColor;
}