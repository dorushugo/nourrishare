// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LatLngStruct extends FFFirebaseStruct {
  LatLngStruct({
    LatLng? latLng,
    double? lat,
    double? long,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _latLng = latLng,
        _lat = lat,
        _long = long,
        super(firestoreUtilData);

  // "latLng" field.
  LatLng? _latLng;
  LatLng? get latLng => _latLng;
  set latLng(LatLng? val) => _latLng = val;
  bool hasLatLng() => _latLng != null;

  // "lat" field.
  double? _lat;
  double get lat => _lat ?? 0.0;
  set lat(double? val) => _lat = val;
  void incrementLat(double amount) => _lat = lat + amount;
  bool hasLat() => _lat != null;

  // "long" field.
  double? _long;
  double get long => _long ?? 0.0;
  set long(double? val) => _long = val;
  void incrementLong(double amount) => _long = long + amount;
  bool hasLong() => _long != null;

  static LatLngStruct fromMap(Map<String, dynamic> data) => LatLngStruct(
        latLng: data['latLng'] as LatLng?,
        lat: castToType<double>(data['lat']),
        long: castToType<double>(data['long']),
      );

  static LatLngStruct? maybeFromMap(dynamic data) =>
      data is Map ? LatLngStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'latLng': _latLng,
        'lat': _lat,
        'long': _long,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'latLng': serializeParam(
          _latLng,
          ParamType.LatLng,
        ),
        'lat': serializeParam(
          _lat,
          ParamType.double,
        ),
        'long': serializeParam(
          _long,
          ParamType.double,
        ),
      }.withoutNulls;

  static LatLngStruct fromSerializableMap(Map<String, dynamic> data) =>
      LatLngStruct(
        latLng: deserializeParam(
          data['latLng'],
          ParamType.LatLng,
          false,
        ),
        lat: deserializeParam(
          data['lat'],
          ParamType.double,
          false,
        ),
        long: deserializeParam(
          data['long'],
          ParamType.double,
          false,
        ),
      );

  static LatLngStruct fromAlgoliaData(Map<String, dynamic> data) =>
      LatLngStruct(
        latLng: convertAlgoliaParam(
          data,
          ParamType.LatLng,
          false,
        ),
        lat: convertAlgoliaParam(
          data['lat'],
          ParamType.double,
          false,
        ),
        long: convertAlgoliaParam(
          data['long'],
          ParamType.double,
          false,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'LatLngStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LatLngStruct &&
        latLng == other.latLng &&
        lat == other.lat &&
        long == other.long;
  }

  @override
  int get hashCode => const ListEquality().hash([latLng, lat, long]);
}

LatLngStruct createLatLngStruct({
  LatLng? latLng,
  double? lat,
  double? long,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LatLngStruct(
      latLng: latLng,
      lat: lat,
      long: long,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LatLngStruct? updateLatLngStruct(
  LatLngStruct? latLngStruct, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    latLngStruct
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLatLngStructData(
  Map<String, dynamic> firestoreData,
  LatLngStruct? latLngStruct,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (latLngStruct == null) {
    return;
  }
  if (latLngStruct.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && latLngStruct.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final latLngStructData = getLatLngFirestoreData(latLngStruct, forFieldValue);
  final nestedData =
      latLngStructData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = latLngStruct.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLatLngFirestoreData(
  LatLngStruct? latLngStruct, [
  bool forFieldValue = false,
]) {
  if (latLngStruct == null) {
    return {};
  }
  final firestoreData = mapToFirestore(latLngStruct.toMap());

  // Add any Firestore field values
  latLngStruct.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLatLngListFirestoreData(
  List<LatLngStruct>? latLngStructs,
) =>
    latLngStructs?.map((e) => getLatLngFirestoreData(e, true)).toList() ?? [];
