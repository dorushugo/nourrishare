import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

String? calculateDistance(
  double? lat1,
  double? lon1,
  double? lat2,
  double? lon2,
) {
// Get the distance between two points
  const R = 6371.0; // Radius of the Earth in kilometers

  if (lat1 == null || lon1 == null || lat2 == null || lon2 == null) {
    return null;
  }

  final lat1Rad = lat1 * (math.pi / 180);
  final lon1Rad = lon1 * (math.pi / 180);
  final lat2Rad = lat2 * (math.pi / 180);
  final lon2Rad = lon2 * (math.pi / 180);

  final dlat = lat2Rad - lat1Rad;
  final dlon = lon2Rad - lon1Rad;

  final a = math.pow(math.sin(dlat / 2), 2) +
      math.cos(lat1Rad) * math.cos(lat2Rad) * math.pow(math.sin(dlon / 2), 2);
  final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

  double distance = R * c; // Distance in kilometers
  // Round to the nearest tenth, ensuring it's at least 0.1
  distance = math.max(0.1, ((distance * 10).ceil() / 10));

  return '${distance.toStringAsFixed(1)} km';
}

DateTime returnDate13YearsAgo() {
  // Return date to 12 years and 364 days from today
  final now = DateTime.now();
  final thirteenYearsAgo = DateTime(now.year - 13, now.month, now.day)
      .subtract(const Duration(days: 1));
  return thirteenYearsAgo;
}

bool calculateTime30(DateTime dateCreation) {
  // Return false if time between dateCreation and now is more than 5 minutes
  final now = DateTime.now();
  final difference = now.difference(dateCreation);
  return difference.inMinutes <= 30;
}

bool calculateTime(DateTime dateCreation) {
  // Return false if time between dateCreation and now is more than 5 minutes
  final now = DateTime.now();
  final difference = now.difference(dateCreation);
  return difference.inMinutes <= 5;
}

List<int> returnDobFields(DateTime dateOfBirth) {
  // Return the day, month and year of birth from date of birht.
  return [dateOfBirth.day, dateOfBirth.month, dateOfBirth.year];
}

dynamic decodeJson(String? apiReturn) {
  // Decode JSON in apiReturn
  if (apiReturn == null) {
    return null;
  }
  return json.decode(apiReturn);
}

String replaceString(String inputJson) {
  // Supprime les guillemets, les retours à la ligne et les caractères d'échappement
  String formattedString = inputJson.replaceAll('\n', ' ');
  formattedString = formattedString.replaceAll('\"', '');
  formattedString = formattedString.replaceAll(' n ', '');
  formattedString = formattedString.replaceAll('\\', '');
  formattedString = formattedString.replaceAll('{', '');
  formattedString = formattedString.replaceAll('}', '');

  return formattedString;
}

LatLng returnLatLng(
  double lat,
  double lng,
) {
  // Output latlng with lat and lng in input
  return LatLng(lat, lng);
}
