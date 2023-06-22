import 'dart:convert';
import 'package:next_party_application/api/api_constants.dart';
import 'package:next_party_application/api/supplies/auth/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:next_party_application/api/supplies/events/event_model.dart';
import 'package:next_party_application/api/supplies/preferences/preferences.dart';

class UsersService {

  Future<User?> getUser(int id) async {
    var response = await http.get(Uri.parse('${Paths.userUrl}/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future register(RegisterDto data) async {
    var response =
        await http.post(Uri.parse(Paths.registerUrl), body: data.toJson());
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future login(LoginDto data) async {
    var response =
        await http.post(Uri.parse(Paths.loginUrl), body: data.toJson());
    if (response.statusCode == 201) {
      final decode = jsonDecode(response.body);
      final token = decode['token'];
      final user = decode['user'];
      return {'token': token, 'user': User.fromJson(user)};
    } else {
      return null;
    }
  }

  Future<bool> isLogged() async {
    Preferences prefs = await Preferences().init();
    var token = prefs.token;
    if (token != '') {
      var response = await http.get(Uri.parse(Paths.validate(token)));
      if (response.statusCode == 200 &&
          jsonDecode(response.body)['validate'] == true) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<List<Event>> ownEvents() async {
    Preferences prefs = await Preferences().init();
    var id = prefs.user.id;
    var token = prefs.token;
    var response = await http.get(Uri.parse(Paths.ownEvents(id)),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => Event.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<Event>> invitedEvents() async {
    Preferences prefs = await Preferences().init();
    var id = prefs.user.id;
    var token = prefs.token;
    var response = await http.get(Uri.parse(Paths.invitedEvents(id)),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => Event.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  Future<Event?> createEvent(CreateEventDto eventDto) async {
    Preferences prefs = await Preferences().init();
    var id = prefs.user.id;
    var token = prefs.token;
    var response = await http.post(
      Uri.parse(Paths.createEvent(id)),
      headers: {"Authorization": "Bearer $token"},
      body: eventDto.toJson(),
    );
    if (response.statusCode == 201) {
      return Event.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future sendRestorePasswordEmail(ForgotPasswordDto data) async {
    var response =
        await http.post(Uri.parse(Paths.sendEmailUrl), body: data.toJson());
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future updateProfile(UpdateProfileDto data) async {
    Preferences prefs = await Preferences().init();
    var id = prefs.user.id;
    var token = prefs.token;
    var response = await http.put(
      Uri.parse(Paths.user(id)),
      headers: {"Authorization": "Bearer $token"},
      body: data.toJson(),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
