// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../backend/stripe/payment_manager.dart';
import 'dart:convert'; // Add this line if you are using jsonDecode

Future<String> showStripePaymentSheet(
  int amount,
  String currency,
  String customerEmail,
  bool allowGooglePay,
  bool allowApplePay,
  Color buttonColor,
  Color buttonTextColor,
  String stripeAccountId,
  bool isProd,
  String paymentintentID,
  String clientSecret,
  String ephemeralKey,
  String customerID,
  String accountIDVendor,
) async {
  try {
    // Assuming apiJsonResponse is a Map<String, dynamic> representing your API's JSON response
    // Directly using the response as a Map
    final containsPaymentId = paymentintentID != null;

    // Check if Payment Intent ID exists
    if (!containsPaymentId) {
      return 'Error: No payment ID found in the response';
    }
    Stripe.publishableKey =
        'pk_test_51JQyT3CmEcxfXHvzsbYRDGV45MpoF97oBLUYAJhu0u6a7Xy42Qt0Dx78Rn8GBsr8Qag1iyRJrbtoN4ADoAApeqaL004oQx32AF';
    await Stripe.instance.applySettings();

    // Initialize payment sheet to prepare it to be displayed
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        customerEphemeralKeySecret: ephemeralKey,
        customerId: customerID,
        customFlow: false,
        merchantDisplayName: 'NourriShare',
        applePay: allowApplePay
            ? PaymentSheetApplePay(
                merchantCountryCode:
                    'FR', // Change to your country code if different
              )
            : null,
        googlePay: allowGooglePay
            ? PaymentSheetGooglePay(
                merchantCountryCode:
                    'FR', // Change to your country code if different
                currencyCode: currency,
                testEnv: !isProd,
              )
            : null,
        style: ThemeMode.system,
        appearance: PaymentSheetAppearance(
          primaryButton: PaymentSheetPrimaryButtonAppearance(
            colors: PaymentSheetPrimaryButtonTheme(
              light: PaymentSheetPrimaryButtonThemeColors(
                background: buttonColor,
                text: buttonTextColor,
              ),
              dark: PaymentSheetPrimaryButtonThemeColors(
                background: buttonColor,
                text: buttonTextColor,
              ),
            ),
          ),
        ),
      ),
    );
    print('Payment sheet initialized');

    // Show payment sheet to users
    await Stripe.instance.presentPaymentSheet();

    // Return payment id from the payment sheet to add to your database
    return paymentintentID;
  } catch (e) {
    if (e is StripeException && e.error.code == FailureCode.Canceled) {
      return 'Error: Payment cancelled, please try again later!';
    }
    String debugInfo = 'PaymentIntentID: $paymentintentID, '
        'ClientSecret: $clientSecret, '
        'EphemeralKey: $ephemeralKey, '
        'CustomerID: $customerID';
    return 'Error: $e, Debug Info: $debugInfo';
  }
}
