// To parse this JSON data, do
//
//     final authentification = authentificationFromJson(jsonString);

import 'dart:convert';

Authentification authentificationFromJson(String str) => Authentification.fromJson(json.decode(str));

String authentificationToJson(Authentification data) => json.encode(data.toJson());

class Authentification {
    Authentification({
        this.msg,
        this.data,
        this.token,
    });

    final String? msg;
    final Data? data;
    final String? token;

    Authentification copyWith({
        String? msg,
        Data? data,
        String? token,
    }) => 
        Authentification(
            msg: msg ?? this.msg,
            data: data ?? this.data,
            token: token ?? this.token,
        );

    factory Authentification.fromJson(Map<String, dynamic> json) => Authentification(
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data?.toJson(),
        "token": token,
    };
}

class Data {
    Data({
        this.id,
        this.username,
        this.password,
        this.statut,
        this.createdAt,
        this.updatedAt,
        this.magasinId,
        this.identificationId,
        this.depotId,
        this.identification,
    });

    final int? id;
    final String? username;
    final String? password;
    final bool? statut;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic magasinId;
    final int? identificationId;
    final int? depotId;
    final Identification? identification;

    Data copyWith({
        int? id,
        String? username,
        String? password,
        bool? statut,
        DateTime? createdAt,
        DateTime? updatedAt,
        dynamic magasinId,
        int? identificationId,
        int? depotId,
        Identification? identification,
    }) => 
        Data(
            id: id ?? this.id,
            username: username ?? this.username,
            password: password ?? this.password,
            statut: statut ?? this.statut,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            magasinId: magasinId ?? this.magasinId,
            identificationId: identificationId ?? this.identificationId,
            depotId: depotId ?? this.depotId,
            identification: identification ?? this.identification,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        statut: json["statut"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        magasinId: json["magasinId"],
        identificationId: json["identificationId"],
        depotId: json["depotId"],
        identification: json["identification"] == null ? null : Identification.fromJson(json["identification"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "statut": statut,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "magasinId": magasinId,
        "identificationId": identificationId,
        "depotId": depotId,
        "identification": identification?.toJson(),
    };
}

class Identification {
    Identification({
        this.id,
        this.nomComplet,
        this.contact,
        this.adresse,
        this.createdAt,
        this.updatedAt,
    });

    final int? id;
    final String? nomComplet;
    final String? contact;
    final String? adresse;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Identification copyWith({
        int? id,
        String? nomComplet,
        String? contact,
        String? adresse,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Identification(
            id: id ?? this.id,
            nomComplet: nomComplet ?? this.nomComplet,
            contact: contact ?? this.contact,
            adresse: adresse ?? this.adresse,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Identification.fromJson(Map<String, dynamic> json) => Identification(
        id: json["id"],
        nomComplet: json["nomComplet"],
        contact: json["contact"],
        adresse: json["adresse"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nomComplet": nomComplet,
        "contact": contact,
        "adresse": adresse,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
