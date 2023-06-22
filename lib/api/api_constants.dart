class Paths {
  static const String baseUrl =
      "https://next-party-api.azurewebsites.net/api/v1";

  static const String authUrl = "$baseUrl/auth";
  static const String loginUrl = "$authUrl/login";
  static const String registerUrl = "$authUrl/register";
  static const String sendEmailUrl = "$authUrl/send-reset-password-email";
  static String validate(String token) => "$authUrl/verify/$token";

  static const String userUrl = "$baseUrl/users";
  static String ownEvents(int id) => "$userUrl/$id/events/own";
  static String invitedEvents(int id) => "$userUrl/$id/events/invited";
  static String createEvent(int id) => "$userUrl/$id/events";
  static String user(int id) => "$userUrl/$id";

  static const String eventUrl = "$baseUrl/events";
  static String event(int id) => "$eventUrl/$id";
  static String invite(int id) => "$eventUrl/$id/invite";
  static String addItem(int id) => "$eventUrl/$id/item";
}
