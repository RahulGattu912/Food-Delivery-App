import 'dart:convert';
import 'package:flutter/foundation.dart';

class Restaurant {
  final String name;
  final String address;
  final String subHeading;
  final String banner;
  final List items;
  final String id; // Document ID

  Restaurant({
    required this.name,
    required this.address,
    required this.subHeading,
    required this.banner,
    required this.items,
    required this.id,
  });

  Restaurant copyWith({
    String? name,
    String? address,
    String? subHeading,
    String? banner,
    List? items,
    String? id,
  }) {
    return Restaurant(
      name: name ?? this.name,
      address: address ?? this.address,
      subHeading: subHeading ?? this.subHeading,
      banner: banner ?? this.banner,
      items: items ?? this.items,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'address': address});
    result.addAll({'subHeading': subHeading});
    result.addAll({'banner': banner});
    result.addAll({'items': items});
    result.addAll({'id': id});

    return result;
  }

  // Modify the fromMap method to accept document ID
  factory Restaurant.fromMap(Map<String, dynamic> map, String documentId) {
    return Restaurant(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      subHeading: map['subHeading'] ?? '',
      banner: map['banner'] ?? '',
      items: List.from(map['items'] ?? []), // Ensure items is not null
      id: documentId, // Set document ID here
    );
  }

  // Adjust the fromJson method to accept document ID as well
  factory Restaurant.fromJson(String source, String documentId) =>
      Restaurant.fromMap(json.decode(source), documentId);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Restaurant(name: $name, address: $address, subHeading: $subHeading, banner: $banner, items: $items, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Restaurant &&
        other.name == name &&
        other.address == address &&
        other.subHeading == subHeading &&
        other.banner == banner &&
        listEquals(other.items, items) &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        address.hashCode ^
        subHeading.hashCode ^
        banner.hashCode ^
        items.hashCode ^
        id.hashCode;
  }
}
