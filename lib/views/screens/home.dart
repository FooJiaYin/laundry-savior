import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/l10n.dart';
import '../../models/machine.dart';
import '../../models/machine_status.dart';
import '../../theme/theme.dart';
import '../../utils/config.dart';
import '../../utils/string.dart';
import '../components/instruction_card.dart';
import '../components/machine_status_card.dart';
import '../components/neumorphic_toggle.dart';
import '../widgets/button.dart';
import '../widgets/scaffold_page.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  final String title = AppConfig.title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  
  // TODO: Use services/fake_data provide data
  Machine machineAvailable = Machine(
    id: 0,
    floor: 8,
    section: 'A',
    type: WashingMachine,
    status: MachineStatus(code: StatusCode.available),
  );
  Machine machineInUse = Machine(
    id: 1,
    floor: 8,
    section: 'A',
    type: WashingMachine,
    status: MachineStatus(
      code: StatusCode.in_use,
      durationEstimated: const Duration(minutes: 40),
      durationPassed: const Duration(minutes: 13),
    ),
  );
  Machine machineOverdue = Machine(
    id: 2,
    floor: 8,
    section: 'A',
    type: WashingMachine,
    status: MachineStatus(
      code: StatusCode.overdue,
      durationEstimated: const Duration(minutes: 40),
      durationPassed: const Duration(minutes: 10),
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: Dimensions.containerPadding),
          child: _titleRow(),
        ),
      ),
      child: Column(
        children: <Widget>[
          // TODO: Differenct instructions
          const InstructionCard(
            title: "Welcome to Laundry Savior",
            description: 'Tell us where do you live!',
            actionWidget: ActionText('Select Dorm', color: ThemeColors.royalBlue),
          ),
          const SizedBox(height: 40),
          _floorSelector(),
          const SizedBox(height: 24),
          // TODO: Update when switched floor
          ..._machineSection(
            iconName: "drop_filled",
            title: S.of(context).washing_machine,
            machines: [machineAvailable, machineInUse, machineInUse, machineOverdue],
          ),
          const SizedBox(height: 32),
          ..._machineSection(
            iconName: "wind",
            title: S.of(context).dryer_machine,
            machines: [machineAvailable, machineAvailable, machineOverdue],
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
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (context) => const SettingPage()),
            ),
          ),
        ],
      );

  Widget _floorSelector() => Row(
        children: [
          Expanded(
            flex: 2,
            child: Text("Guo-Ching Dorm", style: ThemeFont.title(fontSize: 12)),
          ),
          Expanded(
            flex: 3,
            child: NeumorphicToggle(
              // selectedIndex: _selectedIndex,
              height: 36,
              optionWidgets: const [
                Text("8F", textAlign: TextAlign.center),
                Text("All floors", textAlign: TextAlign.center),
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
          children: machines.map((machine) => MachineStatusCard(data: machine)).toList(),
        )
      ];
}
