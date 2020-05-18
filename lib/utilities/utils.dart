import 'package:flutter/material.dart';

extension Context on BuildContext {
  num getItemHeight(Orientation orientation) {
    if (orientation == Orientation.portrait) {
      return MediaQuery.of(this).size.width / 2 - 40;
    }

    return MediaQuery.of(this).size.width / 5 - 40;
  }
}

bool isPortrait(Orientation orientation) => orientation == Orientation.portrait;
