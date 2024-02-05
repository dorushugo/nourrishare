// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<DocumentReference>> convertStringtoRef(
    List<String> groupeRefString) async {
  //   convert a list of groupe references in string format to real groupe references.
  List<DocumentReference> groupeRefs = [];

  for (String refString in groupeRefString) {
    DocumentReference ref = FirebaseFirestore.instance.doc(refString);
    groupeRefs.add(ref);
  }

  return groupeRefs;
}
