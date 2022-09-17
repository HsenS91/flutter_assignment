import 'package:flutter/material.dart';
import 'package:my_work/styles/colors.dart';
import 'package:my_work/styles/font_weights.dart';


/// App Text Style Definitions
class AppTextStyle {
  static const _baseTextStyle = TextStyle(
    color: AppColors.deepOrange,
    fontWeight: AppFontWeight.regular,
  );

  /// AppBar Text Style
  static TextStyle get appBarTitle {
    return _baseTextStyle.copyWith(
      fontSize: 20,
      fontWeight: AppFontWeight.medium,
    );
  }


  /// Title Text Style
  static TextStyle get title {
    return _baseTextStyle.copyWith(
      color: Colors.black,
      fontSize: 20,
      fontWeight: AppFontWeight.medium,
    );
  }

  /// Label Text Style
  static TextStyle get label {
    return _baseTextStyle.copyWith(
      color: Colors.grey.withOpacity(0.8),
      fontSize: 14,
      fontWeight: AppFontWeight.regular,
    );
  }

  /// PlaceHolder Text Style
  static TextStyle get placeHolder {
    return _baseTextStyle.copyWith(
      color: Colors.grey.withOpacity(0.8),
      fontSize: 12,
      fontWeight: AppFontWeight.regular,
    );
  }

  /// Default App Text Style
  static TextStyle get defaultStyle {
    return _baseTextStyle.copyWith(
      color: Colors.grey.withOpacity(0.8),
      fontSize: 14,
      fontWeight: AppFontWeight.regular,
    );
  }

  /// Button Text Style
  static TextStyle get button {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      fontWeight: AppFontWeight.medium,
    );
  }
}
