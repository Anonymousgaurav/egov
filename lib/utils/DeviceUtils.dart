import 'package:flutter/cupertino.dart';

abstract class DeviceUtils {
  /// Return a fraction of screen width
  static double fractionWidth(BuildContext context, {double fraction = 1.0}) {
    assert(fraction > 0.0);

    return MediaQuery.of(context).size.width / fraction;
  }

  /// Return a fraction of screen height
  static double fractionHeight(BuildContext context, {double fraction = 1.0}) {
    assert(fraction > 0.0);

    return MediaQuery.of(context).size.height / fraction;
  }
}
