import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'ajouterunplat_widget.dart' show AjouterunplatWidget;
import 'package:flutter/material.dart';

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
  dynamic jsonDecodedCopy;
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
