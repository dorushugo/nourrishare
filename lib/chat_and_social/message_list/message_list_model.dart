import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components_general/aucunelement/aucunelement_widget.dart';
import '/components_general/nav_bar1/nav_bar1_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'message_list_widget.dart' show MessageListWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MessageListModel extends FlutterFlowModel<MessageListWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Algolia Search Results from action on messageList
  List<UsersRecord>? algoliaSearchResults = [];
  // Model for NavBar1 component.
  late NavBar1Model navBar1Model;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    navBar1Model = createModel(context, () => NavBar1Model());
  }

  void dispose() {
    unfocusNode.dispose();
    navBar1Model.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
