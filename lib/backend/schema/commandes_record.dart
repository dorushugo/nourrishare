import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CommandesRecord extends FirestoreRecord {
  CommandesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  bool hasAmount() => _amount != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "tax" field.
  double? _tax;
  double get tax => _tax ?? 0.0;
  bool hasTax() => _tax != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "vendor_name" field.
  String? _vendorName;
  String get vendorName => _vendorName ?? '';
  bool hasVendorName() => _vendorName != null;

  // "vendor_ref" field.
  DocumentReference? _vendorRef;
  DocumentReference? get vendorRef => _vendorRef;
  bool hasVendorRef() => _vendorRef != null;

  // "plats" field.
  List<DocumentReference>? _plats;
  List<DocumentReference> get plats => _plats ?? const [];
  bool hasPlats() => _plats != null;

  // "delai_minutes" field.
  int? _delaiMinutes;
  int get delaiMinutes => _delaiMinutes ?? 0;
  bool hasDelaiMinutes() => _delaiMinutes != null;

  // "isVoisins" field.
  bool? _isVoisins;
  bool get isVoisins => _isVoisins ?? false;
  bool hasIsVoisins() => _isVoisins != null;

  // "buyer" field.
  DocumentReference? _buyer;
  DocumentReference? get buyer => _buyer;
  bool hasBuyer() => _buyer != null;

  // "latlng_livraison" field.
  LatLng? _latlngLivraison;
  LatLng? get latlngLivraison => _latlngLivraison;
  bool hasLatlngLivraison() => _latlngLivraison != null;

  // "adresse_livraison" field.
  String? _adresseLivraison;
  String get adresseLivraison => _adresseLivraison ?? '';
  bool hasAdresseLivraison() => _adresseLivraison != null;

  // "date_livraison" field.
  String? _dateLivraison;
  String get dateLivraison => _dateLivraison ?? '';
  bool hasDateLivraison() => _dateLivraison != null;

  // "status_number" field.
  int? _statusNumber;
  int get statusNumber => _statusNumber ?? 0;
  bool hasStatusNumber() => _statusNumber != null;

  // "datetime_Livraison" field.
  DateTime? _datetimeLivraison;
  DateTime? get datetimeLivraison => _datetimeLivraison;
  bool hasDatetimeLivraison() => _datetimeLivraison != null;

  // "isInstant" field.
  bool? _isInstant;
  bool get isInstant => _isInstant ?? false;
  bool hasIsInstant() => _isInstant != null;

  // "stripe_session_id" field.
  String? _stripeSessionId;
  String get stripeSessionId => _stripeSessionId ?? '';
  bool hasStripeSessionId() => _stripeSessionId != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  bool hasQuantity() => _quantity != null;

  // "payment_url" field.
  String? _paymentUrl;
  String get paymentUrl => _paymentUrl ?? '';
  bool hasPaymentUrl() => _paymentUrl != null;

  // "as_proof" field.
  bool? _asProof;
  bool get asProof => _asProof ?? false;
  bool hasAsProof() => _asProof != null;

  // "proofs_url" field.
  List<String>? _proofsUrl;
  List<String> get proofsUrl => _proofsUrl ?? const [];
  bool hasProofsUrl() => _proofsUrl != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _amount = castToType<double>(snapshotData['amount']);
    _status = snapshotData['status'] as String?;
    _tax = castToType<double>(snapshotData['tax']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _vendorName = snapshotData['vendor_name'] as String?;
    _vendorRef = snapshotData['vendor_ref'] as DocumentReference?;
    _plats = getDataList(snapshotData['plats']);
    _delaiMinutes = castToType<int>(snapshotData['delai_minutes']);
    _isVoisins = snapshotData['isVoisins'] as bool?;
    _buyer = snapshotData['buyer'] as DocumentReference?;
    _latlngLivraison = snapshotData['latlng_livraison'] as LatLng?;
    _adresseLivraison = snapshotData['adresse_livraison'] as String?;
    _dateLivraison = snapshotData['date_livraison'] as String?;
    _statusNumber = castToType<int>(snapshotData['status_number']);
    _datetimeLivraison = snapshotData['datetime_Livraison'] as DateTime?;
    _isInstant = snapshotData['isInstant'] as bool?;
    _stripeSessionId = snapshotData['stripe_session_id'] as String?;
    _quantity = castToType<int>(snapshotData['quantity']);
    _paymentUrl = snapshotData['payment_url'] as String?;
    _asProof = snapshotData['as_proof'] as bool?;
    _proofsUrl = getDataList(snapshotData['proofs_url']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Commandes');

  static Stream<CommandesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CommandesRecord.fromSnapshot(s));

  static Future<CommandesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CommandesRecord.fromSnapshot(s));

  static CommandesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CommandesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CommandesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CommandesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CommandesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CommandesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCommandesRecordData({
  String? name,
  double? amount,
  String? status,
  double? tax,
  DateTime? createdAt,
  String? vendorName,
  DocumentReference? vendorRef,
  int? delaiMinutes,
  bool? isVoisins,
  DocumentReference? buyer,
  LatLng? latlngLivraison,
  String? adresseLivraison,
  String? dateLivraison,
  int? statusNumber,
  DateTime? datetimeLivraison,
  bool? isInstant,
  String? stripeSessionId,
  int? quantity,
  String? paymentUrl,
  bool? asProof,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'amount': amount,
      'status': status,
      'tax': tax,
      'created_at': createdAt,
      'vendor_name': vendorName,
      'vendor_ref': vendorRef,
      'delai_minutes': delaiMinutes,
      'isVoisins': isVoisins,
      'buyer': buyer,
      'latlng_livraison': latlngLivraison,
      'adresse_livraison': adresseLivraison,
      'date_livraison': dateLivraison,
      'status_number': statusNumber,
      'datetime_Livraison': datetimeLivraison,
      'isInstant': isInstant,
      'stripe_session_id': stripeSessionId,
      'quantity': quantity,
      'payment_url': paymentUrl,
      'as_proof': asProof,
    }.withoutNulls,
  );

  return firestoreData;
}

