import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'modif_group_widget.dart' show ModifGroupWidget;
import 'package:flutter/material.dart';

class ModifGroupModel extends FlutterFlowModel<ModifGroupWidget> {
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
  // State field(s) for address widget.
  FocusNode? addressFocusNode;
  TextEditingController? addressController;
  String? Function(BuildContext, String?)? addressControllerValidator;
  // State field(s) for Addresspicker widget.
  var addresspickerValue = const FFPlace();

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

    addressFocusNode?.dispose();
    addressController?.dispose();
  }

  /// Action blocks are added here.

  Future test(BuildContext context) async {}

  /// Additional helper methods are added here.
}
