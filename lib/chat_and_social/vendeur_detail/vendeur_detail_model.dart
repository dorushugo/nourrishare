import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components_general/plats_voisins/plats_voisins_widget.dart';
import '/components_general/user_card_back/user_card_back_widget.dart';
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
  // Model for UserCardBack component.
  late UserCardBackModel userCardBackModel;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatsRecord? convCreeResult;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatsRecord? convCreeResult2;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    userCardBackModel = createModel(context, () => UserCardBackModel());
  }

  void dispose() {
    unfocusNode.dispose();
    userCardBackModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
