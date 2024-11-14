import 'package:flutter/material.dart';

class BadgeCount extends Badge {
  BadgeCount({
    super.key,
    required int count,
    super.child,
  }) : super(
          label: Text(count > 9 ? '9+' : '$count'),
          isLabelVisible: count != 0,
        );
}
