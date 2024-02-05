// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Begin custom widget code
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:flutter/services.dart';

//! IF validatorErrorText  IS Empty OR Is Equal '' The operation of validating the phone number is disabled
//! IF validatorPhoneMustBeValid IS Equal To True  It gives the number only when the number is valid
//! IF validatorPhoneMustBeValid IS Equal To False  It gives the number always and show validation error when phone number is not valid
class TelephoneText extends StatefulWidget {
  const TelephoneText({
    Key? key,
    this.width,
    this.height,
    this.initialValue,
    this.enabledBorderColor,
    this.enabledBorderWidth,
    this.enabledBorderRadius,
    this.focusedBorderColor,
    this.focusedBorderWidth,
    this.focusedBorderRadius,
    this.fillColor,
    this.textStyleFontFamily,
    this.textStyleColor,
    this.textStyleFontSize,
    this.labelText,
    this.hintText,
    this.dropDownIcon,
    this.validatorErrorText,
    this.validatorErrorColor,
    this.validatorErrorFontFamily,
    this.validatorErrorFontSize,
    this.validatorPhoneMustBeValid,
    this.allowedCountryCodes,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? initialValue;
  final Color? enabledBorderColor;
  final double? enabledBorderWidth;
  final double? enabledBorderRadius;
  final Color? focusedBorderColor;
  final double? focusedBorderWidth;
  final double? focusedBorderRadius;
  final Color? fillColor;
  final String? textStyleFontFamily;
  final Color? textStyleColor;
  final double? textStyleFontSize;
  final String? labelText;
  final String? hintText;
  final Widget? dropDownIcon;
  final String? validatorErrorText;
  final Color? validatorErrorColor;
  final String? validatorErrorFontFamily;
  final double? validatorErrorFontSize;
  final bool? validatorPhoneMustBeValid;
  final List<String>? allowedCountryCodes;

  @override
  _TelephoneTextState createState() => _TelephoneTextState();
}

class _TelephoneTextState extends State<TelephoneText> {
  String phoneNumber = '';
  String country = '';
  String? initialCountryCode;
  String? initialNumber;
  late List<Country> countryList;
  @override
  void initState() {
    countryList = countries;
    if (widget.initialValue == null || widget.initialValue == '')
      FFAppState().ttTelephoneNumber = '';
    else {
      FFAppState().ttTelephoneNumber = widget.initialValue!;
      if (widget.initialValue!.startsWith('+')) {
        var fd = widget.initialValue!.substring(1);
        if (countryList.any((element) => fd.startsWith(element.dialCode))) {
          var countries =
              countryList.where((element) => fd.startsWith(element.dialCode));
          for (var r in countries) {
            if (fd.length >= r.dialCode.length) {
              if (r.dialCode == fd.substring(0, r.dialCode.length)) {
                initialCountryCode = r.code;
                country = r.dialCode;
                initialNumber = fd.substring(r.dialCode.length);
                phoneNumber = initialNumber!;
              }
            }
          }
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
          labelText: widget.labelText,
          enabledBorder: getEnabledBorder(),
          border: getEnabledBorder(),
          focusedBorder: getFocusedBorder(),
          fillColor: widget.fillColor,
          hoverColor: widget.fillColor,
          focusColor: widget.fillColor,
          filled: true,
          hintText: widget.hintText,
          errorBorder: getEnabledBorder(),
          focusedErrorBorder: getEnabledBorder(),
          counter: Offstage(),
          floatingLabelStyle: TextStyle(
            fontFamily: widget.textStyleFontFamily,
            fontSize: widget.textStyleFontSize,
            color: widget.textStyleColor,
          ),
          labelStyle: TextStyle(
            fontFamily: widget.textStyleFontFamily,
            fontSize: widget.textStyleFontSize,
            color: widget.textStyleColor,
          ),
          errorStyle: TextStyle(
            fontFamily: widget.validatorErrorFontFamily,
            fontSize: widget.validatorErrorFontSize,
            color: widget.validatorErrorColor,
          ),
          contentPadding: EdgeInsets.only(
              left: widget.enabledBorderRadius != null
                  ? widget.enabledBorderRadius! / 2
                  : 0,
              right: widget.enabledBorderRadius != null
                  ? widget.enabledBorderRadius! / 2
                  : 0)),
      style: TextStyle(
        fontFamily: widget.textStyleFontFamily,
        fontSize: widget.textStyleFontSize,
        color: widget.textStyleColor,
      ),
      initialValue: initialNumber,
      flagsButtonMargin: EdgeInsets.only(
          left: widget.enabledBorderRadius != null
              ? widget.enabledBorderRadius! / 3
              : 0,
          right: widget.enabledBorderRadius != null
              ? widget.enabledBorderRadius! / 3
              : 0),
      autovalidateMode:
          widget.validatorErrorText != null && widget.validatorErrorText != ''
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
      initialCountryCode: initialCountryCode == null || initialCountryCode == ''
          ? 'US'
          : initialCountryCode,
      autofocus: true,
      invalidNumberMessage: widget.validatorErrorText,
      disableLengthCheck: false,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      dropdownTextStyle: TextStyle(
          fontFamily: widget.textStyleFontFamily,
          fontSize: widget.textStyleFontSize,
          color: widget.textStyleColor),
      dropdownDecoration: BoxDecoration(
        borderRadius: widget.enabledBorderRadius != null
            ? BorderRadius.circular(widget.enabledBorderRadius!)
            : BorderRadius.circular(0),
        boxShadow: null,
        color: widget.fillColor,
      ),
      dropdownIcon: getDropDownIcon(),
      dropdownIconPosition: IconPosition.leading,
      cursorColor: widget.textStyleColor,
      countries: widget.allowedCountryCodes == null ||
              widget.allowedCountryCodes!.length == 0
          ? null
          : widget.allowedCountryCodes,
      onChanged: (phone) {
        setState(() {
          phoneNumber = phone.number;
          country = phone.countryCode;
          changeAppState();
        });
      },
      onCountryChanged: (phone) {
        setState(() {
          print('country changed');
          country = phone.dialCode;
          changeAppState();
        });
      },
    );
  }

  Icon getDropDownIcon() {
    if (widget.dropDownIcon == null) return Icon(Icons.arrow_drop_down);
    if (widget.dropDownIcon! is Icon) return widget.dropDownIcon! as Icon;
    return Icon(Icons.arrow_drop_down);
  }

  void changeAppState() {
    var fullNumber = country + phoneNumber;
    if (!fullNumber.contains('+')) fullNumber = '+' + fullNumber;
    print(fullNumber);
    if (fullNumber == '' || fullNumber.length <= 2) {
      FFAppState().ttTelephoneNumber = '';
    } else {
      if (widget.validatorPhoneMustBeValid != null &&
          widget.validatorPhoneMustBeValid!) {
        var coCode = country;
        if (coCode.startsWith('+')) coCode = coCode.substring(1);
        if (countryList.any((element) => element.dialCode == coCode)) {
          var el =
              countryList.firstWhere((element) => element.dialCode == coCode);
          if (el.maxLength == phoneNumber.length)
            FFAppState().ttTelephoneNumber = fullNumber;
          else {
            FFAppState().ttTelephoneNumber = '';
            return;
          }
        }
      }
      FFAppState().ttTelephoneNumber = fullNumber;
    }
  }

  InputBorder? getEnabledBorder() {
    if (widget.enabledBorderColor == null) return null;
    return OutlineInputBorder(
        borderRadius: widget.enabledBorderRadius != null
            ? BorderRadius.circular(widget.enabledBorderRadius!)
            : BorderRadius.circular(0),
        borderSide: BorderSide(
            color: widget.enabledBorderColor!,
            width: widget.enabledBorderWidth != null
                ? widget.enabledBorderWidth!
                : 0));
  }

  InputBorder? getFocusedBorder() {
    if (widget.focusedBorderColor == null) return null;
    return OutlineInputBorder(
        borderRadius: widget.focusedBorderRadius != null
            ? BorderRadius.circular(widget.focusedBorderRadius!)
            : BorderRadius.circular(0),
        borderSide: BorderSide(
            color: widget.focusedBorderColor!,
            width: widget.focusedBorderWidth != null
                ? widget.focusedBorderWidth!
                : 0));
  }
}
