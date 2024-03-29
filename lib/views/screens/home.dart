import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/dormitory.dart';
import '../../models/global_state.dart';
import '../../models/machine.dart';
import '../../theme/theme.dart';
import '../../utils/config.dart';
import '../components/machine_list.dart';
import '../components/neumorphic_toggle.dart';
import '../components/status_card.dart';
import '../widgets/button.dart';
import '../widgets/scaffold_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String title = AppConfig.title;

  @override
  Widget build(BuildContext context) {
    var homePage = ScaffoldPage(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: Dimensions.containerPadding, bottom: 8),
          child: _titleRow(),
        ),
      ),
      child: Column(
        children: <Widget>[
          const StatusCard(),
          const SizedBox(height: 40),
          _floorSelector(context.dormitory, "${context.subscribedFloorsString ?? '-- Floor'}", context.subscribedFloors != {context.floor} ? context.subscribedFloorsString : null),
          // if (_selectingFloors) ..._floorChipsPanel(),
          const SizedBox(height: 8),
          const MachineList(type: WashingMachine),
          const SizedBox(height: 32),
          const MachineList(type: DryerMachine),
          const SizedBox(height: 40),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

    if (context.anonymous) {
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
          Text(title),
          RoundIconButton(
            SvgPicture.asset("assets/icons/settings.svg"),
            onTap: () => Navigator.pushNamed(context, "/settings"),
          ),
        ],
      );

  Widget _floorSelector(Dormitory? dorm, String floorString, String? subscribeFloors) => Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(dorm?.name ?? "Dormitory not selected", style: ThemeFont.title(fontSize: 12)),
          ),
          Expanded(
            flex: 3,
            child: NeumorphicToggle(
              selectedIndex: context.viewIndex,
              radius: 100,
              height: 36,
              optionWidgets: [
                Text(floorString, textAlign: TextAlign.center),
                // if (subscribeFloors != null) Text(subscribeFloors, textAlign: TextAlign.center),
                const Text("All Floors", textAlign: TextAlign.center),
              ],
              onChanged: (value) => context.update(viewIndex: value),
            ),
          ),
        ],
      );
}