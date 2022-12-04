import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/global_state.dart';
import '../../models/machine.dart';
import '../../services/fake_data.dart';
import '../../theme/theme.dart';
import '../../utils/string.dart';
import 'machine_status_card.dart';
import 'select_chip.dart';
import 'waiting_switch.dart';

class MachineList extends StatefulWidget {
  const MachineList({
    Key? key,
    required this.type,
  }) : super(key: key);

  final Type type;

  @override
  State<MachineList> createState() => _MachineListState();
}

class _MachineListState extends State<MachineList> {
  List<Machine> machines = [];
  bool selectFloors = false;
  GlobalState? state;

  List<int> get floors => state?.dormitory?.floors ?? [];
  Set<int> get subscribedFloors => state?.subscribedFloors ?? {};
  Type get type => widget.type;
  String get iconName => type == WashingMachine ? "drop_filled" : "wind";

  loadItems() async {
    machines = await FakeData.getMachines(state!.dormitory!, type);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    state = context.read<GlobalState>();
    if (state?.dormitory != null) loadItems();
  }

  @override
  Widget build(BuildContext context) {
    state = GlobalState.of(context);
    floorFilter(machine) => state?.viewIndex == 0 ? machine.floor == state?.floor : machine.status.code == StatusCode.available;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset("assets/icons/$iconName.svg", width: 20, height: 20),
            const SizedBox(width: 8),
            Text(type.name.capitalizeEach, style: ThemeFont.header()),
            const SizedBox(width: 8),
            state?.status != Status.using ? _waitingButton() : const SizedBox(height: 48),
          ],
        ),
        if (state?.status != Status.using) _floorChipsPanel(),
        const SizedBox(height: 8),
        ProxyProvider<GlobalState, List<Machine>>(
          update: (_, state, __) => state.floor != null ? machines.where(floorFilter).toList() : [],
          child: Builder(
            builder: (context) => GridView.count(
              clipBehavior: Clip.none,
              crossAxisCount: 3,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 0.65,
              primary: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: context.watch<List<Machine>>().map((machine) => MachineStatusCard(machine)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _waitingButton() => Expanded(
        child: InkWell(
          onTap: () => setState(() {
            selectFloors = !selectFloors;
          }),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  state?.status != Status.waiting ? "Select Floors" : state!.subscribedFloorsString!,
                  style: ThemeFont.small,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 12,
                child: Icon(selectFloors ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, size: 16),
              ),
              WaitingSwitch(machineType: type),
            ],
          ),
        ),
      );

  Widget _floorChipsPanel() => InkWell(
        onTap: () => setState(() {
          selectFloors = false;
        }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: selectFloors ? null : 0,
          child: Wrap(
            clipBehavior: Clip.hardEdge,
            spacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              /// Select All or Clear
              state!.subscribedFloors.length >= floors.length ? _clearAllButton : _selectAllButton,

              /// Floor chips
              ...floors.map(floorChip).toList(),
              // Icon(Icons.keyboard_arrow_up_rounded)
              // Text("Close", style: ThemeFont.small)
            ],
          ),
        ),
      );

  Widget get _selectAllButton => SelectChip(
        label: " All",
        icon: "bell_outlined",
        onSelected: (_) => setState(() {
          GlobalState.set(context, subscribedFloors: floors.toSet(), status: Status.waiting);
        }),
      );

  Widget get _clearAllButton => SelectChip(
        label: " Clear",
        onSelected: (_) => setState(() {
          GlobalState.set(context, subscribedFloors: {state!.floor!}, status: Status.idle);
        }),
      );

  SelectChip floorChip(int floor) => SelectChip(
        label: " ${floor}F",
        icon: "bell_outlined",
        isSelected: state?.status == Status.waiting && subscribedFloors.contains(floor),
        onSelected: (isSelected) => setState(() {
          if (isSelected) {
            if (state?.status == Status.waiting) {
              subscribedFloors.add(floor);
            } else {
              state?.subscribedFloors = {floor};
            }
            GlobalState.set(context, status: Status.waiting);
          } else {
            subscribedFloors.remove(floor);
            GlobalState.set(
              context,
              status: subscribedFloors.isEmpty ? Status.idle : null,
              subscribedFloors: subscribedFloors.isEmpty ? {state!.floor!} : subscribedFloors,
            );
          }
        }),
      );
}
