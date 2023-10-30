import 'dart:async';

import 'package:from_css_color/from_css_color.dart';
import '/backend/algolia/serialization_util.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "chief" field.
  bool? _chief;
  bool get chief => _chief ?? false;
  bool hasChief() => _chief != null;

  // "plats" field.
  List<DocumentReference>? _plats;
  List<DocumentReference> get plats => _plats ?? const [];
  bool hasPlats() => _plats != null;

  // "Cuisinecertifie" field.
  bool? _cuisinecertifie;
  bool get cuisinecertifie => _cuisinecertifie ?? false;
  bool hasCuisinecertifie() => _cuisinecertifie != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "latitude" field.
  double? _latitude;
  double get latitude => _latitude ?? 0.0;
  bool hasLatitude() => _latitude != null;

  // "longitude" field.
  double? _longitude;
  double get longitude => _longitude ?? 0.0;
  bool hasLongitude() => _longitude != null;

  // "geohash" field.
  String? _geohash;
  String get geohash => _geohash ?? '';
  bool hasGeohash() => _geohash != null;

  // "latlong" field.
  LatLng? _latlong;
  LatLng? get latlong => _latlong;
  bool hasLatlong() => _latlong != null;

  // "amis" field.
  List<DocumentReference>? _amis;
  List<DocumentReference> get amis => _amis ?? const [];
  bool hasAmis() => _amis != null;

  // "groupes" field.
  List<DocumentReference>? _groupes;
  List<DocumentReference> get groupes => _groupes ?? const [];
  bool hasGroupes() => _groupes != null;

  // "demandeamissortante" field.
  List<DocumentReference>? _demandeamissortante;
  List<DocumentReference> get demandeamissortante =>
      _demandeamissortante ?? const [];
  bool hasDemandeamissortante() => _demandeamissortante != null;

  // "demandeamientrante" field.
  List<DocumentReference>? _demandeamientrante;
  List<DocumentReference> get demandeamientrante =>
      _demandeamientrante ?? const [];
  bool hasDemandeamientrante() => _demandeamientrante != null;

  // "chats" field.
  List<DocumentReference>? _chats;
  List<DocumentReference> get chats => _chats ?? const [];
  bool hasChats() => _chats != null;

  // "plats_favoris" field.
  List<DocumentReference>? _platsFavoris;
  List<DocumentReference> get platsFavoris => _platsFavoris ?? const [];
  bool hasPlatsFavoris() => _platsFavoris != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _chief = snapshotData['chief'] as bool?;
    _plats = getDataList(snapshotData['plats']);
    _cuisinecertifie = snapshotData['Cuisinecertifie'] as bool?;
    _address = snapshotData['address'] as String?;
    _latitude = castToType<double>(snapshotData['latitude']);
    _longitude = castToType<double>(snapshotData['longitude']);
    _geohash = snapshotData['geohash'] as String?;
    _latlong = snapshotData['latlong'] as LatLng?;
    _amis = getDataList(snapshotData['amis']);
    _groupes = getDataList(snapshotData['groupes']);
    _demandeamissortante = getDataList(snapshotData['demandeamissortante']);
    _demandeamientrante = getDataList(snapshotData['demandeamientrante']);
    _chats = getDataList(snapshotData['chats']);
    _platsFavoris = getDataList(snapshotData['plats_favoris']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  static UsersRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      UsersRecord.getDocumentFromData(
        {
          'email': snapshot.data['email'],
          'display_name': snapshot.data['display_name'],
          'photo_url': snapshot.data['photo_url'],
          'uid': snapshot.data['uid'],
          'created_time': convertAlgoliaParam(
            snapshot.data['created_time'],
            ParamType.DateTime,
            false,
          ),
          'phone_number': snapshot.data['phone_number'],
          'chief': snapshot.data['chief'],
          'plats': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['plats'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'Cuisinecertifie': snapshot.data['Cuisinecertifie'],
          'address': snapshot.data['address'],
          'latitude': convertAlgoliaParam(
            snapshot.data['latitude'],
            ParamType.double,
            false,
          ),
          'longitude': convertAlgoliaParam(
            snapshot.data['longitude'],
            ParamType.double,
            false,
          ),
          'geohash': snapshot.data['geohash'],
          'latlong': convertAlgoliaParam(
            snapshot.data,
            ParamType.LatLng,
            false,
          ),
          'amis': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['amis'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'groupes': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['groupes'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'demandeamissortante': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['demandeamissortante'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'demandeamientrante': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['demandeamientrante'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'chats': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['chats'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'plats_favoris': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['plats_favoris'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
        },
        UsersRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<UsersRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'Users',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  bool? chief,
  bool? cuisinecertifie,
  String? address,
  double? latitude,
  double? longitude,
  String? geohash,
  LatLng? latlong,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'chief': chief,
      'Cuisinecertifie': cuisinecertifie,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'geohash': geohash,
      'latlong': latlong,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.chief == e2?.chief &&
        listEquality.equals(e1?.plats, e2?.plats) &&
        e1?.cuisinecertifie == e2?.cuisinecertifie &&
        e1?.address == e2?.address &&
        e1?.latitude == e2?.latitude &&
        e1?.longitude == e2?.longitude &&
        e1?.geohash == e2?.geohash &&
        e1?.latlong == e2?.latlong &&
        listEquality.equals(e1?.amis, e2?.amis) &&
        listEquality.equals(e1?.groupes, e2?.groupes) &&
        listEquality.equals(e1?.demandeamissortante, e2?.demandeamissortante) &&
        listEquality.equals(e1?.demandeamientrante, e2?.demandeamientrante) &&
        listEquality.equals(e1?.chats, e2?.chats) &&
        listEquality.equals(e1?.platsFavoris, e2?.platsFavoris);
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.chief,
        e?.plats,
        e?.cuisinecertifie,
        e?.address,
        e?.latitude,
        e?.longitude,
        e?.geohash,
        e?.latlong,
        e?.amis,
        e?.groupes,
        e?.demandeamissortante,
        e?.demandeamientrante,
        e?.chats,
        e?.platsFavoris
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
