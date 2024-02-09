import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'profilsettings_widget.dart' show ProfilsettingsWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilsettingsModel extends FlutterFlowModel<ProfilsettingsWidget> {
  ///  Local state fields for this page.

  List<String> propositionAutocomplete = [];
  void addToPropositionAutocomplete(String item) =>
      propositionAutocomplete.add(item);
  void removeFromPropositionAutocomplete(String item) =>
      propositionAutocomplete.remove(item);
  void removeAtIndexFromPropositionAutocomplete(int index) =>
      propositionAutocomplete.removeAt(index);
  void insertAtIndexInPropositionAutocomplete(int index, String item) =>
      propositionAutocomplete.insert(index, item);
  void updatePropositionAutocompleteAtIndex(
          int index, Function(String) updateFn) =>
      propositionAutocomplete[index] = updateFn(propositionAutocomplete[index]);

  double? lat;

  double? long;

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
  // State field(s) for Adresse widget.
  final adresseKey = GlobalKey();
  FocusNode? adresseFocusNode;
  TextEditingController? adresseController;
  String? adresseSelectedOption;
  String? Function(BuildContext, String?)? adresseControllerValidator;
  // Stores action output result for [Backend Call - API (Autocomplete Adress)] action in Adresse widget.
  ApiCallResponse? propositionsAdresse;
  // Stores action output result for [Backend Call - API (SearchCityAndPostalCode)] action in Adresse widget.
  ApiCallResponse? searchCity;
  // Stores action output result for [Backend Call - API (SearchCityAndPostalCode)] action in Adresse widget.
  ApiCallResponse? searchCity2;
  // State field(s) for city widget.
  final cityKey = GlobalKey();
  FocusNode? cityFocusNode;
  TextEditingController? cityController;
  String? citySelectedOption;
  String? Function(BuildContext, String?)? cityControllerValidator;
  // State field(s) for postal_code widget.
  final postalCodeKey = GlobalKey();
  FocusNode? postalCodeFocusNode;
  TextEditingController? postalCodeController;
  String? postalCodeSelectedOption;
  String? Function(BuildContext, String?)? postalCodeControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
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

    adresseFocusNode?.dispose();

    cityFocusNode?.dispose();

    postalCodeFocusNode?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
