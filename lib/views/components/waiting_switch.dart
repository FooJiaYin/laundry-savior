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
    if (state.currentMachine == null || state.status == Status.waiting) {
      return SizedBox(
        height: 48,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Switch(
            thumbColor: MaterialStateProperty.all<Color>(ThemeColors.backgroundColor),
            activeTrackColor: ThemeColors.primaryColor,
            inactiveTrackColor: ThemeColors.grey,
            activeThumbImage: const AssetImage("assets/images/switch_active_thumb.png"),
            inactiveThumbImage: const AssetImage("assets/images/switch_inactive_thumb.png"),
            value: state.waitingMachine == machineType && (state.status == Status.waiting),
            onChanged: (value) {
              if (state.waitingMachine != machineType || state.status != Status.waiting) {
                // if (state.config.subscribedFloors.isEmpty) state.config.subscribedFloors.add(state.config.floor!);
                state.update(status: Status.waiting, waitingMachine: machineType);
              } else {
                state.update(status: Status.idle);
              }
            },
          ),
        ),
      );
    } else return const SizedBox(height: 48);
  }
}
