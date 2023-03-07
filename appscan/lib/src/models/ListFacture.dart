// To parse this JSON data, do
//
//     final listFacture = listFactureFromJson(jsonString);

import 'dart:convert';

ListFacture listFactureFromJson(String str) => ListFacture.fromJson(json.decode(str));

String listFactureToJson(ListFacture data) => json.encode(data.toJson());

class ListFacture {
    ListFacture({
        this.msg,
        this.data,
    });

    final String? msg;
    final List<Datum>? data;

    ListFacture copyWith({
        String? msg,
        List<Datum>? data,
    }) => 
        ListFacture(
            msg: msg ?? this.msg,
            data: data ?? this.data,
        );

    factory ListFacture.fromJson(Map<String, dynamic> json) => ListFacture(
        msg: json["msg"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.dateSortie,
        this.typesortie,
        this.check,
        this.createdAt,
        this.updatedAt,
        this.clientId,
        this.depotId,
        this.client,
    });

    final int? id;
    final DateTime? dateSortie;
    final String? typesortie;
    final bool? check;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? clientId;
    final int? depotId;
    final Client? client;

    Datum copyWith({
        int? id,
        DateTime? dateSortie,
        String? typesortie,
        bool? check,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? clientId,
        int? depotId,
        Client? client,
    }) => 
        Datum(
            id: id ?? this.id,
            dateSortie: dateSortie ?? this.dateSortie,
            typesortie: typesortie ?? this.typesortie,
            check: check ?? this.check,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            clientId: clientId ?? this.clientId,
            depotId: depotId ?? this.depotId,
            client: client ?? this.client,
        );

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        dateSortie: json["dateSortie"] == null ? null : DateTime.parse(json["dateSortie"]),
        typesortie: json["typesortie"],
        check: json["check"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        clientId: json["clientId"],
        depotId: json["depotId"],
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dateSortie": "${dateSortie!.year.toString().padLeft(4, '0')}-${dateSortie!.month.toString().padLeft(2, '0')}-${dateSortie!.day.toString().padLeft(2, '0')}",
        "typesortie": typesortie,
        "check": check,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "clientId": clientId,
        "depotId": depotId,
        "client": client?.toJson(),
    };
}

class Client {
    Client({
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

    Client copyWith({
        int? id,
        String? nomComplet,
        String? contact,
        String? adresse,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Client(
            id: id ?? this.id,
            nomComplet: nomComplet ?? this.nomComplet,
            contact: contact ?? this.contact,
            adresse: adresse ?? this.adresse,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Client.fromJson(Map<String, dynamic> json) => Client(
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
