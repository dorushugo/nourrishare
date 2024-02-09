import 'dart:async';

import '/backend/algolia/serialization_util.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatsRecord extends FirestoreRecord {
  ChatsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "users" field.
  List<DocumentReference>? _users;
  List<DocumentReference> get users => _users ?? const [];
  bool hasUsers() => _users != null;

  // "user_a" field.
  DocumentReference? _userA;
  DocumentReference? get userA => _userA;
  bool hasUserA() => _userA != null;

  // "user_b" field.
  DocumentReference? _userB;
  DocumentReference? get userB => _userB;
  bool hasUserB() => _userB != null;

  // "last_message" field.
  String? _lastMessage;
  String get lastMessage => _lastMessage ?? '';
  bool hasLastMessage() => _lastMessage != null;

  // "last_message_time" field.
  DateTime? _lastMessageTime;
  DateTime? get lastMessageTime => _lastMessageTime;
  bool hasLastMessageTime() => _lastMessageTime != null;

  // "last_message_sent_by" field.
  DocumentReference? _lastMessageSentBy;
  DocumentReference? get lastMessageSentBy => _lastMessageSentBy;
  bool hasLastMessageSentBy() => _lastMessageSentBy != null;

  // "last_message_seen_by" field.
  DocumentReference? _lastMessageSeenBy;
  DocumentReference? get lastMessageSeenBy => _lastMessageSeenBy;
  bool hasLastMessageSeenBy() => _lastMessageSeenBy != null;

  // "groupe_chat" field.
  bool? _groupeChat;
  bool get groupeChat => _groupeChat ?? false;
  bool hasGroupeChat() => _groupeChat != null;

  // "group_ref" field.
  DocumentReference? _groupRef;
  DocumentReference? get groupRef => _groupRef;
  bool hasGroupRef() => _groupRef != null;

  void _initializeFields() {
    _users = getDataList(snapshotData['users']);
    _userA = snapshotData['user_a'] as DocumentReference?;
    _userB = snapshotData['user_b'] as DocumentReference?;
    _lastMessage = snapshotData['last_message'] as String?;
    _lastMessageTime = snapshotData['last_message_time'] as DateTime?;
    _lastMessageSentBy =
        snapshotData['last_message_sent_by'] as DocumentReference?;
    _lastMessageSeenBy =
        snapshotData['last_message_seen_by'] as DocumentReference?;
    _groupeChat = snapshotData['groupe_chat'] as bool?;
    _groupRef = snapshotData['group_ref'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Chats');

  static Stream<ChatsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatsRecord.fromSnapshot(s));

  static Future<ChatsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatsRecord.fromSnapshot(s));

  static ChatsRecord fromSnapshot(DocumentSnapshot snapshot) => ChatsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatsRecord._(reference, mapFromFirestore(data));

  static ChatsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      ChatsRecord.getDocumentFromData(
        {
          'users': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['users'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'user_a': convertAlgoliaParam(
            snapshot.data['user_a'],
            ParamType.DocumentReference,
            false,
          ),
          'user_b': convertAlgoliaParam(
            snapshot.data['user_b'],
            ParamType.DocumentReference,
            false,
          ),
          'last_message': snapshot.data['last_message'],
          'last_message_time': convertAlgoliaParam(
            snapshot.data['last_message_time'],
            ParamType.DateTime,
            false,
          ),
          'last_message_sent_by': convertAlgoliaParam(
            snapshot.data['last_message_sent_by'],
            ParamType.DocumentReference,
            false,
          ),
          'last_message_seen_by': convertAlgoliaParam(
            snapshot.data['last_message_seen_by'],
            ParamType.DocumentReference,
            false,
          ),
          'groupe_chat': snapshot.data['groupe_chat'],
          'group_ref': convertAlgoliaParam(
            snapshot.data['group_ref'],
            ParamType.DocumentReference,
            false,
          ),
        },
        ChatsRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<ChatsRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'Chats',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'ChatsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatsRecordData({
  DocumentReference? userA,
  DocumentReference? userB,
  String? lastMessage,
  DateTime? lastMessageTime,
  DocumentReference? lastMessageSentBy,
  DocumentReference? lastMessageSeenBy,
  bool? groupeChat,
  DocumentReference? groupRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_a': userA,
      'user_b': userB,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime,
      'last_message_sent_by': lastMessageSentBy,
      'last_message_seen_by': lastMessageSeenBy,
      'groupe_chat': groupeChat,
      'group_ref': groupRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatsRecordDocumentEquality implements Equality<ChatsRecord> {
  const ChatsRecordDocumentEquality();

  @override
  bool equals(ChatsRecord? e1, ChatsRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.users, e2?.users) &&
        e1?.userA == e2?.userA &&
        e1?.userB == e2?.userB &&
        e1?.lastMessage == e2?.lastMessage &&
        e1?.lastMessageTime == e2?.lastMessageTime &&
        e1?.lastMessageSentBy == e2?.lastMessageSentBy &&
        e1?.lastMessageSeenBy == e2?.lastMessageSeenBy &&
        e1?.groupeChat == e2?.groupeChat &&
        e1?.groupRef == e2?.groupRef;
  }

  @override
  int hash(ChatsRecord? e) => const ListEquality().hash([
        e?.users,
        e?.userA,
        e?.userB,
        e?.lastMessage,
        e?.lastMessageTime,
        e?.lastMessageSentBy,
        e?.lastMessageSeenBy,
        e?.groupeChat,
        e?.groupRef
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatsRecord;
}
