import 'package:flutterwave/utils/CountryCode/CodesData.dart';
import 'package:flutterwave/utils/CountryCode/CodeLocalization.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/cupertino.dart';

mixin ToAlias {}

@deprecated
class CElement = CountryCode with ToAlias;

/// Country element. This is the element that contains all the information
class CountryCode {
  /// the name of the country
  String name;

  /// the flag of the country
  final String flagUri;

  /// the country code (IT,AF..)
  final String code;

  /// the dial code (+39,+93..)
  final String dialCode;

  CountryCode({
    required this.name,
    required this.flagUri,
    required this.code,
    required this.dialCode,
  });

  factory CountryCode.fromCode(String isoCode) {
    final Map<String, String>? jsonCode = codes.firstWhereOrNull(
      (code) => code['code'] == isoCode,
    );

    if (jsonCode == null) {
      throw ('Invalid ISO code');
    }

    return CountryCode.fromJson(jsonCode);
  }

  CountryCode localize(BuildContext context) {
    return this
      ..name =
          CountryLocalizations.of(context)?.translate(this.code) ?? this.name;
  }

  factory CountryCode.fromJson(Map<String, dynamic> json) {
    return CountryCode(
      name: json['name'],
      code: json['code'],
      dialCode: json['dial_code'],
      flagUri: 'flags/${json['code'].toLowerCase()}.png',
    );
  }

  @override
  String toString() => "$dialCode";

  String toLongString() => " ${toCountryStringOnly()} ($dialCode)";

  String toCountryStringOnly() {
    return '$name';
  }
}
