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

  // "buyer" field.
  DocumentReference? _buyer;
  DocumentReference? get buyer => _buyer;
  bool hasBuyer() => _buyer != null;

  // "refund_id" field.
  String? _refundId;
  String get refundId => _refundId ?? '';
  bool hasRefundId() => _refundId != null;

  // "payment_intent_id" field.
  String? _paymentIntentId;
  String get paymentIntentId => _paymentIntentId ?? '';
  bool hasPaymentIntentId() => _paymentIntentId != null;

  // "Ingredientstype" field.
  bool? _ingredientstype;
  bool get ingredientstype => _ingredientstype ?? false;
  bool hasIngredientstype() => _ingredientstype != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "supprime" field.
  bool? _supprime;
  bool get supprime => _supprime ?? false;
  bool hasSupprime() => _supprime != null;

  // "groupe_destine" field.
  List<DocumentReference>? _groupeDestine;
  List<DocumentReference> get groupeDestine => _groupeDestine ?? const [];
  bool hasGroupeDestine() => _groupeDestine != null;

  // "venduavoisin" field.
  bool? _venduavoisin;
  bool get venduavoisin => _venduavoisin ?? false;
  bool hasVenduavoisin() => _venduavoisin != null;

  // "temps_preparation_min" field.
  int? _tempsPreparationMin;
  int get tempsPreparationMin => _tempsPreparationMin ?? 0;
  bool hasTempsPreparationMin() => _tempsPreparationMin != null;

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
    _buyer = snapshotData['buyer'] as DocumentReference?;
    _refundId = snapshotData['refund_id'] as String?;
    _paymentIntentId = snapshotData['payment_intent_id'] as String?;
    _ingredientstype = snapshotData['Ingredientstype'] as bool?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _supprime = snapshotData['supprime'] as bool?;
    _groupeDestine = getDataList(snapshotData['groupe_destine']);
    _venduavoisin = snapshotData['venduavoisin'] as bool?;
    _tempsPreparationMin =
        castToType<int>(snapshotData['temps_preparation_min']);
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
          'buyer': convertAlgoliaParam(
            snapshot.data['buyer'],
            ParamType.DocumentReference,
            false,
          ),
          'refund_id': snapshot.data['refund_id'],
          'payment_intent_id': snapshot.data['payment_intent_id'],
          'Ingredientstype': snapshot.data['Ingredientstype'],
          'created_time': convertAlgoliaParam(
            snapshot.data['created_time'],
            ParamType.DateTime,
            false,
          ),
          'supprime': snapshot.data['supprime'],
          'groupe_destine': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['groupe_destine'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'venduavoisin': snapshot.data['venduavoisin'],
          'temps_preparation_min': convertAlgoliaParam(
            snapshot.data['temps_preparation_min'],
            ParamType.int,
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
  DocumentReference? buyer,
  String? refundId,
  String? paymentIntentId,
  bool? ingredientstype,
  DateTime? createdTime,
  bool? supprime,
  bool? venduavoisin,
  int? tempsPreparationMin,
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
      'buyer': buyer,
      'refund_id': refundId,
      'payment_intent_id': paymentIntentId,
      'Ingredientstype': ingredientstype,
      'created_time': createdTime,
      'supprime': supprime,
      'venduavoisin': venduavoisin,
      'temps_preparation_min': tempsPreparationMin,
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
        e1?.date == e2?.date &&
        e1?.buyer == e2?.buyer &&
        e1?.refundId == e2?.refundId &&
        e1?.paymentIntentId == e2?.paymentIntentId &&
        e1?.ingredientstype == e2?.ingredientstype &&
        e1?.createdTime == e2?.createdTime &&
        e1?.supprime == e2?.supprime &&
        listEquality.equals(e1?.groupeDestine, e2?.groupeDestine) &&
        e1?.venduavoisin == e2?.venduavoisin &&
        e1?.tempsPreparationMin == e2?.tempsPreparationMin;
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
        e?.date,
        e?.buyer,
        e?.refundId,
        e?.paymentIntentId,
        e?.ingredientstype,
        e?.createdTime,
        e?.supprime,
        e?.groupeDestine,
        e?.venduavoisin,
        e?.tempsPreparationMin
      ]);

  @override
  bool isValidKey(Object? o) => o is PlatsRecord;
}
