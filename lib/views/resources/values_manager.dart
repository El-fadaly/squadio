class AppMargin {
  static const double m8 = 8.0;
  static const double m12 = 12.0;
  static const double m14 = 14.0;
  static const double m16 = 16.0;
  static const double m18 = 18.0;
  static const double m20 = 20.0;
}

class AppPadding {
  static const double p2 = 2.0;
  static const double p5 = 5.0;
  static const double p8 = 8.0;
  static const double p10 = 10.0;
  static const double p12 = 12.0;
  static const double p14 = 14.0;
  static const double p16 = 16.0;
  static const double p18 = 18.0;
  static const double p20 = 20.0;
  static const double p28 = 28.0;
  static const double p100 = 100.0;
}

class AppBorderRadius {
  static const double r3 = 3.0;
  static const double r5 = 5.0;
  static const double r10 = 10.0;
  static const double r15 = 15.0;
  static const double r20 = 20.0;
  static const double r25 = 25.0;
  static const double r30 = 30.0;
  static const double r35 = 35.0;
  static const double r40 = 40.0;
}

class AppSize {
  static const double s0 = 0;
  static const double s1 = 1;
  static const double s2 = 2;
  static const double s1_5 = 1.5;
  static const double s4 = 4.0;
  static const double s8 = 8.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s28 = 28.0;
  static const double s40 = 40.0;
  static const double s60 = 60.0;
  static const double s90 = 90.0;
  static const double s100 = 100.0;
  static const double s120 = 120.0;
  static const double s140 = 140.0;
  static const double s160 = 160.0;
  static const double s190 = 190.0;
}

class Insets {
  static double scale = 1;
  static double offsetScale = 1;
  // Regular paddings
  static double get xs => 4 * scale;
  static double get sm => 8 * scale;
  static double get med => 12 * scale;
  static double get lg => 16 * scale;
  static double get xl => 32 * scale;
  static double get xxl => 40 * scale;
  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}
