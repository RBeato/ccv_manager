import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

isMobile([BoxConstraints? constraints]) {
  if (kIsWeb) {
    if (constraints != null && constraints.maxWidth < 700) {
      return true;
    }
    return false;
    // Running on the web!
  } else {
    return true;
    // Running on mobile or desktop!
  }
}
