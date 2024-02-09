import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'modifier_plat_widget.dart' show ModifierPlatWidget;
import 'package:flutter/material.dart';

class ModifierPlatModel extends FlutterFlowModel<ModifierPlatWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for nomPlat widget.
  FocusNode? nomPlatFocusNode;
  TextEditingController? nomPlatController;
  String? Function(BuildContext, String?)? nomPlatControllerValidator;
  // State field(s) for ingredients widget.
  bool? ingredientsValue;
  FormFieldController<bool>? ingredientsValueController;
  // State field(s) for prix widget.
  FocusNode? prixFocusNode;
  TextEditingController? prixController;
  String? Function(BuildContext, String?)? prixControllerValidator;
  // State field(s) for ingredients widget.
  FocusNode? ingredientsFocusNode;
  TextEditingController? ingredientsController;
  String? Function(BuildContext, String?)? ingredientsControllerValidator;
  // State field(s) for allergenes widget.
  FocusNode? allergenesFocusNode;
  TextEditingController? allergenesController;
  String? Function(BuildContext, String?)? allergenesControllerValidator;
  // State field(s) for Nombre widget.
  int? nombreValue;
  // State field(s) for placedevente widget.
  int? placedeventeValue;
  FormFieldController<int>? placedeventeValueController;
  // State field(s) for Checkbox widget.

  Map<GroupesRecord, bool> checkboxValueMap = {};
  List<GroupesRecord> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    nomPlatFocusNode?.dispose();
    nomPlatController?.dispose();

    prixFocusNode?.dispose();
    prixController?.dispose();

    ingredientsFocusNode?.dispose();
    ingredientsController?.dispose();

    allergenesFocusNode?.dispose();
    allergenesController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
