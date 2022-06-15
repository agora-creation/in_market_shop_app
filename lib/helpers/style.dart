import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.blue.shade200,
    fontFamily: 'SourceHanSans-Regular',
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TextStyle(
        color: Colors.black54,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'SourceHanSans-Bold',
      ),
      iconTheme: IconThemeData(color: Colors.black54),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black54),
      bodyText2: TextStyle(color: Colors.black54),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

const BoxDecoration loginDecoration = BoxDecoration(
  color: Color(0xFF42A5F5),
);

const TextStyle loginMessageStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
);

const BoxDecoration kBottomBorder = BoxDecoration(
  border: Border(
    bottom: BorderSide(color: Color(0xFFBDBDBD)),
  ),
);

const String noImagePath = 'assets/images/no_image.png';
