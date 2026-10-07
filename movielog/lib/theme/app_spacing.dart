// 8px 간격 단위 (SizedBox, Padding에 사용)
abstract final class AppSpacing {
  static const double unit = 8;

  static const double xs = unit; // 8
  static const double sm = unit * 2; // 16
  static const double md = unit * 3; // 24
  static const double lg = unit * 4; // 32
  static const double xl = unit * 6; // 48
  static const double xxl = unit * 8; // 64
}

// 8px Radius (Card, Button, Input 모서리에 사용)
abstract final class AppRadius {
  static const double base = 8;
}
