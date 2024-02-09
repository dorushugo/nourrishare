import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'stripe_completion_widget.dart' show StripeCompletionWidget;
import 'package:flutter/material.dart';

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
  // Stores action output result for [Backend Call - API (createAccountLink)] action in Button widget.
  ApiCallResponse? createdAccountLink3;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
