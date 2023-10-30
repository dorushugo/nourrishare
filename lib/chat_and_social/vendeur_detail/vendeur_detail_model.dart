import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components_general/plats_petits/plats_petits_widget.dart';
import '/components_general/user_card/user_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'vendeur_detail_widget.dart' show VendeurDetailWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VendeurDetailModel extends FlutterFlowModel<VendeurDetailWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for UserCard component.
  late UserCardModel userCardModel;
  // Models for Plats_petits dynamic component.
  late FlutterFlowDynamicModels<PlatsPetitsModel> platsPetitsModels;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    userCardModel = createModel(context, () => UserCardModel());
    platsPetitsModels = FlutterFlowDynamicModels(() => PlatsPetitsModel());
  }

  void dispose() {
    unfocusNode.dispose();
    userCardModel.dispose();
    platsPetitsModels.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
