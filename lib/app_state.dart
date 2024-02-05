import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _nombreNotif = prefs.getInt('ff_nombreNotif') ?? _nombreNotif;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _Nomdepage = '';
  String get Nomdepage => _Nomdepage;
  set Nomdepage(String _value) {
    _Nomdepage = _value;
  }

  int _nombreNotif = 0;
  int get nombreNotif => _nombreNotif;
  set nombreNotif(int _value) {
    _nombreNotif = _value;
    prefs.setInt('ff_nombreNotif', _value);
  }

  int _nombreCommande = 0;
  int get nombreCommande => _nombreCommande;
  set nombreCommande(int _value) {
    _nombreCommande = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
