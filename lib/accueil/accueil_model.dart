import '/components_general/nav_bar1/nav_bar1_widget.dart';
import '/components_general/profil_card/profil_card_widget.dart';
import '/components_general/switchpage/switchpage_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'accueil_widget.dart' show AccueilWidget;
import 'package:flutter/material.dart';

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

  @override
  void initState(BuildContext context) {
    profilCardModel = createModel(context, () => ProfilCardModel());
    switchpageModel = createModel(context, () => SwitchpageModel());
    navBar1Model = createModel(context, () => NavBar1Model());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    profilCardModel.dispose();
    switchpageModel.dispose();
    navBar1Model.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
