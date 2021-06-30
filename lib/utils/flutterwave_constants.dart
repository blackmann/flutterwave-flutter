import 'package:flutter/material.dart';

class FlutterwaveConstants {
  static const String VERIFYING = "verifying transaction...";
  static const String VERIFYING_ADDRESS = "verifying address...";
  static const String AUTHENTICATING_PIN = "authenticating with pin...";
  static const String INITIATING_PAYMENT = "initiating payment...";
  static const String VALIDATING_OTP = "validating otp...";
  static const String CHARGE_INITIATED = "Charge initiated";
  static const String PENDING = "pending";
  static const String CHARGE_VALIDATED = "Charge validated";
  static const String REQUIRES_AUTH = "Charge authorization data required";
  static const String SUCCESS = "success";
  static const String ERROR = "error";
  static const String SUCCESSFUL = "successful";
  static const String APPROVED_SUCCESSFULLY = "Approved successfully";
  static const String PENDING_OTP_VALIDATION = "Pending OTP validation";

  static Map<int, Color> ajumaColor = {
    50: Color.fromRGBO(83, 143, 255, .1),
    100: Color.fromRGBO(83, 143, 255, .2),
    200: Color.fromRGBO(83, 143, 255, .3),
    300: Color.fromRGBO(83, 143, 255, .4),
    400: Color.fromRGBO(83, 143, 255, .5),
    500: Color.fromRGBO(83, 143, 255, .6),
    600: Color.fromRGBO(83, 143, 255, .7),
    700: Color.fromRGBO(83, 143, 255, .8),
    800: Color.fromRGBO(83, 143, 255, .9),
    900: Color.fromRGBO(83, 143, 255, 1),
  };

  static MaterialColor colorCustom = MaterialColor(0xFF538FFF, ajumaColor);
}
