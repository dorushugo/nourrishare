import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'stripe_completion_widget.dart' show StripeCompletionWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StripeCompletionModel extends FlutterFlowModel<StripeCompletionWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (retrieveAccountInformation)] action in stripeCompletion widget.
  ApiCallResponse? checkOnboardingOnLoad;
  // Stores action output result for [Backend Call - API (Accounts)] action in Button widget.
  ApiCallResponse? createdStripeAccount;
  // Stores action output result for [Backend Call - API (createAccountLink)] action in Button widget.
  ApiCallResponse? createdAccountLink;
  // Stores action output result for [Backend Call - API (createAccountLink)] action in Button widget.
  ApiCallResponse? createdAccountLink2;
  // Stores action output result for [Backend Call - API (retrieveAccountInformation)] action in Button widget.
  ApiCallResponse? retrievedAccountID;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
