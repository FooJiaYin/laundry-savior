import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/l10n.dart';
import '../../models/dormitory.dart';
import '../../models/global_state.dart';
import '../../models/machine.dart';
import '../../services/fake_data.dart';
import '../../theme/theme.dart';
import '../../utils/config.dart';
import '../../utils/string.dart';
import '../components/machine_status_card.dart';
import '../components/neumorphic_toggle.dart';
import '../components/status_card.dart';
import '../components/waiting_switch.dart';
import '../widgets/button.dart';
import '../widgets/scaffold_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  final String title = AppConfig.title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Dormitory dorm;
  List<Machine> washingMachines = [];
  List<Machine> dryerMachines = [];
  List<int> floors = [];
  Set<int> subscribedFloors = {};
  List<bool> selectFloors = [false, false];

  loadItems() async {
    dorm = await FakeData.getDormitory();
    washingMachines = await FakeData.getWashingMachines(dorm);
    dryerMachines = await FakeData.getDryerMachines(dorm);
    floors = context.read<GlobalState>().dormitory?.floors ?? [];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  @override
  Widget build(BuildContext context) {
    GlobalState state = GlobalState.of(context);
    var floorFilter = (machine) => state.viewIndex == 0 ? machine.floor == state.floor : machine.status.code == StatusCode.available;
    var homePage = ScaffoldPage(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: Dimensions.containerPadding, bottom: 8),
          child: _titleRow(),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const StatusCard(),
          const SizedBox(height: 40),
          _floorSelector(state.dormitory, state.floor),
          const SizedBox(height: 24),
          ..._machineSection(
            iconName: "drop_filled",
            title: S.of(context).washing_machine,
            machines: washingMachines.where(floorFilter).toList(),
            type: WashingMachine,
          ),
          const SizedBox(height: 32),
          ..._machineSection(
            iconName: "wind",
            title: S.of(context).dryer_machine,
            machines: dryerMachines.where(floorFilter).toList(),
            type: DryerMachine,
          ),
          const SizedBox(height: 40),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

    if (state.anonymous) {
      return Stack(
        children: [
          homePage,
          const ModalBarrier(dismissible: false, color: Colors.black45),
          Scaffold(
            appBar: AppBar(backgroundColor: Colors.transparent),
            backgroundColor: Colors.transparent,
            body: Container(
              padding: const EdgeInsets.all(Dimensions.screenPadding).copyWith(top: 8),
              child: const StatusCard(),
            ),
          ),
        ],
      );
    } else {
      return homePage;
    }
  }

  Widget _titleRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title),
          RoundIconButton(
            SvgPicture.asset("assets/icons/settings.svg"),
            onTap: () => Navigator.pushNamed(context, "/settings"),
          ),
        ],
      );

  Widget _floorSelector(Dormitory? dorm, int? floor) => Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(dorm?.name ?? "Dormitory not selected", style: ThemeFont.title(fontSize: 12)),
          ),
          Expanded(
            flex: 3,
            child: NeumorphicToggle(
                selectedIndex: GlobalState.of(context).viewIndex,
                radius: 100,
                height: 36,
                optionWidgets: [
                  Text("${floor != null ? floor.ordinal : '--'} Floor", textAlign: TextAlign.center),
                  const Text("All Floors", textAlign: TextAlign.center),
                ],
                onChanged: (value) => GlobalState.set(context, viewIndex: value)),
          ),
        ],
      );

  List<Widget> _machineSection({
    required String iconName,
    required String title,
    required Type type,
    int filter = 0,
    List<Machine> machines = const [],
  }) =>
      [
        Row(
          children: [
            SvgPicture.asset("assets/icons/$iconName.svg", width: 20, height: 20),
            const SizedBox(width: 8),
            Text(title.capitalizeEach, style: ThemeFont.header()),
            // Expanded(child: Container()),
            const SizedBox(width: 8),
            Expanded(
              child: InkWell(
                onTap: () => setState(() {
                  selectFloors[0] = !selectFloors[0];
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        subscribedFloors.isEmpty ? "Select Floors" : "${(subscribedFloors.toList()..sort((a, b) => (a - b))).join(',')}F",
                        style: ThemeFont.small,
                        // overflow: TextOverflow,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                      child: Icon(selectFloors[0] ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, size: 16),
                    ),
                    WaitingSwitch(machineType: type),
                  ],
                ),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () => setState(() {
            selectFloors = [false, false];
          }),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            height: selectFloors[0] ? null : 0,
            // clipBehavior: Clip.hardEdge,
            child: Wrap(clipBehavior: Clip.hardEdge, spacing: 4, crossAxisAlignment: WrapCrossAlignment.center,
                // runSpacing: 4,
                // alignment: WrapAlignment.spaceBetween,
                // children: subscribedFloors.toList()
                children: [
                  _notificationChip(null),
                  ...floors.map(_notificationChip).toList(),
                  // Icon(Icons.keyboard_arrow_up_rounded)
                  // Text("Close", style: ThemeFont.small)
                ]),
          ),
        ),
        const SizedBox(height: 2),
        GridView.count(
          clipBehavior: Clip.none,
          crossAxisCount: 3,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 0.65,
          primary: true,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: machines.map((machine) => MachineStatusCard(machine)).toList(),
        )
      ];

  Widget _notificationChip(int? floor) => FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon(Icons.notifications_outlined, size: 12),
            if (subscribedFloors.length < floors.length || floor != null) 
            SvgPicture.asset(
              "assets/icons/bell_outlined.svg", width: 16, height: 16,
              // SvgPicture.asset("assets/icons/bell_${subscribedFloors.contains(floor)? 'filled': 'outlined'}.svg", width: 16, height: 16,
              color: subscribedFloors.contains(floor) ? Colors.white : ThemeColors.textColor,
              // colorBlendMode: BlendMode.,
            ),
            Text(floor != null ? " ${floor}F" : subscribedFloors.length >= floors.length? " Clear" : " All"),
          ],
        ),
        labelStyle: TextStyle(
          color: subscribedFloors.contains(floor) ? Colors.white : ThemeColors.textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: ThemeColors.lightGrey,
        selectedColor: ThemeColors.primaryColor,
        selected: subscribedFloors.contains(floor),
        showCheckmark: false,
        onSelected: (bool isSelected) {
          setState(() {
            if (floor == null) {
             subscribedFloors = subscribedFloors.length < floors.length ? floors.toSet() : {};
            }
            else if (isSelected) {
              subscribedFloors.add(floor);
            } else {
              subscribedFloors.remove(floor);
            }
          });
        },
      );
}
