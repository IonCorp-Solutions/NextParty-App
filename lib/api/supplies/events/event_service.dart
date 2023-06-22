import 'package:next_party_application/api/api_constants.dart';
import 'package:next_party_application/api/supplies/events/event_model.dart';
import 'package:http/http.dart' as http;

import 'package:next_party_application/api/supplies/preferences/preferences.dart';

class EventsService {
  Future updateEvent(int id, UpdateEventDto data) async {
    Preferences prefs = await Preferences().init();
    var token = prefs.token;
    var response = await http.put(Uri.parse(Paths.event(id)),
        headers: {"Authorization": "Bearer $token"}, body: data.toJson());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future inviteFriend(int id, String email) async {
    Preferences prefs = await Preferences().init();
    var token = prefs.token;
    var response = await http.post(
      Uri.parse(Paths.invite(id)),
      headers: {"Authorization": "Bearer $token"},
      body: {"email": email},
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future addItem(int id, Item data) async {
    Preferences prefs = await Preferences().init();
    var token = prefs.token;
    var client = http.Client();
    var response = await client.post(
      Uri.parse(Paths.addItem(id)),
      headers: {"Authorization": "Bearer $token"},
      body: data.toJson(),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
