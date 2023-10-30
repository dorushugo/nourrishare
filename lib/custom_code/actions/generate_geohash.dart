// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

String generateGeohash(double latitude, double longitude) {
  final BASE32 = "0123456789bcdefghjkmnpqrstuvwxyz";
  String hash = '';
  int chars = 0;
  int bits = 0;
  bool even = true;
  List<double> lat = [-90, 90];
  List<double> lon = [-180, 180];

  while (chars < 5) {
    if (even) {
      final mid = (lon[0] + lon[1]) / 2;
      if (longitude > mid) {
        bits = (bits << 1) | 1;
        lon[0] = mid;
      } else {
        bits = (bits << 1) | 0;
        lon[1] = mid;
      }
    } else {
      final mid = (lat[0] + lat[1]) / 2;
      if (latitude > mid) {
        bits = (bits << 1) | 1;
        lat[0] = mid;
      } else {
        bits = (bits << 1) | 0;
        lat[1] = mid;
      }
    }
    even = !even;

    if (bits >= 0x10) {
      hash += BASE32[bits];
      chars++;
      bits = 0;
    }
  }
  return hash;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!