class CommandesRecordDocumentEquality implements Equality<CommandesRecord> {
  const CommandesRecordDocumentEquality();

  @override
  bool equals(CommandesRecord? e1, CommandesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.amount == e2?.amount &&
        e1?.status == e2?.status &&
        e1?.tax == e2?.tax &&
        e1?.createdAt == e2?.createdAt &&
        e1?.vendorName == e2?.vendorName &&
        e1?.vendorRef == e2?.vendorRef &&
        listEquality.equals(e1?.plats, e2?.plats) &&
        e1?.delaiMinutes == e2?.delaiMinutes &&
        e1?.isVoisins == e2?.isVoisins &&
        e1?.buyer == e2?.buyer &&
        e1?.latlngLivraison == e2?.latlngLivraison &&
        e1?.adresseLivraison == e2?.adresseLivraison &&
        e1?.dateLivraison == e2?.dateLivraison &&
        e1?.statusNumber == e2?.statusNumber &&
        e1?.datetimeLivraison == e2?.datetimeLivraison &&
        e1?.isInstant == e2?.isInstant &&
        e1?.stripeSessionId == e2?.stripeSessionId &&
        e1?.quantity == e2?.quantity &&
        e1?.paymentUrl == e2?.paymentUrl &&
        e1?.asProof == e2?.asProof &&
        listEquality.equals(e1?.proofsUrl, e2?.proofsUrl);
  }

  @override
  int hash(CommandesRecord? e) => const ListEquality().hash([
        e?.name,
        e?.amount,
        e?.status,
        e?.tax,
        e?.createdAt,
        e?.vendorName,
        e?.vendorRef,
        e?.plats,
        e?.delaiMinutes,
        e?.isVoisins,
        e?.buyer,
        e?.latlngLivraison,
        e?.adresseLivraison,
        e?.dateLivraison,
        e?.statusNumber,
        e?.datetimeLivraison,
        e?.isInstant,
        e?.stripeSessionId,
        e?.quantity,
        e?.paymentUrl,
        e?.asProof,
        e?.proofsUrl
      ]);

  @override
  bool isValidKey(Object? o) => o is CommandesRecord;
}
