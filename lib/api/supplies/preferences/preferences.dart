import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:next_party_application/api/supplies/auth/user_model.dart';

class Preferences {
  SharedPreferences? _preferences;
  User _user = User(
      id: 0,
      firstname: '',
      lastname: '',
      email: '',
      phone: null,
      birthday: null,
      profileImage: null);
  String _token = '';

  Future<SharedPreferences?> get preferences async {
    if (_preferences != null) return _preferences;
    _preferences = await SharedPreferences.getInstance();
    _token = _preferences!.getString('token') ?? '';
    _user = User(
        id: _preferences!.getInt('id') ?? 0,
        firstname: _preferences!.getString('name') ?? '',
        lastname: _preferences!.getString('lastname') ?? '',
        email: _preferences!.getString('email') ?? '',
        phone: _preferences!.getString('phone'),
        birthday: DateTime.tryParse(_preferences!.getString('birthday') ?? ''),
        profileImage: _preferences!.getString('profileImage') != ''
            ? base64Decode(_preferences!.getString('profileImage') ?? '')
            : null);
    return _preferences;
  }

  Future<Preferences> init() async {
    _preferences = await preferences;
    return this;
  }

  User get user => _user;
  String get token => _token;

  Future<bool> setToken(String token) async {
    _token = token;
    return await _preferences!.setString('token', token);
  }

  Future<bool> setUser(User user) async {
    _user = user;
    await _preferences!.setInt('id', user.id);
    await _preferences!.setString('name', user.firstname);
    await _preferences!.setString('lastname', user.lastname);
    await _preferences!.setString('email', user.email);
    await _preferences!.setString('phone', user.phone ?? '');
    await _preferences!.setString('birthday', user.birthdayString);
    await _preferences!.setString('profileImage',
        user.profileImage != null ? base64Encode(user.profileImage!) : '');
    return true;
  }

  Future<bool> clear() async {
    _token = '';
    _user = User(
        id: 0,
        firstname: '',
        lastname: '',
        email: '',
        phone: null,
        birthday: null,
        profileImage: null);
    return await _preferences!.clear();
  }
}
