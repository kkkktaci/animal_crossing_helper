import 'package:animal_crossing_helper/widgets/like_button/bubble_painter.dart';
import 'package:animal_crossing_helper/widgets/like_button/bubbles_color.dart';
import 'package:animal_crossing_helper/widgets/like_button/circle_color.dart';
import 'package:animal_crossing_helper/widgets/like_button/circle_painter.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  /// size of button widget
  final double size;

  /// animation duration of change state to like
  final Duration animationDuration;

  /// size of bubbles
  final double bubbleSize;

  /// colors of bubbles
  final BubblesColor bubblesColor;

  /// size of circle;
  final double circleSize;

  /// colors of circle
  final CircleColor circleColor;

  final Function(bool) onTap;

  final Widget Function(bool isLike) builder;

  final bool isLike;

  const LikeButton({
    Key key,
    this.size: 30.0,
    this.builder,
    bubbleSize,
    circleSize,
    this.isLike: false,
    this.bubblesColor = const BubblesColor(
      bubblePrimaryColor: const Color(0xFFFFC107),
      bubbleSecondColor: const Color(0xFFFF9800),
      bubbleThirdColor: const Color(0xFFFF5722),
      bubbleFourthColor: const Color(0xFFF44336),
    ),
    this.circleColor = const CircleColor(
      start: const Color(0xFFFF5722),
      end: const Color(0xFFFFC107)
    ),
    this.onTap,
    this.animationDuration
  }) : assert(size != null),
  assert(animationDuration != null),
  bubbleSize = bubbleSize ?? size * 2,
  circleSize = circleSize ?? size * 2,
  super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with TickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _outerCircleAnimation;
  Animation<double> _innerCircleAnimation;
  Animation<double> _scaleAnimation;
  Animation<double> _bubblesAnimation;

  bool _isLike = false;

  @override
  void initState() {
    super.initState();
    _isLike = widget.isLike;
    _controller = AnimationController(vsync: this, duration: widget.animationDuration);
    _initAnimation();
  }

  // @override
  // void didUpdateWidget(LikeButton oldWidget) {
  //   _isLike = widget.isLike;
  //   _controller = AnimationController(vsync: this, duration: widget.animationDuration);
  //   _initAnimation();
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, w) {
          return Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: <Widget>[
              CustomPaint(
                size: Size(widget.bubbleSize, widget.bubbleSize),
                painter: BubblePainter(
                  currentProgress: _bubblesAnimation.value,
                  color1: widget.bubblesColor.bubblePrimaryColor,
                  color2: widget.bubblesColor.bubbleSecondColor,
                  color3: widget.bubblesColor.bubbleThirdColor,
                  color4: widget.bubblesColor.bubbleFourthColor,
                ),
              ),
              CustomPaint(
                size: Size(widget.circleSize, widget.circleSize),
                painter: CirclePainter(
                  outerCircleRadiusProgress: _outerCircleAnimation.value,
                  innerCircleRadiusProgress: _innerCircleAnimation.value,
                  circleColor: widget.circleColor
                ),
              ),
              Container(
                width: widget.size,
                height: widget.size,
                alignment: Alignment.center,
                child: Transform.scale(
                  scale: ((_isLike ?? true) && _controller.isAnimating)
                    ? _scaleAnimation.value
                    : 1.0,
                  child: SizedBox(
                    width: widget.size,
                    height: widget.size,
                    child: widget.builder(_isLike),
                  ),
                )
              )
            ],
          );
        }),
    );
  }

  void _onTap() {
    if (_controller.isAnimating) return;
    _isLike = !_isLike;
    _handleIsLikeChanged(_isLike);
    if (widget.onTap != null) {
      widget.onTap(_isLike);
    }
  }

  void _handleIsLikeChanged(bool like) {
    if (mounted) {
      setState(() {
        if (like) {
          _controller.reset();
          _controller.forward();
        }
      });
    }
  }

  void _initAnimation() {
    _outerCircleAnimation = Tween<double>(
      begin: 0.1,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.3,
          curve: Curves.ease
        )
      )
    );

    _innerCircleAnimation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.2,
          0.5,
          curve: Curves.ease
        )
      )
    );

    _scaleAnimation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.35,
          0.7,
          curve: OvershootCurve()
        )
      )
    );

    _bubblesAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.1,
          1.0,
          curve: Curves.decelerate
        )
      )
    );
  }
}

class OvershootCurve extends Curve {
  const OvershootCurve([this.period = 2.5]);

  final double period;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    t -= 1.0;
    return t * t * ((period + 1) * t + period) + 1.0;
  }

  @override
  String toString() {
    return '$runtimeType($period)';
  }
}