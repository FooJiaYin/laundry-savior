import 'dart:convert';

enum StatusCode {
  available,
  in_use,
  overdue;

  static StatusCode parse(String name) => StatusCode.values.byName(name);
}

class MachineStatus {
  final StatusCode code;
  final Duration durationPassed;
  final Duration durationEstimated;
  const MachineStatus({
    required this.code,
    this.durationPassed = Duration.zero,
    this.durationEstimated = const Duration(minutes: 30),
  });

  int get minutesLeft => durationEstimated.inMinutes - durationPassed.inMinutes;

  MachineStatus copyWith({
    StatusCode? code,
    Duration? durationPassed,
    Duration? durationEstimated,
  }) {
    return MachineStatus(
      code: code ?? this.code,
      durationPassed: durationPassed ?? this.durationPassed,
      durationEstimated: durationEstimated ?? this.durationEstimated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code.name,
      'durationPassed': durationPassed.inSeconds,
      'durationEstimated': durationEstimated.inSeconds,
    };
  }

  factory MachineStatus.fromMap(Map<String, dynamic> map) {
    return MachineStatus(
      code: map['code'] != null ? StatusCode.parse(map['code']) : StatusCode.available,
      durationPassed: map['durationPassed'] != null ? Duration(seconds: map['durationPassed']) : Duration.zero,
      durationEstimated: map['durationEstimated'] != null ? Duration(seconds: map['durationEstimated']) : const Duration(minutes: 30),
    );
  }

  String toJson() => json.encode(toMap());

  factory MachineStatus.fromJson(String source) => MachineStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MachineStatus(code: $code, durationPassed: $durationPassed, durationEstimated: $durationEstimated)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MachineStatus && other.code == code && other.durationPassed == durationPassed && other.durationEstimated == durationEstimated;
  }

  @override
  int get hashCode => code.hashCode ^ durationPassed.hashCode ^ durationEstimated.hashCode;
}
