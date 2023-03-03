import 'dart:convert';

ModelAuthentific modelAuthentificFromJson(String str) => ModelAuthentific.fromJson(json.decode(str));

String modelAuthentificToJson(ModelAuthentific data) => json.encode(data.toJson());

class ModelAuthentific {
    ModelAuthentific({
        required this.msg,
        required this.data,
        required this.token,
    });

    String msg;
    Data data;
    String token;

    factory ModelAuthentific.fromJson(Map<String, dynamic> json) => ModelAuthentific(
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data.toJson(),
        "token": token,
    };
}

class Data {
    Data({
        required this.id,
        required this.username,
        required this.password,
        required this.statut,
        required this.createdAt,
        required this.updatedAt,
        this.magasinId,
        required this.identificationId,
        this.depotId,
        required this.identification,
    });

    int id;
    String username;
    String password;
    bool statut;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic magasinId;
    int identificationId;
    dynamic depotId;
    Identification identification;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        statut: json["statut"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        magasinId: json["magasinId"],
        identificationId: json["identificationId"],
        depotId: json["depotId"],
        identification: Identification.fromJson(json["identification"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "statut": statut,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "magasinId": magasinId,
        "identificationId": identificationId,
        "depotId": depotId,
        "identification": identification.toJson(),
    };
}

class Identification {
    Identification({
        required this.id,
        required this.nomComplet,
        required this.contact,
        required this.adresse,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String nomComplet;
    String contact;
    String adresse;
    DateTime createdAt;
    DateTime updatedAt;

    factory Identification.fromJson(Map<String, dynamic> json) => Identification(
        id: json["id"],
        nomComplet: json["nomComplet"],
        contact: json["contact"],
        adresse: json["adresse"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nomComplet": nomComplet,
        "contact": contact,
        "adresse": adresse,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
