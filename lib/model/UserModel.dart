import 'dart:convert';

class UserModel {
  String? iduser;
  String nama;
  String profesi;
  String email;
  String password;
  String? roleId;
  String? isActive;
  DateTime? tanggalInput;
  DateTime? modified;

  UserModel({
    this.iduser,
    required this.nama,
    required this.profesi,
    required this.email,
    required this.password,
    this.roleId,
    this.isActive,
    this.tanggalInput,
    this.modified,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        iduser: json["iduser"],
        nama: json["nama"],
        profesi: json["profesi"],
        email: json["email"],
        password: json["password"],
        roleId: json["role_id"],
        isActive: json["is_active"],
        tanggalInput: DateTime.parse(json["tanggal_input"]),
        modified: DateTime.parse(json["modified"]),
      );

  Map<String, dynamic> toJson() => {
        "iduser": iduser ?? "",
        "nama": nama,
        "profesi": profesi,
        "email": email,
        "password": password
      };
}
