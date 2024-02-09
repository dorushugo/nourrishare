// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class PlatsAutoFillStruct extends FFFirebaseStruct {
  PlatsAutoFillStruct({
    String? ingredients,
    String? allergenes,
    String? nom,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _ingredients = ingredients,
        _allergenes = allergenes,
        _nom = nom,
        super(firestoreUtilData);

  // "Ingredients" field.
  String? _ingredients;
  String get ingredients => _ingredients ?? '';
  set ingredients(String? val) => _ingredients = val;
  bool hasIngredients() => _ingredients != null;

  // "Allergenes" field.
  String? _allergenes;
  String get allergenes => _allergenes ?? '';
  set allergenes(String? val) => _allergenes = val;
  bool hasAllergenes() => _allergenes != null;

  // "Nom" field.
  String? _nom;
  String get nom => _nom ?? '';
  set nom(String? val) => _nom = val;
  bool hasNom() => _nom != null;

  static PlatsAutoFillStruct fromMap(Map<String, dynamic> data) =>
      PlatsAutoFillStruct(
        ingredients: data['Ingredients'] as String?,
        allergenes: data['Allergenes'] as String?,
        nom: data['Nom'] as String?,
      );

  static PlatsAutoFillStruct? maybeFromMap(dynamic data) => data is Map
      ? PlatsAutoFillStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Ingredients': _ingredients,
        'Allergenes': _allergenes,
        'Nom': _nom,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Ingredients': serializeParam(
          _ingredients,
          ParamType.String,
        ),
        'Allergenes': serializeParam(
          _allergenes,
          ParamType.String,
        ),
        'Nom': serializeParam(
          _nom,
          ParamType.String,
        ),
      }.withoutNulls;

  static PlatsAutoFillStruct fromSerializableMap(Map<String, dynamic> data) =>
      PlatsAutoFillStruct(
        ingredients: deserializeParam(
          data['Ingredients'],
          ParamType.String,
          false,
        ),
        allergenes: deserializeParam(
          data['Allergenes'],
          ParamType.String,
          false,
        ),
        nom: deserializeParam(
          data['Nom'],
          ParamType.String,
          false,
        ),
      );

  static PlatsAutoFillStruct fromAlgoliaData(Map<String, dynamic> data) =>
      PlatsAutoFillStruct(
        ingredients: convertAlgoliaParam(
          data['Ingredients'],
          ParamType.String,
          false,
        ),
        allergenes: convertAlgoliaParam(
          data['Allergenes'],
          ParamType.String,
          false,
        ),
        nom: convertAlgoliaParam(
          data['Nom'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'PlatsAutoFillStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PlatsAutoFillStruct &&
        ingredients == other.ingredients &&
        allergenes == other.allergenes &&
        nom == other.nom;
  }

  @override
  int get hashCode => const ListEquality().hash([ingredients, allergenes, nom]);
}

PlatsAutoFillStruct createPlatsAutoFillStruct({
  String? ingredients,
  String? allergenes,
  String? nom,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PlatsAutoFillStruct(
      ingredients: ingredients,
      allergenes: allergenes,
      nom: nom,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PlatsAutoFillStruct? updatePlatsAutoFillStruct(
  PlatsAutoFillStruct? platsAutoFill, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    platsAutoFill
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPlatsAutoFillStructData(
  Map<String, dynamic> firestoreData,
  PlatsAutoFillStruct? platsAutoFill,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (platsAutoFill == null) {
    return;
  }
  if (platsAutoFill.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && platsAutoFill.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final platsAutoFillData =
      getPlatsAutoFillFirestoreData(platsAutoFill, forFieldValue);
  final nestedData =
      platsAutoFillData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = platsAutoFill.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPlatsAutoFillFirestoreData(
  PlatsAutoFillStruct? platsAutoFill, [
  bool forFieldValue = false,
]) {
  if (platsAutoFill == null) {
    return {};
  }
  final firestoreData = mapToFirestore(platsAutoFill.toMap());

  // Add any Firestore field values
  platsAutoFill.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPlatsAutoFillListFirestoreData(
  List<PlatsAutoFillStruct>? platsAutoFills,
) =>
    platsAutoFills
        ?.map((e) => getPlatsAutoFillFirestoreData(e, true))
        .toList() ??
    [];
