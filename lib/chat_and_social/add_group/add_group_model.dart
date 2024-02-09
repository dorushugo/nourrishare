import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_group_widget.dart' show AddGroupWidget;
import 'package:flutter/material.dart';

class AddGroupModel extends FlutterFlowModel<AddGroupWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for nom widget.
  FocusNode? nomFocusNode;
  TextEditingController? nomController;
  String? Function(BuildContext, String?)? nomControllerValidator;
  // State field(s) for bio widget.
  FocusNode? bioFocusNode;
  TextEditingController? bioController;
  String? Function(BuildContext, String?)? bioControllerValidator;
  // State field(s) for typedegroupe widget.
  bool? typedegroupeValue;
  FormFieldController<bool>? typedegroupeValueController;
  // State field(s) for codeConnexion widget.
  FocusNode? codeConnexionFocusNode;
  TextEditingController? codeConnexionController;
  String? Function(BuildContext, String?)? codeConnexionControllerValidator;
  // State field(s) for Addresspicker widget.
  var addresspickerValue = const FFPlace();
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  GroupesRecord? groupeCree2;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    nomFocusNode?.dispose();
    nomController?.dispose();

    bioFocusNode?.dispose();
    bioController?.dispose();

    codeConnexionFocusNode?.dispose();
    codeConnexionController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
