// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    Welcome({
        this.msg,
        this.data,
    });

    final String? msg;
    final List<Datum>? data;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
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
        this.code,
        this.dateSortie,
        this.client,
        this.detailsorties,
    });

    final int? code;
    final String? dateSortie;
    final Client? client;
    final List<Detailsorty>? detailsorties;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        code: json["code"],
        dateSortie: json["dateSortie"],
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        detailsorties: json["detailsorties"] == null ? [] : List<Detailsorty>.from(json["detailsorties"]!.map((x) => Detailsorty.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "dateSortie": dateSortie,
        "client": client?.toJson(),
        "detailsorties": detailsorties == null ? [] : List<dynamic>.from(detailsorties!.map((x) => x.toJson())),
    };
}

class Client {
    Client({
        this.nomComplet,
        this.contact,
    });

    final String? nomComplet;
    final String? contact;

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        nomComplet: json["nomComplet"],
        contact: json["contact"],
    );

    Map<String, dynamic> toJson() => {
        "nomComplet": nomComplet,
        "contact": contact,
    };
}

class Detailsorty {
    Detailsorty({
        this.qte,
        this.pu,
        this.code,
        this.produit,
    });

    final int? qte;
    final int? pu;
    final int? code;
    final Produit? produit;

    factory Detailsorty.fromJson(Map<String, dynamic> json) => Detailsorty(
        qte: json["qte"],
        pu: json["pu"],
        code: json["code"],
        produit: json["produit"] == null ? null : Produit.fromJson(json["produit"]),
    );

    Map<String, dynamic> toJson() => {
        "qte": qte,
        "pu": pu,
        "code": code,
        "produit": produit?.toJson(),
    };
}

class Produit {
    Produit({
        this.designation,
        this.categoryproduit,
    });

    final String? designation;
    final Categoryproduit? categoryproduit;

    factory Produit.fromJson(Map<String, dynamic> json) => Produit(
        designation: json["designation"],
        categoryproduit: json["categoryproduit"] == null ? null : Categoryproduit.fromJson(json["categoryproduit"]),
    );

    Map<String, dynamic> toJson() => {
        "designation": designation,
        "categoryproduit": categoryproduit?.toJson(),
    };
}

class Categoryproduit {
    Categoryproduit({
        this.designation,
    });

    final String? designation;

    factory Categoryproduit.fromJson(Map<String, dynamic> json) => Categoryproduit(
        designation: json["designation"],
    );

    Map<String, dynamic> toJson() => {
        "designation": designation,
    };
}
