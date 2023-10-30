import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FriendRequestRecord extends FirestoreRecord {
  FriendRequestRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "from" field.
  DocumentReference? _from;
  DocumentReference? get from => _from;
  bool hasFrom() => _from != null;

  // "to" field.
  DocumentReference? _to;
  DocumentReference? get to => _to;
  bool hasTo() => _to != null;

  // "etat" field.
  int? _etat;
  int get etat => _etat ?? 0;
  bool hasEtat() => _etat != null;

  // "users" field.
  List<DocumentReference>? _users;
  List<DocumentReference> get users => _users ?? const [];
  bool hasUsers() => _users != null;

  void _initializeFields() {
    _from = snapshotData['from'] as DocumentReference?;
    _to = snapshotData['to'] as DocumentReference?;
    _etat = castToType<int>(snapshotData['etat']);
    _users = getDataList(snapshotData['users']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('FriendRequest');

  static Stream<FriendRequestRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FriendRequestRecord.fromSnapshot(s));

  static Future<FriendRequestRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FriendRequestRecord.fromSnapshot(s));

  static FriendRequestRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FriendRequestRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FriendRequestRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FriendRequestRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FriendRequestRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FriendRequestRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFriendRequestRecordData({
  DocumentReference? from,
  DocumentReference? to,
  int? etat,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'from': from,
      'to': to,
      'etat': etat,
    }.withoutNulls,
  );

  return firestoreData;
}

class FriendRequestRecordDocumentEquality
    implements Equality<FriendRequestRecord> {
  const FriendRequestRecordDocumentEquality();

  @override
  bool equals(FriendRequestRecord? e1, FriendRequestRecord? e2) {
    const listEquality = ListEquality();
    return e1?.from == e2?.from &&
        e1?.to == e2?.to &&
        e1?.etat == e2?.etat &&
        listEquality.equals(e1?.users, e2?.users);
  }

  @override
  int hash(FriendRequestRecord? e) =>
      const ListEquality().hash([e?.from, e?.to, e?.etat, e?.users]);

  @override
  bool isValidKey(Object? o) => o is FriendRequestRecord;
}
