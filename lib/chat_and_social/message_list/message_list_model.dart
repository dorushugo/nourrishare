import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components_general/nav_bar1/nav_bar1_widget.dart';
import '/components_general/no_chats/no_chats_widget.dart';
import '/components_general/no_group/no_group_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/request_manager.dart';

import 'message_list_widget.dart' show MessageListWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MessageListModel extends FlutterFlowModel<MessageListWidget> {
  ///  Local state fields for this page.

  int userCompteur = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Algolia Search Results from action on messageList
  List<UsersRecord>? algoliaSearchResults = [];
  // Model for NavBar1 component.
  late NavBar1Model navBar1Model;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  int? chatDuGroupe;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  ChatsRecord? chatDuGroupeItem;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatsRecord? convGroupeCree;

  /// Query cache managers for this widget.

  final _groupeQueryManager = StreamRequestManager<List<GroupesRecord>>();
  Stream<List<GroupesRecord>> groupeQuery({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<GroupesRecord>> Function() requestFn,
  }) =>
      _groupeQueryManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGroupeQueryCache() => _groupeQueryManager.clear();
  void clearGroupeQueryCacheKey(String? uniqueKey) =>
      _groupeQueryManager.clearRequest(uniqueKey);

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    navBar1Model = createModel(context, () => NavBar1Model());
  }

  void dispose() {
    unfocusNode.dispose();
    navBar1Model.dispose();

    /// Dispose query cache managers for this widget.

    clearGroupeQueryCache();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
