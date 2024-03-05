import '/backend/backend.dart';
import '/components_general/group_card_back/group_card_back_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'chat_group_page_widget.dart' show ChatGroupPageWidget;
import 'package:flutter/material.dart';

class ChatGroupPageModel extends FlutterFlowModel<ChatGroupPageWidget> {
  ///  Local state fields for this page.

  DocumentReference? groupeRef;

  int? numberOfOtherUsers;

  int compteur = 0;

  List<DocumentReference> otherUsers = [];
  void addToOtherUsers(DocumentReference item) => otherUsers.add(item);
  void removeFromOtherUsers(DocumentReference item) => otherUsers.remove(item);
  void removeAtIndexFromOtherUsers(int index) => otherUsers.removeAt(index);
  void insertAtIndexInOtherUsers(int index, DocumentReference item) =>
      otherUsers.insert(index, item);
  void updateOtherUsersAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      otherUsers[index] = updateFn(otherUsers[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for ListView widget.
  ScrollController? listViewController;
  // Model for GroupCardBack component.
  late GroupCardBackModel groupCardBackModel;
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
  ChatMessagesRecord? imageEnvoye;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  ChatMessagesRecord? messageCreatedCopy;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
    listViewController = ScrollController();
    groupCardBackModel = createModel(context, () => GroupCardBackModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    columnController?.dispose();
    listViewController?.dispose();
    groupCardBackModel.dispose();
    messageFieldFocusNode?.dispose();
    messageFieldController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
