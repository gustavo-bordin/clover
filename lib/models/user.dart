import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwrite/models.dart';

@immutable
class UserModel {
  final String id;
  final String name;
  final String pix;
  final String phone;
  final double trevos;
  final int leafs;

  const UserModel({
    required this.id,
    required this.name,
    required this.pix,
    required this.phone,
    required this.trevos,
    required this.leafs,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'pix': pix,
      'phone': phone,
      'trevos': trevos,
      'leafs': leafs,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['\$id'] as String,
      name: map['name'] as String,
      pix: map['pix'] as String,
      phone: map['phone'] as String,
      trevos: map["trevos"]?.toDouble(),
      leafs: map['leafs'] as int,
    );
  }

  static List<UserModel> fromDocumentList(List<Document> documentList) {
    return documentList.map((document) {
      return UserModel.fromMap(document.data);
    }).toList();
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? pix,
    String? phone,
    double? trevos,
    int? leafs,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      pix: pix ?? this.pix,
      phone: phone ?? this.phone,
      trevos: trevos ?? this.trevos,
      leafs: leafs ?? this.leafs,
    );
  }
}
