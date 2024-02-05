import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationRecord extends FirestoreRecord {
  NotificationRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "userRef" field.
  List<DocumentReference>? _userRef;
  List<DocumentReference> get userRef => _userRef ?? const [];
  bool hasUserRef() => _userRef != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "seenBool" field.
  bool? _seenBool;
  bool get seenBool => _seenBool ?? false;
  bool hasSeenBool() => _seenBool != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "isCommande" field.
  bool? _isCommande;
  bool get isCommande => _isCommande ?? false;
  bool hasIsCommande() => _isCommande != null;

  // "isChat" field.
  bool? _isChat;
  bool get isChat => _isChat ?? false;
  bool hasIsChat() => _isChat != null;

  // "isFriendRequest" field.
  bool? _isFriendRequest;
  bool get isFriendRequest => _isFriendRequest ?? false;
  bool hasIsFriendRequest() => _isFriendRequest != null;

  // "commandeRef" field.
  DocumentReference? _commandeRef;
  DocumentReference? get commandeRef => _commandeRef;
  bool hasCommandeRef() => _commandeRef != null;

  // "chatRef" field.
  DocumentReference? _chatRef;
  DocumentReference? get chatRef => _chatRef;
  bool hasChatRef() => _chatRef != null;

  // "userFriendRequestRef" field.
  DocumentReference? _userFriendRequestRef;
  DocumentReference? get userFriendRequestRef => _userFriendRequestRef;
  bool hasUserFriendRequestRef() => _userFriendRequestRef != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _text = snapshotData['text'] as String?;
    _userRef = getDataList(snapshotData['userRef']);
    _image = snapshotData['image'] as String?;
    _seenBool = snapshotData['seenBool'] as bool?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _isCommande = snapshotData['isCommande'] as bool?;
    _isChat = snapshotData['isChat'] as bool?;
    _isFriendRequest = snapshotData['isFriendRequest'] as bool?;
    _commandeRef = snapshotData['commandeRef'] as DocumentReference?;
    _chatRef = snapshotData['chatRef'] as DocumentReference?;
    _userFriendRequestRef =
        snapshotData['userFriendRequestRef'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('Notification')
          : FirebaseFirestore.instance.collectionGroup('Notification');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('Notification').doc(id);

  static Stream<NotificationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotificationRecord.fromSnapshot(s));

  static Future<NotificationRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotificationRecord.fromSnapshot(s));

  static NotificationRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificationRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificationRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotificationRecordData({
  String? text,
  String? image,
  bool? seenBool,
  DateTime? timestamp,
  bool? isCommande,
  bool? isChat,
  bool? isFriendRequest,
  DocumentReference? commandeRef,
  DocumentReference? chatRef,
  DocumentReference? userFriendRequestRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'text': text,
      'image': image,
      'seenBool': seenBool,
      'timestamp': timestamp,
      'isCommande': isCommande,
      'isChat': isChat,
      'isFriendRequest': isFriendRequest,
      'commandeRef': commandeRef,
      'chatRef': chatRef,
      'userFriendRequestRef': userFriendRequestRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotificationRecordDocumentEquality
    implements Equality<NotificationRecord> {
  const NotificationRecordDocumentEquality();

  @override
  bool equals(NotificationRecord? e1, NotificationRecord? e2) {
    const listEquality = ListEquality();
    return e1?.text == e2?.text &&
        listEquality.equals(e1?.userRef, e2?.userRef) &&
        e1?.image == e2?.image &&
        e1?.seenBool == e2?.seenBool &&
        e1?.timestamp == e2?.timestamp &&
        e1?.isCommande == e2?.isCommande &&
        e1?.isChat == e2?.isChat &&
        e1?.isFriendRequest == e2?.isFriendRequest &&
        e1?.commandeRef == e2?.commandeRef &&
        e1?.chatRef == e2?.chatRef &&
        e1?.userFriendRequestRef == e2?.userFriendRequestRef;
  }

  @override
  int hash(NotificationRecord? e) => const ListEquality().hash([
        e?.text,
        e?.userRef,
        e?.image,
        e?.seenBool,
        e?.timestamp,
        e?.isCommande,
        e?.isChat,
        e?.isFriendRequest,
        e?.commandeRef,
        e?.chatRef,
        e?.userFriendRequestRef
      ]);

  @override
  bool isValidKey(Object? o) => o is NotificationRecord;
}
