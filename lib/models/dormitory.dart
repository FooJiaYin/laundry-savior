// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'machine.dart';

class Dormitory {
  final String name;
  final String id;
  final String university;
  final List<int> floors;
  final List<WashingMachine> washingMachines;
  final List<DryerMachine> dryerMachines;
  Dormitory({
    required this.name,
    required this.id,
    required this.university,
    required this.floors,
    required this.washingMachines,
    required this.dryerMachines,
  });

  Dormitory copyWith({
    String? name,
    String? id,
    String? university,
    List<int>? floors,
    List<WashingMachine>? washingMachines,
    List<DryerMachine>? dryerMachines,
  }) {
    return Dormitory(
      name: name ?? this.name,
      id: id ?? this.id,
      university: university ?? this.university,
      floors: floors ?? this.floors,
      washingMachines: washingMachines ?? this.washingMachines,
      dryerMachines: dryerMachines ?? this.dryerMachines,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'university': university,
      'floors': floors,
      'washingMachines': washingMachines.map((x) => x.toMap()).toList(),
      'dryerMachines': dryerMachines.map((x) => x.toMap()).toList(),
    };
  }

  factory Dormitory.fromMap(Map<String, dynamic> map) {
    return Dormitory(
      name: map['name'] as String,
      id: map['id'] as String,
      university: map['university'] as String,
      floors: List<int>.from((map['floors'] as List<int>)),
      washingMachines: List<WashingMachine>.from((map['washingMachines'] as List<int>).map<WashingMachine>((x) => Machine.fromMap(x as Map<String,dynamic>),),),
      dryerMachines: List<DryerMachine>.from((map['dryerMachines'] as List<int>).map<DryerMachine>((x) => Machine.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Dormitory.fromJson(String source) => Dormitory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Dormitory(name: $name, id: $id, university: $university, floors: $floors, washingMachines: $washingMachines, dryerMachines: $dryerMachines)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Dormitory &&
      other.name == name &&
      other.id == id &&
      other.university == university &&
      listEquals(other.floors, floors) &&
      listEquals(other.washingMachines, washingMachines) &&
      listEquals(other.dryerMachines, dryerMachines);
  }

  @override
  int get hashCode {
    return name.hashCode ^
      id.hashCode ^
      university.hashCode ^
      floors.hashCode ^
      washingMachines.hashCode ^
      dryerMachines.hashCode;
  }
}
