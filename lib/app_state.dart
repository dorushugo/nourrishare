import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  set Nomdepage(String value) {
    _Nomdepage = value;
  }

  int _nombreNotif = 0;
  int get nombreNotif => _nombreNotif;
  set nombreNotif(int value) {
    _nombreNotif = value;
    prefs.setInt('ff_nombreNotif', value);
  }

  int _nombreCommande = 0;
  int get nombreCommande => _nombreCommande;
  set nombreCommande(int value) {
    _nombreCommande = value;
  }
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
