import 'dart:convert';

import 'package:asistencia_jaguar/config/routes/my_router.dart';
import 'package:asistencia_jaguar/data/models/user_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static final UserPreferences _instancia = UserPreferences._internal();
  static const String _userKey = 'user';

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  static SharedPreferences? _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }
  // Obtener la ruta por defecto
  String get defaultRoute {
    return _prefs?.getString('defaultRoute') ?? '/login';
  }
  // Establecer la ruta por defecto
  set defaultRoute(String value ) {
    _prefs?.setString('defaultRoute', value);
  }

  // Obtener el token
  String get token {
    return _prefs?.getString('token') ?? '';
  }
  // Establecer el token
  set token(String value ) {
    _prefs?.setString('token', value);
  }

  // Obtener el refresh token
  String get refreshToken {
    return _prefs?.getString('refreshToken') ?? '';
  }
  // Establecer el refresh token
  set refreshToken(String value ) {
    _prefs?.setString('refreshToken', value);
  }

  // Obtener el valor del tema
  bool get isDarkMode {
    return _prefs?.getBool('isDarkMode') ?? false;
  }
  // Establecer el valor del tema
  set isDarkMode(bool value) {
    _prefs?.setBool('isDarkMode', value);
  }

  /// Guarda un objeto UserList en SharedPreferences
  Future<void> saveUser(UserList user) async {
    final jsonString = jsonEncode(user.toJson());
    await _prefs?.setString(_userKey, jsonString);
  }

  /// Recupera un objeto UserList desde SharedPreferences
  UserList? getUser() {
    final jsonString = _prefs?.getString(_userKey);
    if (jsonString == null) return null;

    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return UserList.fromJson(json);
  }
  
  //Limpiar los valores de las preferencias
  void setDefaultValues() async{
    defaultRoute = Routes.login.getPath();
    token = '';
    refreshToken = '';
    await _prefs?.remove(_userKey);
  }
}