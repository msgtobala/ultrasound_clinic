import 'dart:async';

import 'package:flutter/material.dart';

enum ShimmerProLight { lighter, darker }

class ShimmerPro extends StatefulWidget {
  final Duration duration;
  final int depth;
  int? maxLine;
  double? textSize;
  double? borderRadius;
  double? width;
  double? height;
  bool isText = false;
  bool isSized = false;
  bool isGenerated = false;
  Widget? child;
  Alignment? alignment;
  ShimmerProLight? light;
  Color scaffoldBackgroundColor;

  ShimmerPro.sized({
    Key? key,
    this.depth = 20,
    this.duration = const Duration(seconds: 1),
    this.borderRadius = 10,
    this.alignment = Alignment.center,
    this.light = ShimmerProLight.darker,
    required this.scaffoldBackgroundColor,
    required this.height,
    required this.width,
  }) : super(key: key) {
    isSized = true;
  }

  ShimmerPro.text({
    Key? key,
    this.depth = 20,
    this.duration = const Duration(seconds: 1),
    this.maxLine = 3,
    this.textSize = 14,
    this.borderRadius = 10,
    this.alignment = Alignment.center,
    this.light = ShimmerProLight.darker,
    required this.scaffoldBackgroundColor,
    this.width,
  }) : super(key: key) {
    isText = true;
  }

  ShimmerPro.generated({
    Key? key,
    this.depth = 20,
    this.duration = const Duration(seconds: 1),
    this.borderRadius = 10,
    this.alignment = Alignment.center,
    this.light = ShimmerProLight.darker,
    required this.scaffoldBackgroundColor,
    required this.child,
    this.width,
    this.height,
  }) : super(key: key) {
    isGenerated = true;
  }

  @override
  _ShimmerProState createState() => _ShimmerProState();
}

class _ShimmerProState extends State<ShimmerPro> {
  late int _colorInt;
  late Brightness _brightness;
  bool _isStart = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _brightness = widget.light == ShimmerProLight.lighter
        ? Brightness.light
        : Brightness.dark;

    _colorInt = _brightness == Brightness.light ? -50 : 5;

    onReady();
  }

  onReady() async {
    await Future.delayed(const Duration(microseconds: 1));
    setState(() {
      if (_isStart) {
        _colorInt += widget.depth;
      } else {
        _colorInt -= widget.depth;
      }
    });
    _timer = Timer.periodic(widget.duration, (timer) {
      setState(() {
        if (_isStart) {
          _colorInt -= widget.depth;
        } else {
          _colorInt += widget.depth;
        }
        _isStart = !_isStart;
      });
    });
  }

  @override
  void dispose() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int textWDepth = _brightness == Brightness.dark ? 10 : -10;
    final Color textAndGeneratedWColor = Color.fromARGB(
      widget.scaffoldBackgroundColor.alpha,
      widget.scaffoldBackgroundColor.red + textWDepth,
      widget.scaffoldBackgroundColor.green + textWDepth,
      widget.scaffoldBackgroundColor.blue + textWDepth,
    );
    final Color textWColorTextAndSize = Color.fromARGB(
      widget.scaffoldBackgroundColor.alpha,
      widget.scaffoldBackgroundColor.red + _colorInt + 10,
      widget.scaffoldBackgroundColor.green + _colorInt + 10,
      widget.scaffoldBackgroundColor.blue + _colorInt + 10,
    );

    if (widget.isGenerated) {
      return Align(
        alignment: widget.alignment!,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
            color: textAndGeneratedWColor,
          ),
          duration: widget.duration,
          margin: const EdgeInsets.all(10),
          width: widget.width,
          height: widget.height,
          child: widget.child,
        ),
      );
    } else if (widget.isSized) {
      return Align(
        alignment: widget.alignment!,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
            color: textWColorTextAndSize,
          ),
          duration: widget.duration,
          margin: const EdgeInsets.all(10),
          height: widget.height,
          width: widget.width,
        ),
      );
    } else {
      return Align(
        alignment: widget.alignment!,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
            color: textAndGeneratedWColor,
          ),
          duration: widget.duration,
          height: (widget.maxLine! * (widget.textSize! + 10) + 10),
          width: widget.width ?? double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              widget.maxLine!,
              (index) => AnimatedContainer(
                duration: widget.duration,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius!),
                  color: textWColorTextAndSize,
                ),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                height: widget.textSize,
                width: (widget.maxLine! - 1) == index
                    ? (widget.maxLine != 1
                        ? (widget.width ?? double.infinity) / 3
                        : null)
                    : null,
              ),
            )
              ..insert(
                0,
                const SizedBox(
                  height: 5,
                ),
              )
              ..add(
                const SizedBox(
                  height: 5,
                ),
              ),
          ),
        ),
      );
    }
  }
}
