import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'nav_bar1_widget.dart' show NavBar1Widget;
import 'package:flutter/material.dart';

class NavBar1Model extends FlutterFlowModel<NavBar1Widget> {
  ///  Local state fields for this component.

  String pageName = '';

  int chatUnread = 0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in NavBar1 widget.
  List<ChatsRecord>? messagenotseen;
  // Stores action output result for [Firestore Query - Query a collection] action in NavBar1 widget.
  int? nombreCommandeQuery;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
