import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components_general/ingredients_voisins/ingredients_voisins_widget.dart';
import '/components_general/nav_bar1/nav_bar1_widget.dart';
import '/components_general/plats_voisins/plats_voisins_widget.dart';
import '/components_general/profil_card/profil_card_widget.dart';
import '/components_general/switchpage/switchpage_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'accueil_widget.dart' show AccueilWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AccueilModel extends FlutterFlowModel<AccueilWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for ProfilCard component.
  late ProfilCardModel profilCardModel;
  // Model for Switchpage component.
  late SwitchpageModel switchpageModel;
  // Model for NavBar1 component.
  late NavBar1Model navBar1Model;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    profilCardModel = createModel(context, () => ProfilCardModel());
    switchpageModel = createModel(context, () => SwitchpageModel());
    navBar1Model = createModel(context, () => NavBar1Model());
  }

  void dispose() {
    unfocusNode.dispose();
    profilCardModel.dispose();
    switchpageModel.dispose();
    navBar1Model.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
