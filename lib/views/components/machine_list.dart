import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/global_state.dart';
import '../../models/machine.dart';
import '../../services/fake_data.dart';
import '../../theme/theme.dart';
import '../../utils/string.dart';
import 'machine_status_card.dart';
import 'neumorphic_container.dart';
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
    floorFilter(machine) => state?.viewIndex == 0 ? state!.subscribedFloors.contains(machine.floor) : machine.status.code == StatusCode.available;

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
        _floorChipsPanel(),
        const SizedBox(height: 8),
        ProxyProvider<GlobalState, List<Machine>>(
          update: (_, state, __) => state.floor != null ? machines.where(floorFilter).toList().sortByNearestFloor(state.floor ?? 0) : [],
          child: Builder(
            builder: (context) => GridView.count(
              clipBehavior: Clip.none,
              crossAxisCount: 3,
              crossAxisSpacing: 20,
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

  Widget _floorChipsPanel() => AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: selectFloors ? null : 0,
        padding: const EdgeInsets.only(bottom: 8),
        child: Wrap(
          clipBehavior: Clip.hardEdge,
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            /// Select All or Clear
            state!.subscribedFloors.length >= floors.length ? _clearAllButton : _selectAllButton,

            /// Floor chips
            ...floors.map(floorChip).toList(),
          ],
        ),
      );

  Widget get _selectAllButton => NeumorphicChip(
        "All",
        onSelected: (_) => setState(() {
          GlobalState.set(context, subscribedFloors: floors.toSet());
        }),
      );

  Widget get _clearAllButton => NeumorphicChip(
        "Reset",
        onSelected: (_) => setState(() {
          GlobalState.set(context, subscribedFloors: {state!.floor!});
        }),
      );

  Widget floorChip(int floor) => NeumorphicChip(
        "${floor}F",
        isSelected: subscribedFloors.contains(floor),
        onSelected: (isSelected) => setState(() {
          if (isSelected) {
            subscribedFloors.add(floor);
          } else {
            subscribedFloors.remove(floor);
            if (subscribedFloors.isEmpty) subscribedFloors.add(state!.floor!);
          }
          GlobalState.set(context, currentMachine: null);
          FakeData.updateCurrentMachine(GlobalState.instance);
        }),
      );
}

Widget NeumorphicChip(String label, {bool isSelected = false, double? fontSize = 12, EdgeInsets padding = const EdgeInsets.symmetric(vertical: 6, horizontal: 12), onSelected}) => NeumorphicContainer(
      width: null,
      borderRadius: 40.0,
      padding: padding,
      shadows: ThemeDecoration.circleShadow,
      backgroundColor: isSelected ? ThemeColors.backgroundColor : ThemeColors.lightGrey,
      gradient: isSelected ? ThemeColors.blueRingGradient : null,
      onTap: () => onSelected(!isSelected),
      child: Text(label, style: ThemeFont.style(color: isSelected ? Colors.white : null, fontSize: fontSize)),
    );
