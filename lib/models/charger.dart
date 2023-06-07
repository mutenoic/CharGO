// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

class Charger {
  String name;
  String description;
  LatLng location;
  double price;
  String type;

  Charger({
    required this.name,
    required this.description,
    required this.location,
    required this.price,
    required this.type,
  });

  Charger copyWith({
    String? name,
    String? description,
    LatLng? location,
    double? price,
    String? type,
  }) {
    return Charger(
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      price: price ?? this.price,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'location': location,
      'price': price,
      'type': type,
    };
  }

  factory Charger.fromMap(Map<String, dynamic> map) {
    final lat = (map['location'] as GeoPoint).latitude;
    final lng = (map['location'] as GeoPoint).longitude;

    return Charger(
      name: map['name'] as String,
      description: map['description'] as String,
      location: LatLng(lat, lng),
      price: map['price'] as double,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Charger.fromJson(String source) => Charger.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Charger(name: $name, description: $description, location: $location, price: $price, type: $type)';
  }

  @override
  bool operator ==(covariant Charger other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.location == location &&
        other.price == price &&
        other.type == type;
  }

  @override
  int get hashCode {
    return name.hashCode ^ description.hashCode ^ location.hashCode ^ price.hashCode ^ type.hashCode;
  }
}
