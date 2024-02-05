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

Future<List<DocumentReference>> arrayTwoUser(
  DocumentReference? user1,
  DocumentReference? user2,
) async {
  // Return a list of two users with two user in entry
  List<DocumentReference> userList = [];
  if (user1 != null) {
    userList.add(user1);
  }
  if (user2 != null) {
    userList.add(user2);
  }
  return userList;
}
