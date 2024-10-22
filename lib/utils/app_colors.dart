import 'package:flutter/material.dart';

class AppColors {
  // Define your colors using hex strings
  static final Color signInButtonColor = fromHex('#73C3DF');
  static final Color primaryTextColor = fromHex('#000000');
  static final Color secondaryTextColor = fromHex('#666666');
  static final Color appTextFieldBorderColor = fromHex('#979797');
  static final Color toastErrorColor = fromHex('#FF0000');

  // Helper function to convert hex string like "#FFFFFF" to Color
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('FF'); // Default opacity if not provided
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
