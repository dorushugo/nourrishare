import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components_general/demarrerconv/demarrerconv_widget.dart';
import '/components_general/group_card_back/group_card_back_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'chat_group_page_widget.dart' show ChatGroupPageWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ChatGroupPageModel extends FlutterFlowModel<ChatGroupPageWidget> {
  ///  Local state fields for this page.

  DocumentReference? groupeRef;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for messageField widget.
  FocusNode? messageFieldFocusNode;
  TextEditingController? messageFieldController;
  String? Function(BuildContext, String?)? messageFieldControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in messageField widget.
  ChatMessagesRecord? messageCreated;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  ChatMessagesRecord? messageCreatedCopy;
  // Model for GroupCardBack component.
  late GroupCardBackModel groupCardBackModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    groupCardBackModel = createModel(context, () => GroupCardBackModel());
  }

  void dispose() {
    unfocusNode.dispose();
    messageFieldFocusNode?.dispose();
    messageFieldController?.dispose();

    groupCardBackModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
