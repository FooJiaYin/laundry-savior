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
import '../components/instruction_card.dart';
import '../components/machine_status_card.dart';
import '../components/neumorphic_toggle.dart';
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
  int _selectedIndex = 0;

  loadItems() async {
    dorm = await FakeData.getDormitory();
    washingMachines = await FakeData.getWashingMachines(dorm);
    dryerMachines = await FakeData.getDryerMachines(dorm);
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
    return ScaffoldPage(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: Dimensions.containerPadding, bottom: 8),
          child: _titleRow(),
        ),
      ),
      child: Column(
        children: <Widget>[
          // TODO: Differenct instructions
          InstructionCard(),
          const SizedBox(height: 40),
          _floorSelector(state.dormitory, state.floor),
          const SizedBox(height: 24),
          // TODO: Update when switched floor
          ..._machineSection(
            iconName: "drop_filled",
            title: S.of(context).washing_machine,
            machines: washingMachines,
          ),
          const SizedBox(height: 32),
          ..._machineSection(
            iconName: "wind",
            title: S.of(context).dryer_machine,
            machines: dryerMachines,
          ),
          const SizedBox(height: 40),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
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
            child: Text("${dorm?.name ?? 'Your'} Dorm", style: ThemeFont.title(fontSize: 12)),
          ),
          Expanded(
            flex: 3,
            child: NeumorphicToggle(
              // selectedIndex: _selectedIndex,
              radius: 100,
              height: 36,
              optionWidgets: [
                Text("Floor ${floor ?? 8}", textAlign: TextAlign.center),
                const Text("All floors", textAlign: TextAlign.center),
              ],
              onChanged: (value) => setState(() {
                _selectedIndex = value;
              }),
            ),
          ),
        ],
      );

  List<Widget> _machineSection({
    required String iconName,
    required String title,
    List<Machine> machines = const [],
  }) =>
      [
        Row(
          children: [
            SvgPicture.asset("assets/icons/$iconName.svg", width: 20, height: 20),
            const SizedBox(width: 8),
            Text(title.capitalizeEach, style: ThemeFont.header()),
          ],
        ),
        const SizedBox(height: 20),
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
}
