import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
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
    secureStorage = const FlutterSecureStorage();
    await _safeInitAsync(() async {
      _nombreNotif =
          await secureStorage.getInt('ff_nombreNotif') ?? _nombreNotif;
    });
    await _safeInitAsync(() async {
      _addressSelected = await secureStorage.getString('ff_addressSelected') ??
          _addressSelected;
    });
    await _safeInitAsync(() async {
      _latLngSelected = latLngFromString(
              await secureStorage.getString('ff_latLngSelected')) ??
          _latLngSelected;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  String _Nomdepage = '';
  String get Nomdepage => _Nomdepage;
  set Nomdepage(String value) {
    _Nomdepage = value;
  }

  int _nombreNotif = 0;
  int get nombreNotif => _nombreNotif;
  set nombreNotif(int value) {
    _nombreNotif = value;
    secureStorage.setInt('ff_nombreNotif', value);
  }

  void deleteNombreNotif() {
    secureStorage.delete(key: 'ff_nombreNotif');
  }

  int _nombreCommande = 0;
  int get nombreCommande => _nombreCommande;
  set nombreCommande(int value) {
    _nombreCommande = value;
  }

  String _addressSelected = '';
  String get addressSelected => _addressSelected;
  set addressSelected(String value) {
    _addressSelected = value;
    secureStorage.setString('ff_addressSelected', value);
  }

  void deleteAddressSelected() {
    secureStorage.delete(key: 'ff_addressSelected');
  }

  LatLng? _latLngSelected;
  LatLng? get latLngSelected => _latLngSelected;
  set latLngSelected(LatLng? value) {
    _latLngSelected = value;
    value != null
        ? secureStorage.setString('ff_latLngSelected', value.serialize())
        : secureStorage.remove('ff_latLngSelected');
  }

  void deleteLatLngSelected() {
    secureStorage.delete(key: 'ff_latLngSelected');
  }

  int _justForRefresh = 1;
  int get justForRefresh => _justForRefresh;
  set justForRefresh(int value) {
    _justForRefresh = value;
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

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return const CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: const ListToCsvConverter().convert([value]));
}
