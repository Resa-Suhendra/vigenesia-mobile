import 'dart:convert';

class MotivationModel {
  String? id;
  String isiMotivasi;
  String iduser;
  String? tanggalInput;
  String? tanggalUpdate;

  MotivationModel({
    this.id,
    required this.isiMotivasi,
    required this.iduser,
    this.tanggalInput,
    this.tanggalUpdate,
  });

  factory MotivationModel.fromRawJson(String str) =>
      MotivationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJsonAdd());

  factory MotivationModel.fromJson(Map<String, dynamic> json) =>
      MotivationModel(
        id: json["id"],
        isiMotivasi: json["isi_motivasi"],
        iduser: json["iduser"],
        tanggalInput: json["tanggal_input"],
        tanggalUpdate: json["tanggal_update"],
      );

  Map<String, dynamic> toJsonAdd() => {
        "isi_motivasi": isiMotivasi,
        "iduser": iduser,
      };

  Map<String, dynamic> toJsonUpdate() => {
        "id": id,
        "isi_motivasi": isiMotivasi,
        "iduser": iduser,
      };
}
