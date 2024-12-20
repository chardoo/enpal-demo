import 'package:enpal/bloc/theme/them_data.dart';
import 'package:flutter/material.dart';

abstract class ThemeState {
  final ThemeData themeData;
  const ThemeState(this.themeData);
}
class LightThemeState extends ThemeState {
  LightThemeState() : super(AppThemes.lightTheme);
}
class DarkThemeState extends ThemeState {
  DarkThemeState() : super(AppThemes.darkTheme);
}
