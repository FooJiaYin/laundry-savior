import 'package:flutter/material.dart';

import '../../models/global_state.dart';
import '../../theme/theme.dart';


class WaitingSwitch extends StatelessWidget {
  const WaitingSwitch({
    Key? key,
    required this.machineType,
  }) : super(key: key);

  final Type machineType;

  @override
  Widget build(BuildContext context) {
    var state = GlobalState.of(context);
    // if (true) {
    if (state.currentMachine == null) {
      return SizedBox(
        height: 60,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Switch(
            thumbColor: MaterialStateProperty.all<Color>(ThemeColors.backgroundColor),
            activeTrackColor: ThemeColors.primaryColor,
            inactiveTrackColor: ThemeColors.grey,
            activeThumbImage: const AssetImage("assets/images/switch_active_thumb.png"),
            inactiveThumbImage: const AssetImage("assets/images/switch_inactive_thumb.png"),
            value: state.waitingMachine == machineType && (state.status == Status.waitingFloor || state.status == Status.waitingAll),
            onChanged: (value) {
              if (state.waitingMachine != machineType || (state.status != Status.waitingFloor && state.status != Status.waitingAll)) {
                state.update(status: Status.waitingFloor, waitingMachine: machineType);
              } else if (state.status != Status.waitingFloor || state.status != Status.waitingAll) {
                state.update(status: Status.idle);
              }
            },
          ),
        ),
      );
    } else return SizedBox(height: 60);
  }
}
