import '/auth/firebase_auth/auth_util.dart';
import '/components_general/nav_bar1/nav_bar1_widget.dart';
import '/components_general/plats_voisins/plats_voisins_widget.dart';
import '/components_general/profil_settings_card/profil_settings_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'profilpage_widget.dart' show ProfilpageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilpageModel extends FlutterFlowModel<ProfilpageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProfilSettingsCard component.
  late ProfilSettingsCardModel profilSettingsCardModel;
  // Model for NavBar1 component.
  late NavBar1Model navBar1Model;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    profilSettingsCardModel =
        createModel(context, () => ProfilSettingsCardModel());
    navBar1Model = createModel(context, () => NavBar1Model());
  }

  void dispose() {
    profilSettingsCardModel.dispose();
    navBar1Model.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
