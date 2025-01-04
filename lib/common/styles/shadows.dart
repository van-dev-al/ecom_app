import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:flutter/material.dart';

class EShadowStyle {
  static final verticalProductShawdow = BoxShadow(
    color: EColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  static final horizontalProductShawdow = BoxShadow(
    color: EColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}
