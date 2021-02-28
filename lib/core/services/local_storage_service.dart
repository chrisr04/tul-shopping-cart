import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {

  LocalStorageService._privateConstructor();
  static final _instance = LocalStorageService._privateConstructor();

  factory LocalStorageService() => _instance;

  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(key)){
      return json.decode(prefs.getString(key));
    }
    return null;
  }

  Future<void> save(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

}