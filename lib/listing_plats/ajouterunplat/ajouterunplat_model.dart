import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components_general/choix_component/choix_component_widget.dart';
import '/components_general/no_group/no_group_widget.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'ajouterunplat_widget.dart' show AjouterunplatWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AjouterunplatModel extends FlutterFlowModel<AjouterunplatWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Stores action output result for [Backend Call - API (createChatCompletionImage)] action in platImage widget.
  ApiCallResponse? analyseImageCopy;
  // Stores action output result for [Backend Call - API (createChatCompletionText)] action in platImage widget.
  ApiCallResponse? jsonPlatCopy;
  // Stores action output result for [Custom Action - decodeJsonAPI] action in platImage widget.
  dynamic? jsonDecodedCopy;
  // State field(s) for nomPlat widget.
  FocusNode? nomPlatFocusNode;
  TextEditingController? nomPlatController;
  String? Function(BuildContext, String?)? nomPlatControllerValidator;
  // State field(s) for typeofdish widget.
  bool? typeofdishValue;
  FormFieldController<bool>? typeofdishValueController;
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

  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  PlatsRecord? creerPlat;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

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
