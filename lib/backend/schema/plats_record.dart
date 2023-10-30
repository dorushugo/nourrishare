import 'dart:async';

import 'package:from_css_color/from_css_color.dart';
import '/backend/algolia/serialization_util.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlatsRecord extends FirestoreRecord {
  PlatsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "Seller" field.
  DocumentReference? _seller;
  DocumentReference? get seller => _seller;
  bool hasSeller() => _seller != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  bool hasImages() => _images != null;

  // "categorie" field.
  List<String>? _categorie;
  List<String> get categorie => _categorie ?? const [];
  bool hasCategorie() => _categorie != null;

  // "ingredients" field.
  String? _ingredients;
  String get ingredients => _ingredients ?? '';
  bool hasIngredients() => _ingredients != null;

  // "allergnes" field.
  String? _allergnes;
  String get allergnes => _allergnes ?? '';
  bool hasAllergnes() => _allergnes != null;

  // "Etat" field.
  int? _etat;
  int get etat => _etat ?? 0;
  bool hasEtat() => _etat != null;

  // "quantite" field.
  int? _quantite;
  int get quantite => _quantite ?? 0;
  bool hasQuantite() => _quantite != null;

  // "prix" field.
  double? _prix;
  double get prix => _prix ?? 0.0;
  bool hasPrix() => _prix != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _seller = snapshotData['Seller'] as DocumentReference?;
    _images = getDataList(snapshotData['images']);
    _categorie = getDataList(snapshotData['categorie']);
    _ingredients = snapshotData['ingredients'] as String?;
    _allergnes = snapshotData['allergnes'] as String?;
    _etat = castToType<int>(snapshotData['Etat']);
    _quantite = castToType<int>(snapshotData['quantite']);
    _prix = castToType<double>(snapshotData['prix']);
    _date = snapshotData['date'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Plats');

  static Stream<PlatsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlatsRecord.fromSnapshot(s));

  static Future<PlatsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlatsRecord.fromSnapshot(s));

  static PlatsRecord fromSnapshot(DocumentSnapshot snapshot) => PlatsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlatsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlatsRecord._(reference, mapFromFirestore(data));

  static PlatsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      PlatsRecord.getDocumentFromData(
        {
          'name': snapshot.data['name'],
          'Seller': convertAlgoliaParam(
            snapshot.data['Seller'],
            ParamType.DocumentReference,
            false,
          ),
          'images': safeGet(
            () => snapshot.data['images'].toList(),
          ),
          'categorie': safeGet(
            () => snapshot.data['categorie'].toList(),
          ),
          'ingredients': snapshot.data['ingredients'],
          'allergnes': snapshot.data['allergnes'],
          'Etat': convertAlgoliaParam(
            snapshot.data['Etat'],
            ParamType.int,
            false,
          ),
          'quantite': convertAlgoliaParam(
            snapshot.data['quantite'],
            ParamType.int,
            false,
          ),
          'prix': convertAlgoliaParam(
            snapshot.data['prix'],
            ParamType.double,
            false,
          ),
          'date': convertAlgoliaParam(
            snapshot.data['date'],
            ParamType.DateTime,
            false,
          ),
        },
        PlatsRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<PlatsRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'Plats',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'PlatsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlatsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlatsRecordData({
  String? name,
  DocumentReference? seller,
  String? ingredients,
  String? allergnes,
  int? etat,
  int? quantite,
  double? prix,
  DateTime? date,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'Seller': seller,
      'ingredients': ingredients,
      'allergnes': allergnes,
      'Etat': etat,
      'quantite': quantite,
      'prix': prix,
      'date': date,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlatsRecordDocumentEquality implements Equality<PlatsRecord> {
  const PlatsRecordDocumentEquality();

  @override
  bool equals(PlatsRecord? e1, PlatsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.seller == e2?.seller &&
        listEquality.equals(e1?.images, e2?.images) &&
        listEquality.equals(e1?.categorie, e2?.categorie) &&
        e1?.ingredients == e2?.ingredients &&
        e1?.allergnes == e2?.allergnes &&
        e1?.etat == e2?.etat &&
        e1?.quantite == e2?.quantite &&
        e1?.prix == e2?.prix &&
        e1?.date == e2?.date;
  }

  @override
  int hash(PlatsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.seller,
        e?.images,
        e?.categorie,
        e?.ingredients,
        e?.allergnes,
        e?.etat,
        e?.quantite,
        e?.prix,
        e?.date
      ]);

  @override
  bool isValidKey(Object? o) => o is PlatsRecord;
}
