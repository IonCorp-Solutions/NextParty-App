import 'dart:typed_data';
import 'package:intl/intl.dart';

class User {
  int id;
  String firstname;
  String lastname;
  String email;
  String? phone;
  DateTime? birthday;
  Uint8List? profileImage;
  User(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.email,
      this.phone,
      this.birthday,
      this.profileImage});

  factory User.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateTime? birthday =
        json['birthday'] != null ? formatter.parse(json['birthday']) : null;

    final Uint8List? profileImage = json['profile_image'] != null
        ? Uint8List.fromList(json['profile_image']['data'].cast<int>())
        : null;
    return User(
        id: json['id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        email: json['email'],
        phone: json['phone'],
        birthday: birthday,
        profileImage: profileImage);
  }
  String get fullName => '$firstname $lastname';

  String get birthdayString => birthday != null
      ? DateFormat('yyyy-MM-dd').format(birthday!).toString()
      : '';

  Map<String, dynamic> userToJson(User data) {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = data.id;
    json['firstname'] = data.firstname;
    json['lastname'] = data.lastname;
    json['email'] = data.email;
    json['phone'] = data.phone;
    json['birthday'] = data.birthday != null
        ? DateFormat('yyyy-MM-dd').format(data.birthday!)
        : null;
    return json;
  }
}

class RegisterDto {
  String firstName;
  String lastName;
  String email;
  String password;
  String? phone;
  DateTime? birthday;

  RegisterDto(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      this.phone,
      this.birthday});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json["firstname"] = firstName;
    json["lastname"] = lastName;
    json["email"] = email;
    json["password"] = password;
    if (phone != null) {
      json["phone"] = phone;
    }
    if (birthday != null) {
      json["birthday"] = DateFormat('yyyy-MM-dd').format(birthday!);
    }

    return json;
  }
}

class LoginDto {
  String email;
  String password;

  LoginDto({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

class ForgotPasswordDto {
  String email;
  ForgotPasswordDto({required this.email});

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}

class UpdateProfileDto {
  String firstName;
  String lastName;
  String email;
  String? phone;
  DateTime? birthday;

  UpdateProfileDto(
      {required this.firstName,
      required this.lastName,
      required this.email,
      this.phone,
      this.birthday});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json["firstname"] = firstName;
    json["lastname"] = lastName;
    json["email"] = email;
    if (phone != null) {
      json["phone"] = phone;
    }
    if (birthday != null) {
      json["birthday"] = DateFormat('yyyy-MM-dd').format(birthday!);
    }

    return json;
  }
}
