import 'package:flutter/material.dart';
import 'package:f_app/screen/auto_screen.dart';
import 'package:f_app/screen/root_screen.dart';
import 'package:f_app/const/colors.dart';

void main(){
  runApp(
    MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      sliderTheme: SliderThemeData(
        thumbColor: primaryColor,
        activeTrackColor: primaryColor,

        inactiveTrackColor: primaryColor.withOpacity(0.3),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryColor,
        backgroundColor: backgroundColor,
      ),
    ),
    home: RootScreen(),
    ),
  );
}