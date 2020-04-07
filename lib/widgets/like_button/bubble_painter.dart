import 'package:animal_crossing_helper/widgets/like_button/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BubblePainter extends CustomPainter {
  final int bubblesCount;
  double outerBubblesPositionAngle = 51.42;

  final Color color1;
  final Color color2;
  final Color color3;
  final Color color4;

  double centerX = 0.0;
  double centerY = 0.0;

  final List<Paint> circlePaints = List(4);

  double maxOuterRadius = 0.0;
  double maxInnerRadius = 0.0;
  double maxBubbleSize;

  final currentProgress;

  double currentRadius1 = 0.0;
  double currentSize1 = 0.0;
  double currentRadius2 = 0.0;
  double currentSize2 = 0.0;

  bool isFirst = true;

  BubblePainter({
    @required this.currentProgress,
    this.bubblesCount = 7,
    this.color1 = const Color(0xFFFFC107),
    this.color2 = const Color(0xFFFF9800),
    this.color3 = const Color(0xFFFF5722),
    this.color4 = const Color(0xFFF44336),
  }) {
    outerBubblesPositionAngle = 360.0 / bubblesCount;
    for(int i = 0; i < circlePaints.length; i++) {
      circlePaints[i] = Paint()..style = PaintingStyle.fill;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (isFirst) {
      centerX = size.width * 0.5;
      centerY = size.height * 0.5;
      maxBubbleSize = size.width * 0.05;
      maxOuterRadius = size.width * 0.5 - maxBubbleSize * 2;
      maxInnerRadius = 0.8 * maxOuterRadius;
    }
    _updateOuterPosition();
    _updateInnerPosition();
    _updateBubblePaints();
    _drawOuterBubblesFrame(canvas);
    _drawInnerBubblesFrame(canvas);
  }

  void _drawOuterBubblesFrame(Canvas canvas) {
    var start = outerBubblesPositionAngle / 4.0 * 3.0;
    for (int i = 0; i < bubblesCount; i++) {
      double cX = centerX +
          currentRadius1 *
              math.cos((degToRad(start + outerBubblesPositionAngle * i)));
      double cY = centerY +
        currentRadius1 *
          math.sin((degToRad(start + outerBubblesPositionAngle * i)));
      canvas.drawCircle(Offset(cX, cY), currentSize1,
        circlePaints[(i) % circlePaints.length]);
    }
  }

  void _drawInnerBubblesFrame(Canvas canvas) {
    var start =
        outerBubblesPositionAngle / 4.0 * 3.0 - outerBubblesPositionAngle / 2.0;
    for (int i = 0; i < bubblesCount; i++) {
      double cX = centerX +
        currentRadius2 *
          math.cos((degToRad(start + outerBubblesPositionAngle * i)));
      double cY = centerY +
        currentRadius2 *
          math.sin((degToRad(start + outerBubblesPositionAngle * i)));
      canvas.drawCircle(Offset(cX, cY), currentSize2,
          circlePaints[(i + 1) % circlePaints.length]);
    }
  }

  void _updateOuterPosition() {
    if (currentProgress < 0.3) {
      currentRadius1 = mapValueFromRangeToRange(
          currentProgress, 0.0, 0.3, 0.0, maxOuterRadius * 0.8);
    } else {
      currentRadius1 = mapValueFromRangeToRange(currentProgress, 0.3, 1.0,
          0.8 * maxOuterRadius, maxOuterRadius);
    }
    if (currentProgress == 0) {
      currentSize1 = 0;
    } else if (currentProgress < 0.7) {
      currentSize1 = maxBubbleSize;
    } else {
      currentSize1 =
        mapValueFromRangeToRange(currentProgress, 0.7, 1.0, maxBubbleSize, 0.0);
    }
  }

  void _updateInnerPosition() {
    if (currentProgress < 0.3) {
      currentRadius2 = mapValueFromRangeToRange(
          currentProgress, 0.0, 0.3, 0.0, maxInnerRadius);
    } else {
      currentRadius2 = maxInnerRadius;
    }
    if (currentProgress == 0) {
      currentSize2 = 0;
    } else if (currentProgress < 0.2) {
      currentSize2 = maxBubbleSize;
    } else if (currentProgress < 0.5) {
      currentSize2 = mapValueFromRangeToRange(
          currentProgress, 0.2, 0.5, maxBubbleSize, 0.3 * maxBubbleSize);
    } else {
      currentSize2 = mapValueFromRangeToRange(
        currentProgress, 0.5, 1.0, maxBubbleSize * 0.3, 0.0);
    }
  }

  void _updateBubblePaints() {
    double progress = clamp(currentProgress, 0.6, 1.0);
    int alpha =
      mapValueFromRangeToRange(progress, 0.6, 1.0, 255.0, 0.0).toInt();
    if (currentProgress < 0.5) {
      double progress =
        mapValueFromRangeToRange(currentProgress, 0.0, 0.5, 0.0, 1.0);
      circlePaints[0]
        ..color = Color.lerp(color1, color2, progress).withAlpha(alpha);
      circlePaints[1]
        ..color = Color.lerp(color2, color3, progress).withAlpha(alpha);
      circlePaints[2]
        ..color = Color.lerp(color3, color4, progress).withAlpha(alpha);
      circlePaints[3]
        ..color = Color.lerp(color4, color1, progress).withAlpha(alpha);
    } else {
      double progress =
        mapValueFromRangeToRange(currentProgress, 0.5, 1.0, 0.0, 1.0);
      circlePaints[0]
        ..color = Color.lerp(color2, color3, progress).withAlpha(alpha);
      circlePaints[1]
        ..color = Color.lerp(color3, color4, progress).withAlpha(alpha);
      circlePaints[2]
        ..color = Color.lerp(color4, color1, progress).withAlpha(alpha);
      circlePaints[3]
        ..color = Color.lerp(color1, color2, progress).withAlpha(alpha);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}