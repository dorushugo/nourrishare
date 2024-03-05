import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'select_address_widget.dart' show SelectAddressWidget;
import 'package:flutter/material.dart';

class SelectAddressModel extends FlutterFlowModel<SelectAddressWidget> {
  ///  Local state fields for this component.

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

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (geolocationUser)] action in Button widget.
  ApiCallResponse? geolocalisation;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
