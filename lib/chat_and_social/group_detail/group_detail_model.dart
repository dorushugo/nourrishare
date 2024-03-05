import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'group_detail_widget.dart' show GroupDetailWidget;
import 'package:flutter/material.dart';

class GroupDetailModel extends FlutterFlowModel<GroupDetailWidget> {
  ///  Local state fields for this page.

  int compteurUser = 0;

  bool showUsers = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  int? chatDuGroupe2;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  ChatsRecord? chatDuGroupeItem;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatsRecord? chatGroupeCree;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
