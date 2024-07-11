import 'package:flutter/material.dart';

class Responsiveness {
  static MediaQueryData get mediaQueryData =>
      MediaQueryData.fromView(WidgetsBinding
          .instance.platformDispatcher.views.single); //Singleton instance

  static Responsiveness _instance = Responsiveness._();

  // To get the default size based on the condition check
  static Size defaultSize = mediaQueryData.size.width >= 998
      ? const Size(1440, 900)
      : const Size(375, 812);

  //Size of our device
  Size uiSize = defaultSize;
  late bool allowFontScaling;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _pixelRatio;
  static late double _statusBarHeight;
  static late double _bottomBarHeight;
  static late double _textScaleFactor;
  // SafeArea vars
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double _safeArea;
  static late double _safeWidth;
  static late double _safeHeight;

  Responsiveness._() {
    MediaQueryData mediaQuery = mediaQueryData;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaler.scale(1);
    _safeAreaHorizontal = mediaQuery.padding.left + mediaQuery.padding.right;
    _safeAreaVertical = mediaQuery.padding.top + mediaQuery.padding.bottom;
    _safeArea = _safeAreaHorizontal + _safeAreaVertical;
    _safeWidth =
        _screenWidth - mediaQuery.padding.left - mediaQuery.padding.right;
    _safeHeight = _screenHeight - _statusBarHeight - _bottomBarHeight;
  }

  factory Responsiveness() {
    return _instance;
  }

  static void init({
    bool allowFontScaling = false,
  }) {
    _instance = Responsiveness._();
    _instance
      ..uiSize = defaultSize
      ..allowFontScaling = allowFontScaling;
  }

  static double get textScaleFactor => _textScaleFactor;

  /// The size of the media in logical pixels (e.g, the size of the screen).
  static double get pixelRatio => _pixelRatio;

  /// The horizontal extent of this size.
  static double get screenWidth => _screenWidth;

  /// The vertical extent of this size. dp
  static double get screenHeight => _screenHeight;

  /// The vertical extent of this size. px
  static double get screenWidthPx => _screenWidth * _pixelRatio;

  /// The vertical extent of this size. px
  static double get screenHeightPx => _screenHeight * _pixelRatio;

  /// The offset from the top
  static double get statusBarHeight => _statusBarHeight;

  /// The offset from the bottom.
  static double get bottomBarHeight => _bottomBarHeight;

  /// Safe Area(Vertical +  Horizontal)
  static double get safeArea => _safeArea;

  /// Safe Area horizontal
  static double get safeAreaHorizontal => _safeAreaHorizontal;

  /// Safe Area Vertical
  static double get safeAreaVertical => _safeAreaVertical;

  /// The ratio of the actual dp to the design draft px
  double get scaleWidth => _screenWidth / uiSize.width;
  double get scaleHeight => _screenHeight / uiSize.height;
  double get scaleText => scaleWidth;

  /// safeAreaScaleWidth
  double get scaleSafeAreaWidth => _safeWidth / uiSize.width;

  /// safeAreaScaleWidth
  double get scaleSafeAreaHeight => _safeHeight / uiSize.height;
  double get scaleSafeAreaText => scaleSafeAreaWidth;

  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  double setWidth(num width) => width * scaleWidth;

  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  double setHeight(num height) => height * scaleHeight;
  double setSafeAreaWidth(num width) => width * scaleSafeAreaWidth;
  double setSafeAreaHeight(num height) => height * scaleSafeAreaHeight;
  double setSpacing(num spacing) => spacing * scaleWidth;
  double setHorizontalSpacing(num spacing) => spacing * scaleWidth;
  double setVerticalSpacing(num spacing) => spacing * scaleHeight;
  double setSafeAreaSpacing(num spacing) => spacing * scaleSafeAreaWidth;

  /// Horizontal Spacing function
  double setSafeAreaHorizontalSpacing(num spacing) =>
      spacing * scaleSafeAreaWidth;

  /// Vertical Spacing function
  double setSafeAreaVerticalSpacing(num spacing) =>
      spacing * scaleSafeAreaHeight;

  /// Icon sizing function
  double setIconSize(num size) => size * scaleWidth;

  /// Icon sizing function
  double setSafeAreaIconSize(num size) => size * scaleSafeAreaWidth;

  ///@param [fontSize]
  ///Font size adaptation method
  ///@param [fontSize] The size of the font on the UI design, in px.
  ///@param [allowFontScaling]
  double setFontSize(num fontSize, {bool allowFontScalingSelf = true}) =>
      (allowFontScalingSelf
          ? (fontSize * scaleText)
          : ((fontSize * scaleText) / _textScaleFactor));

  ///@param [fontSize]
  ///Font size adaptation method
  ///@param [fontSize] The size of the font on the SafeArea UI design, in px.
  ///@param [allowFontScaling]
  double setSafeAreaFontSize(num fontSize,
          {bool allowFontScalingSelf = true}) =>
      (allowFontScalingSelf
          ? (fontSize * scaleSafeAreaText)
          : ((fontSize * scaleSafeAreaText) / _textScaleFactor));
}

extension ResponsivenessExtension on num {
  // shorthand for width
  double get w => Responsiveness().setWidth(this);
  // shorthand for height
  double get h => Responsiveness().setHeight(this);
  // shorthand for fontsize
  double get f => Responsiveness().setFontSize(this);
  // shorthand for spacing(Padding, margin)
  double get s => Responsiveness().setSpacing(this);
  // shorthand for spacing(Vertical Padding, Vertical margin)
  double get vs => Responsiveness().setVerticalSpacing(this);
  // shorthand for spacing(Horizontal Padding, Horizontal margin)
  double get hs => Responsiveness().setHorizontalSpacing(this);
  // shorthand for icon size
  double get ics => Responsiveness().setIconSize(this);
  // shorthand for safe width
  double get sw => Responsiveness().setSafeAreaWidth(this);
  // shorthand for safe height
  double get sh => Responsiveness().setSafeAreaHeight(this);
  // shorthand for safe fontsize
  double get sf => Responsiveness().setSafeAreaFontSize(this);
  // shorthand for spacing(Padding, margin)
  double get ss => Responsiveness().setSafeAreaSpacing(this);
  // shorthand for spacing(Vertical Padding, Vertical margin)
  double get svs => Responsiveness().setSafeAreaVerticalSpacing(this);
  // shorthand for spacing(Vertical Padding, Vertical margin)
  double get shs => Responsiveness().setHorizontalSpacing(this);
  // shorthand for icon size
  double get sics => Responsiveness().setSafeAreaIconSize(this);
  // shorthand for circle diameter size
  double get d => Responsiveness().setWidth(this);
}
