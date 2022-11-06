import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFE5E5E5);
  static const Color lightBlueGrey = Color(0xFFF5F6FF);
  static const Color darkBlue = Color(0xFF2B3273);
  static const Color grey = Color(0xFF939BAD);
  static const Color lightRed = Color(0xFFFF3737);
  static const Color nearBlack = Color(0xFF494747);
  static const Color blueGray = Color(0xFF989DC2);

  static const String fontName = 'Qanelas';

    static const kPrimaryColor = Color.fromARGB(255, 74, 58, 158);
    static const kPrimaryLightColor = Color(0xFFF1E6FF);
    static const backgroundColorGrey = Color(0xFFeff3f4);
    static const backgroundColor = Colors.white;
    static Color  bottomNavrBarColor = Color.fromARGB(255, 199, 198, 198);

  static const LinearGradient warning = LinearGradient(
    colors: <Color>[
      Color(0xffffb533),
      Color(0xffffe324),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient error = LinearGradient(
    colors: <Color>[
      Color(0xffe25867),
      Color(0xffd74355),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient yellow = LinearGradient(
    colors: <Color>[
      Color(0xffFDE947),
      Color(0xffF8D90A),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purple = LinearGradient(
    colors: <Color>[
      Color(0xffD28AFC),
      Color(0xff9224D1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blue = LinearGradient(
    colors: <Color>[
      Color(0xFF91CEFE),
      Color(0xFF1086FF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueBlack = LinearGradient(
    colors: <Color>[
      Color(0xFF0B0F5E),
      Color(0xFF000219),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient red = LinearGradient(
    colors: <Color>[
      Color(0xFFF15E8A),
      Color(0xFFD8275C),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient green = LinearGradient(
    colors: <Color>[
      Color(0xFF71F3E0),
      Color(0xFF2BC9B3),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

}