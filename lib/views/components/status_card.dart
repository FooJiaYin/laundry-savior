// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/global_state.dart';
import '../../services/fake_data.dart';
import '../../theme/theme.dart';
import '../screens/machine.dart';
import 'neumorphic_container.dart';
import 'select_dorm_dialog.dart';

class StatusCard extends StatelessWidget {
  // final GlobalState state;

  const StatusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Refactor Instruction Card
    var state = GlobalState.of(context);
    return state.anonymous
        ? statusCard_anonymous(context)
        : state.currentMachine != null && state.currentMachine!.status.code == StatusCode.available
            ? statusCard_available(state, context)
            : state.status == Status.idle
                ? statusCard_busy(state, context)
                : state.status == Status.waitingFloor
                    ? statusCard_waitingFloor(state, context)
                    : state.status == Status.waitingAll
                        ? statusCard_waitingAll(state, context)
                        : state.status == Status.using
                            ? state.currentMachine?.status.code == StatusCode.in_use
                                ? statusCard_using(state, context)
                                : statusCard_overdue(state, context)
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

  Widget statusCard_available(GlobalState state, BuildContext context) {
    return _statusCard(
      title: "${state.currentMachine!.type == WashingMachine ? 'Washing' : 'Dryer'} machine available on ${state.currentMachine!.locationString}!",
      description: 'Hurry up before it used by other!',
      leading: SvgPicture.asset("assets/images/stats_available.svg"),
      actionWidget: const ActionText('Use it now', color: ThemeColors.cyan),
      onTap: () => showDialog(context: context, builder: (context) => MachinePage(state.currentMachine!)),
    );
  }

  Widget statusCard_busy(GlobalState state, BuildContext context) {
    return _statusCard(
      title: "Washing machines on ${state.floor}F are busy.",
      description: 'Remind when any washing machine available on ${state.floor!}F?',
      actionWidget: const ActionText('Remind me', color: ThemeColors.royalBlue),
      onTap: () {
        state.update(status: Status.waitingFloor, waitingMachine: WashingMachine);
        FakeData.setReminder(context);
      },
    );
  }

  Widget statusCard_waitingFloor(GlobalState state, BuildContext context) {
    return _statusCard(
      title: "Waiting for a ${state.waitingMachine == WashingMachine ? 'washing' : 'dryer'} machine",
      description: 'We’ll send you ${state.machineAvailable.remindMethod.toLowerCase()} when any machine available on ${state.floor}F!',
      actionWidget: const ActionText('Check Other Floors', color: ThemeColors.royalBlue),
      // TODO: Check other floor
      onTap: () => state.update(status: Status.waitingAll),
    );
  }

  Widget statusCard_waitingAll(GlobalState state, BuildContext context) {
    return _statusCard(
      title: "Waiting for a ${state.waitingMachine == WashingMachine ? 'washing' : 'dryer'} machine",
      description:
          'We’ll send you ${state.machineAvailable.remindMethod.toLowerCase()} when any machine available on ${state.floor! - 1 < state.dormitory!.floors[0] ? state.floor : state.floor! - 1}~${state.floor! + 1}F',
      actionWidget: const ActionText('Cancel Waiting', icon: null),
      onTap: () => state.update(status: Status.idle),
    );
  }

  Widget statusCard_using(GlobalState state, BuildContext context) {
    return _statusCard(
      title: "${state.currentMachine!.type == WashingMachine ? 'Washing' : 'Drying'} in progress",
      description: 'On ${state.currentMachine!.locationString}, ${state.dormitory!.name}',
      // TODO: Time left calculation
      // TODO: Display progress when in use
      leading: SvgPicture.asset("assets/images/stats_in_use.svg"),
      actionWidget: ActionText(
        '${state.currentMachine?.status.durationEstimated!.inMinutes} min left',
        color: ThemeColors.royalBlue,
        icon: null,
      ),
      onTap: () => showDialog(context: context, builder: (context) => MachinePage(state.currentMachine!)),
    );
  }

  Widget statusCard_overdue(GlobalState state, BuildContext context) {
    return _statusCard(
      title: "Laundry is done!",
      description: 'Please collect your laundry ASAP at ${state.currentMachine!.locationString}, ${state.dormitory!.name}',
      leading: SvgPicture.asset("assets/images/stats_overdue.svg"),
      actionWidget: const ActionText('Collect', color: ThemeColors.pink),
      onTap: () {
        showDialog(context: context, builder: (context) => MachinePage(state.currentMachine!));
        Future.delayed(const Duration(seconds: 3), () {
          state.currentMachine!.status = MachineStatus(code: StatusCode.available);
          if (state.currentMachine!.type == WashingMachine) {
            state.currentMachine = FakeData.dryerMachine;
          } else {
            state.currentMachine = FakeData.washingMachine;
          }
          state.update(status: Status.idle);
        });
      },
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
                Text(description, style: ThemeFont.style(fontSize: 12)),
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
