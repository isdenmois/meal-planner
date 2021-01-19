import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const platform = const MethodChannel('flutter.native/helper');

changeNavigationBarColor(Color color, Brightness brightness) {
  if (color == null) return;

  final dark = brightness == Brightness.dark;
  final hashColor = '#${color.hashCode.toRadixString(16)}';

  platform.invokeMethod(
      'changeNavigationBarColor', {'color': hashColor, 'dark': dark});
}
