import '/components_general/nav_bar1/nav_bar1_widget.dart';
import '/components_general/profil_settings_card/profil_settings_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'profilpage_widget.dart' show ProfilpageWidget;
import 'package:flutter/material.dart';

class ProfilpageModel extends FlutterFlowModel<ProfilpageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProfilSettingsCard component.
  late ProfilSettingsCardModel profilSettingsCardModel;
  // Model for NavBar1 component.
  late NavBar1Model navBar1Model;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    profilSettingsCardModel =
        createModel(context, () => ProfilSettingsCardModel());
    navBar1Model = createModel(context, () => NavBar1Model());
  }

  @override
  void dispose() {
    profilSettingsCardModel.dispose();
    navBar1Model.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
