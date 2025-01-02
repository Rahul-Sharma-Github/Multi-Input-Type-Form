// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String? name;
  String? number;
  String? date;
  String? email;
  String? gender;

  Welcome({
    this.name,
    this.number,
    this.date,
    this.email,
    this.gender,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        name: json["name"],
        number: json["number"],
        date: json["Date"],
        email: json["Email"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
        "Date": date,
        "Email": email,
        "gender": gender,
      };
}
