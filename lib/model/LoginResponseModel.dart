import 'dart:convert';

import 'package:vigenesia/model/UserModel.dart';

class LoginResponseModel {
  bool isActive;
  String message;
  UserModel data;

  LoginResponseModel({
    required this.isActive,
    required this.message,
    required this.data,
  });

  factory LoginResponseModel.fromRawJson(String str) => LoginResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    isActive: json["is_active"],
    message: json["message"],
    data: UserModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "is_active": isActive,
    "message": message,
    "data": data.toJson(),
  };
}