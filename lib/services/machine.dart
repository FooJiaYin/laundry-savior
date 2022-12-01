import '../models/machine.dart';

export '../models/machine.dart';

extension MachineService on Machine {
  /// Update durationPassed and check if laundry done
  void updateStatus({int minutes = 1}) {
    var newDurationPassed = status.durationPassed + Duration(minutes: minutes);
    // Check if laundry done
    if (status.code == StatusCode.in_use && newDurationPassed >= status.durationEstimated) {
      status = status.copyWith(
        code: StatusCode.overdue,
        durationPassed: newDurationPassed - status.durationEstimated,
      );
    } else {
      // Update durationPassed
      status = status.copyWith(durationPassed: status.durationPassed + Duration(minutes: minutes));
    }
  }

  void use({int? minutes}) {
     status = MachineStatus(
      code: StatusCode.in_use,
      durationEstimated: minutes != null ? Duration(minutes: minutes) : status.durationEstimated,
    );
  }

  void done() {
    status = const MachineStatus(code: StatusCode.available);
  }
}