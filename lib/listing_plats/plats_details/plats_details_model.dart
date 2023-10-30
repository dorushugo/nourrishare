import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/stripe/payment_manager.dart';
import '/components_general/user_card/user_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'plats_details_widget.dart' show PlatsDetailsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlatsDetailsModel extends FlutterFlowModel<PlatsDetailsWidget> {
  ///  Local state fields for this page.

  bool favoris = false;

  bool selecteur = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for UserCard component.
  late UserCardModel userCardModel;
  // Stores action output result for [Custom Action - prixStripe] action in Button widget.
  int? prixStripeValue;
  // Stores action output result for [Stripe Payment] action in Button widget.
  String? paymentId;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    userCardModel = createModel(context, () => UserCardModel());
  }

  void dispose() {
    unfocusNode.dispose();
    userCardModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
