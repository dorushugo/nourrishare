import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_place_picker.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:io';
import 'modif_group_widget.dart' show ModifGroupWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
  var addresspickerValue = FFPlace();

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

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
