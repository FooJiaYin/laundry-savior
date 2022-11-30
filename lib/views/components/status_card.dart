import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/global_state.dart';
import '../../models/machine.dart';
import '../../theme/theme.dart';
import '../../utils/string.dart';
import '../widgets/progress_ring.dart';
import 'neumorphic_container.dart';
import 'select_dorm_dialog.dart';

class StatusCard extends StatelessWidget {
  // final GlobalState state;

  const StatusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Refactor Instruction Card
    var state = GlobalState.of(context);
    var currentMachine = state.currentMachine;
    return state.anonymous
        ? statusCard_anonymous(context)
        : state.currentMachine != null && state.currentMachine!.status.code == StatusCode.available
            ? statusCard_available(context)
            : state.status == Status.idle
                ? statusCard_busy(context)
                : state.status == Status.waiting
                    ? statusCard_waiting(context)
                    : state.status == Status.using
                        ? state.currentMachine?.status.code == StatusCode.in_use
                            ? statusCard_using(context)
                            : statusCard_overdue(context)
                        : const SizedBox(height: 0);
  }

  Widget statusCard_anonymous(BuildContext context) {
    return _statusCard(
      title: "Welcome to Laundry Savior",
      description: 'Tell us where do you live!',
      actionWidget: const ActionText('Select Dorm', color: ThemeColors.royalBlue),
      onTap: () => showDialog(context: context, builder: (context) => const SelectDormDialog()),
    );
  }

  Widget statusCard_available(BuildContext context) {
    var currentMachine = context.currentMachine;
    return _statusCard(
      title: "${currentMachine!.type.name.capitalizeFirst} available on ${currentMachine.locationString}!",
      description: 'Hurry up before it used by other!',
      leading: SvgPicture.asset("assets/images/stats_available.svg"),
      actionWidget: const ActionText('Use it now', color: ThemeColors.cyan),
      onTap: () => Navigator.pushNamed(context, "/current_machine"),
    );
  }

  Widget statusCard_busy(BuildContext context) {
    var waitingMachine = context.waitingMachine!;
    return _statusCard(
      title: "${waitingMachine.name.capitalizeFirst}s on ${context.floor}F are busy.",
      description: 'Remind when any ${waitingMachine.name} available on ${context.subscribedFloorsString ?? "${context.floor}F"}?',
      actionWidget: const ActionText('Notify me', color: ThemeColors.royalBlue),
      onTap: () {
        // if (state.subscribedFloors.isEmpty) state.subscribedFloors.add(state.config.floor!);
        context.update(status: Status.waiting);
      },
    );
  }

  Widget statusCard_waiting(BuildContext context) {
    var viewIndex = context.viewIndex;
    return _statusCard(
      title: "Waiting for a ${context.waitingMachine!.name}",
      description: 'We’ll send you ${context.machineAvailable.remindMethod.toLowerCase()} when any ${context.waitingMachine!.name} available on ${context.subscribedFloorsString!}!',
      actionWidget: viewIndex == 0 ? const ActionText('Check Other Floors', color: ThemeColors.royalBlue) : const ActionText('Cancel Waiting', icon: null),
      onTap: () {
        if (viewIndex == 0) {
          context.update(viewIndex: 1);
        } else {
          context.update(status: Status.idle);
        }
      },
    );
  }

  Widget statusCard_using(BuildContext context) {
    var currentMachine = context.currentMachine;
    var machineStatus = currentMachine?.status;
    var inUseProgress = ProgressRing(
      value: machineStatus!.durationPassed.inMinutes / machineStatus.durationEstimated.inMinutes,
      strokeWidth: 8,
      strokeGradient: ThemeColors.blueRingGradient,
      child: SvgPicture.asset(
        "assets/icons/emoticon_angry.svg",
        width: 72,
      ),
    );
    return _statusCard(
      title: "${currentMachine!.type == WashingMachine ? 'Washing' : 'Drying'} in progress",
      description: 'On ${currentMachine.locationString}, ${context.dormitory!.name}',
      leading: inUseProgress,
      actionWidget: ActionText(
        '${machineStatus.minutesLeft} min left',
        color: ThemeColors.royalBlue,
        icon: null,
      ),
      onTap: () => Navigator.pushNamed(context, "/current_machine"),
    );
  }

  Widget statusCard_overdue(BuildContext context) {
    var currentMachine = context.currentMachine;
    return _statusCard(
      title: "Laundry is done!",
      description: 'Please collect your laundry ASAP at ${currentMachine!.locationString}, ${context.dormitory!.name}',
      leading: SvgPicture.asset("assets/images/stats_overdue.svg"),
      actionWidget: const ActionText('Collect', color: ThemeColors.pink),
      onTap: () => Navigator.pushNamed(context, "/current_machine"),
    );
  }

  Widget _statusCard({required String title, required String description, Widget? leading, Widget? actionWidget, dynamic onTap}) {
    return NeumorphicContainer(
      height: 124.0,
      padding: const EdgeInsets.only(top: 16, left: 22, bottom: 16, right: 12),
      onTap: onTap,
      child: Row(
        children: [
          if (leading != null) leading,
          if (leading != null) const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: ThemeFont.title()),
                Text(description, style: ThemeFont.small),
                const Expanded(child: SizedBox(height: 2)),
                if (actionWidget != null) actionWidget,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActionText extends StatelessWidget {
  const ActionText(
    this.text, {
    Key? key,
    this.color = ThemeColors.textColor,
    this.icon = Icons.keyboard_arrow_right,
    this.alignment = MainAxisAlignment.end,
  }) : super(key: key);

  final String text;
  final Color color;
  final IconData? icon;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: ThemeFont.header(color: color, fontSize: 16),
        ),
        icon != null ? Icon(icon, color: color, size: 24) : const SizedBox(width: 12)
      ],
    );
  }
}
