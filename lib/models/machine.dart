// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'machine_status.dart';

class Machine {
  int id;
  int floor;
  String? section;
  Type type;
  MachineStatus status;
  Machine({
    required this.id,
    required this.floor,
    this.section,
    required this.type,
    required this.status,
  });

  Machine copyWith({
    int? id,
    int? floor,
    String? section,
    Type? type,
    MachineStatus? status,
  }) {
    return Machine(
      id: id ?? this.id,
      floor: floor ?? this.floor,
      section: section ?? this.section,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'floor': floor,
      'section': section,
      'type': type.toString(),
      'status': status.toMap(),
    };
  }

  static fromMap(Map<String, dynamic> map) {
    var type = map['type'] == "WashingMachine" ? WashingMachine : DryerMachine;

    return type == WashingMachine? WashingMachine(
      id: map['id'] as int,
      floor: map['floor'] as int,
      section: map['section'] != null ? map['section'] as String : null,
      status: MachineStatus.fromMap(map['status'] as Map<String,dynamic>),
    ) : DryerMachine(
      id: map['id'] as int,
      floor: map['floor'] as int,
      section: map['section'] != null ? map['section'] as String : null,
      status: MachineStatus.fromMap(map['status'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Machine.fromJson(String source) => Machine.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Machine(id: $id, floor: $floor, section: $section, type: $type, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Machine &&
      other.id == id &&
      other.floor == floor &&
      other.section == section &&
      other.type == type &&
      other.status == status;
  }

  @override
  int get hashCode {
    return floor.hashCode ^
      id.hashCode ^
      section.hashCode ^
      type.hashCode ^
      status.hashCode;
  }
} 

class WashingMachine extends Machine {
  WashingMachine({
    required int id, 
    required int floor, 
    String? section, 
    required MachineStatus status,
  }) : super (
    id: id, 
    floor: floor, 
    status: status, 
    type: WashingMachine, 
    section: section,
  );  
}

class DryerMachine extends Machine {
  DryerMachine({
    required int id, 
    required int floor, 
    String? section, 
    required MachineStatus status,
  }) : super (
    id: id, 
    floor: floor, 
    status: status, 
    type: DryerMachine, 
    section: section,
  );
}
