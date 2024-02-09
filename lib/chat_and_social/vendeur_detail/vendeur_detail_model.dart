import '/backend/backend.dart';
import '/components_general/user_card_back/user_card_back_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'vendeur_detail_widget.dart' show VendeurDetailWidget;
import 'package:flutter/material.dart';

class VendeurDetailModel extends FlutterFlowModel<VendeurDetailWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for UserCardBack component.
  late UserCardBackModel userCardBackModel;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatsRecord? convCreeResult;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatsRecord? convCreeResult2;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    userCardBackModel = createModel(context, () => UserCardBackModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    userCardBackModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
