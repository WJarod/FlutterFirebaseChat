

import 'package:chat_firebase/app/data/models/sport.dart';

class User {
  String? id;
  String? name;
  String? firstname;
  String? profilPicture;
  List<Sport>? sportSubscriptions;
  String? address;
  String? mail;
  String? password;
  String? registeryDate;
  String? birthDate;
  String? role;
  dynamic tokenFCM;

  User(
      {this.id,
        this.name,
        this.firstname,
        this.profilPicture,
        this.sportSubscriptions,
        this.address,
        this.mail,
        this.password,
        this.registeryDate,
        this.birthDate,
        this.role,
        this.tokenFCM});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstname = json['firstname'];
    profilPicture = json['profil_picture'];
    if (json['sport_subscriptions'] != null) {
      sportSubscriptions = <Sport>[];
      json['sport_subscriptions'].forEach((v) {
        sportSubscriptions?.add(Sport.fromJson(v));
      });
    }
    address = json['address'];
    mail = json['mail'];
    password = json['password'];
    registeryDate = json['registery_date'];
    birthDate = json['birth_date'];
    role = json['role'];
    tokenFCM = json['tokenFCM'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['firstname'] = firstname;
    data['profil_picture'] = profilPicture;
    if (sportSubscriptions != null) {
      data['sport_subscriptions'] =
          sportSubscriptions?.map((v) => v.toJson()).toList();
    }
    data['address'] = address;
    data['mail'] = mail;
    data['password'] = password;
    data['registery_date'] = registeryDate;
    data['birth_date'] = birthDate;
    data['role'] = role;
    data['tokenFCM'] = tokenFCM;
    return data;
  }
}
