import 'dart:async';

import 'package:from_css_color/from_css_color.dart';
import '/backend/algolia/serialization_util.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GroupesRecord extends FirestoreRecord {
  GroupesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "edited_time" field.
  DateTime? _editedTime;
  DateTime? get editedTime => _editedTime;
  bool hasEditedTime() => _editedTime != null;

  // "bio" field.
  String? _bio;
  String get bio => _bio ?? '';
  bool hasBio() => _bio != null;

  // "Users" field.
  List<DocumentReference>? _users;
  List<DocumentReference> get users => _users ?? const [];
  bool hasUsers() => _users != null;

  // "adresse" field.
  String? _adresse;
  String get adresse => _adresse ?? '';
  bool hasAdresse() => _adresse != null;

  // "latlng" field.
  LatLng? _latlng;
  LatLng? get latlng => _latlng;
  bool hasLatlng() => _latlng != null;

  // "groupepublic" field.
  bool? _groupepublic;
  bool get groupepublic => _groupepublic ?? false;
  bool hasGroupepublic() => _groupepublic != null;

  // "codeconnexion" field.
  String? _codeconnexion;
  String get codeconnexion => _codeconnexion ?? '';
  bool hasCodeconnexion() => _codeconnexion != null;

  // "administrateurs" field.
  List<DocumentReference>? _administrateurs;
  List<DocumentReference> get administrateurs => _administrateurs ?? const [];
  bool hasAdministrateurs() => _administrateurs != null;

  // "supprime" field.
  bool? _supprime;
  bool get supprime => _supprime ?? false;
  bool hasSupprime() => _supprime != null;

  void _initializeFields() {
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _editedTime = snapshotData['edited_time'] as DateTime?;
    _bio = snapshotData['bio'] as String?;
    _users = getDataList(snapshotData['Users']);
    _adresse = snapshotData['adresse'] as String?;
    _latlng = snapshotData['latlng'] as LatLng?;
    _groupepublic = snapshotData['groupepublic'] as bool?;
    _codeconnexion = snapshotData['codeconnexion'] as String?;
    _administrateurs = getDataList(snapshotData['administrateurs']);
    _supprime = snapshotData['supprime'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Groupes');

  static Stream<GroupesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GroupesRecord.fromSnapshot(s));

  static Future<GroupesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GroupesRecord.fromSnapshot(s));

  static GroupesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      GroupesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GroupesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GroupesRecord._(reference, mapFromFirestore(data));

  static GroupesRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      GroupesRecord.getDocumentFromData(
        {
          'display_name': snapshot.data['display_name'],
          'photo_url': snapshot.data['photo_url'],
          'created_time': convertAlgoliaParam(
            snapshot.data['created_time'],
            ParamType.DateTime,
            false,
          ),
          'edited_time': convertAlgoliaParam(
            snapshot.data['edited_time'],
            ParamType.DateTime,
            false,
          ),
          'bio': snapshot.data['bio'],
          'Users': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['Users'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'adresse': snapshot.data['adresse'],
          'latlng': convertAlgoliaParam(
            snapshot.data,
            ParamType.LatLng,
            false,
          ),
          'groupepublic': snapshot.data['groupepublic'],
          'codeconnexion': snapshot.data['codeconnexion'],
          'administrateurs': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['administrateurs'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'supprime': snapshot.data['supprime'],
        },
        GroupesRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<GroupesRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'Groupes',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'GroupesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GroupesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGroupesRecordData({
  String? displayName,
  String? photoUrl,
  DateTime? createdTime,
  DateTime? editedTime,
  String? bio,
  String? adresse,
  LatLng? latlng,
  bool? groupepublic,
  String? codeconnexion,
  bool? supprime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'display_name': displayName,
      'photo_url': photoUrl,
      'created_time': createdTime,
      'edited_time': editedTime,
      'bio': bio,
      'adresse': adresse,
      'latlng': latlng,
      'groupepublic': groupepublic,
      'codeconnexion': codeconnexion,
      'supprime': supprime,
    }.withoutNulls,
  );

  return firestoreData;
}

class GroupesRecordDocumentEquality implements Equality<GroupesRecord> {
  const GroupesRecordDocumentEquality();

  @override
  bool equals(GroupesRecord? e1, GroupesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.createdTime == e2?.createdTime &&
        e1?.editedTime == e2?.editedTime &&
        e1?.bio == e2?.bio &&
        listEquality.equals(e1?.users, e2?.users) &&
        e1?.adresse == e2?.adresse &&
        e1?.latlng == e2?.latlng &&
        e1?.groupepublic == e2?.groupepublic &&
        e1?.codeconnexion == e2?.codeconnexion &&
        listEquality.equals(e1?.administrateurs, e2?.administrateurs) &&
        e1?.supprime == e2?.supprime;
  }

  @override
  int hash(GroupesRecord? e) => const ListEquality().hash([
        e?.displayName,
        e?.photoUrl,
        e?.createdTime,
        e?.editedTime,
        e?.bio,
        e?.users,
        e?.adresse,
        e?.latlng,
        e?.groupepublic,
        e?.codeconnexion,
        e?.administrateurs,
        e?.supprime
      ]);

  @override
  bool isValidKey(Object? o) => o is GroupesRecord;
}
