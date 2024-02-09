import '/backend/backend.dart';
import '/components_general/nav_bar1/nav_bar1_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import 'message_list_widget.dart' show MessageListWidget;
import 'package:flutter/material.dart';

class MessageListModel extends FlutterFlowModel<MessageListWidget> {
  ///  Local state fields for this page.

  int userCompteur = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Algolia Search Results from action on messageList
  List<UsersRecord>? algoliaSearchResults = [];
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  int? chatDuGroupe;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  ChatsRecord? chatDuGroupeItem;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatsRecord? convGroupeCree;
  // Model for NavBar1 component.
  late NavBar1Model navBar1Model;

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

  @override
  void initState(BuildContext context) {
    navBar1Model = createModel(context, () => NavBar1Model());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    navBar1Model.dispose();

    /// Dispose query cache managers for this widget.

    clearGroupeQueryCache();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
