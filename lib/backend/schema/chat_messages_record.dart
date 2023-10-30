import 'dart:async';

import 'package:from_css_color/from_css_color.dart';
import '/backend/algolia/serialization_util.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatMessagesRecord extends FirestoreRecord {
  ChatMessagesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "chat" field.
  DocumentReference? _chat;
  DocumentReference? get chat => _chat;
  bool hasChat() => _chat != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "time" field.
  DateTime? _time;
  DateTime? get time => _time;
  bool hasTime() => _time != null;

  // "receveur" field.
  DocumentReference? _receveur;
  DocumentReference? get receveur => _receveur;
  bool hasReceveur() => _receveur != null;

  // "users" field.
  List<DocumentReference>? _users;
  List<DocumentReference> get users => _users ?? const [];
  bool hasUsers() => _users != null;

  void _initializeFields() {
    _user = snapshotData['user'] as DocumentReference?;
    _chat = snapshotData['chat'] as DocumentReference?;
    _text = snapshotData['text'] as String?;
    _image = snapshotData['image'] as String?;
    _time = snapshotData['time'] as DateTime?;
    _receveur = snapshotData['receveur'] as DocumentReference?;
    _users = getDataList(snapshotData['users']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chat_messages');

  static Stream<ChatMessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatMessagesRecord.fromSnapshot(s));

  static Future<ChatMessagesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatMessagesRecord.fromSnapshot(s));

  static ChatMessagesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChatMessagesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatMessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatMessagesRecord._(reference, mapFromFirestore(data));

  static ChatMessagesRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      ChatMessagesRecord.getDocumentFromData(
        {
          'user': convertAlgoliaParam(
            snapshot.data['user'],
            ParamType.DocumentReference,
            false,
          ),
          'chat': convertAlgoliaParam(
            snapshot.data['chat'],
            ParamType.DocumentReference,
            false,
          ),
          'text': snapshot.data['text'],
          'image': snapshot.data['image'],
          'time': convertAlgoliaParam(
            snapshot.data['time'],
            ParamType.DateTime,
            false,
          ),
          'receveur': convertAlgoliaParam(
            snapshot.data['receveur'],
            ParamType.DocumentReference,
            false,
          ),
          'users': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['users'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
        },
        ChatMessagesRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<ChatMessagesRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'chat_messages',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'ChatMessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatMessagesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatMessagesRecordData({
  DocumentReference? user,
  DocumentReference? chat,
  String? text,
  String? image,
  DateTime? time,
  DocumentReference? receveur,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'chat': chat,
      'text': text,
      'image': image,
      'time': time,
      'receveur': receveur,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatMessagesRecordDocumentEquality
    implements Equality<ChatMessagesRecord> {
  const ChatMessagesRecordDocumentEquality();

  @override
  bool equals(ChatMessagesRecord? e1, ChatMessagesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.user == e2?.user &&
        e1?.chat == e2?.chat &&
        e1?.text == e2?.text &&
        e1?.image == e2?.image &&
        e1?.time == e2?.time &&
        e1?.receveur == e2?.receveur &&
        listEquality.equals(e1?.users, e2?.users);
  }

  @override
  int hash(ChatMessagesRecord? e) => const ListEquality().hash(
      [e?.user, e?.chat, e?.text, e?.image, e?.time, e?.receveur, e?.users]);

  @override
  bool isValidKey(Object? o) => o is ChatMessagesRecord;
}
