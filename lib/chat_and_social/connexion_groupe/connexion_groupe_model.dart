import '/flutter_flow/flutter_flow_util.dart';
import 'connexion_groupe_widget.dart' show ConnexionGroupeWidget;
import 'package:flutter/material.dart';

class ConnexionGroupeModel extends FlutterFlowModel<ConnexionGroupeWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for nom widget.
  FocusNode? nomFocusNode;
  TextEditingController? nomController;
  String? Function(BuildContext, String?)? nomControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    nomFocusNode?.dispose();
    nomController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
