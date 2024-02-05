import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_place_picker.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:io';
import '/flutter_flow/custom_functions.dart' as functions;
import 'profilsettings_widget.dart' show ProfilsettingsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilsettingsModel extends FlutterFlowModel<ProfilsettingsWidget> {
  ///  Local state fields for this page.

  bool mapUI = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for prenom widget.
  FocusNode? prenomFocusNode;
  TextEditingController? prenomController;
  String? Function(BuildContext, String?)? prenomControllerValidator;
  // State field(s) for nom widget.
  FocusNode? nomFocusNode;
  TextEditingController? nomController;
  String? Function(BuildContext, String?)? nomControllerValidator;
  // State field(s) for mail widget.
  FocusNode? mailFocusNode;
  TextEditingController? mailController;
  String? Function(BuildContext, String?)? mailControllerValidator;
  // State field(s) for PhoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberController;
  String? Function(BuildContext, String?)? phoneNumberControllerValidator;
  DateTime? datePicked;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // State field(s) for address widget.
  FocusNode? addressFocusNode;
  TextEditingController? addressController;
  String? Function(BuildContext, String?)? addressControllerValidator;
  // State field(s) for city widget.
  FocusNode? cityFocusNode;
  TextEditingController? cityController;
  String? Function(BuildContext, String?)? cityControllerValidator;
  // State field(s) for postalCode widget.
  FocusNode? postalCodeFocusNode;
  TextEditingController? postalCodeController;
  String? Function(BuildContext, String?)? postalCodeControllerValidator;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // State field(s) for Addresspicker widget.
  var addresspickerValue = FFPlace();

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    prenomFocusNode?.dispose();
    prenomController?.dispose();

    nomFocusNode?.dispose();
    nomController?.dispose();

    mailFocusNode?.dispose();
    mailController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberController?.dispose();

    addressFocusNode?.dispose();
    addressController?.dispose();

    cityFocusNode?.dispose();
    cityController?.dispose();

    postalCodeFocusNode?.dispose();
    postalCodeController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
