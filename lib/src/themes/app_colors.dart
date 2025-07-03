import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xff005AAA);
  static const Color primaryShadow = Color(0xff1F363F);
  static const Color primaryGrey = Color(0xff8AB3D7);
  static const Color primaryFont = Color(0xff0059A9);
  static const Color secondaryFont = Color(0xff5490C5);
  static const Color secondaryGrey = Color(0xffE6EEF6);
  static const Color backGroundButtonGrey = Color(0xffE6EEF6);
  static const Color backGroundButtonWhite = Color(0xffF2F4F8);
  static const Color grey = Color(0xff949698);

  static const Color secondary = Color(0xff00C383);
  static const Color yellow = Color(0xffFFC801);
  static const Color black = Color(0xff000000);
  static const Color hintText = Color(0xffC4C6C8);

  static const Color darkest = Color(0xff252525);
  static const Color dark = Color(0xff45484B);
  static const Color medium = Color(0xffB7B8B9);
  static const Color light = Color(0xffCDCDCD);
  static const Color lightest = Color(0xffECECEC);
  static const Color background = const Color(0xffF7F7F7);
  static const Color white = Color(0xffffffff);
  static Color foundationGrey = const Color(0xFF717171);
  static const Color foundationGrey12 = Color(0xff363636);
  static const Color alert = Color(0xffFF2B2B);
  static const Color cardShadow = Color(0x26252525);
  static Color orange = const Color(0xffF59E0B);
  static Color red = const Color(0xffD93E3E);

  static get enable => lightest;

  static get disable => lightest;

  static get error => Colors.redAccent;

  static get focus => primary;

  static get focusError => Colors.red;
}
