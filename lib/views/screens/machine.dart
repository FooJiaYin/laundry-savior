import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/l10n.dart';
import '../../models/machine.dart';
import '../../models/machine_status.dart';
import '../../theme/theme.dart';
import '../../utils/string.dart';
import '../components/neumorphic_button.dart';
import '../components/neumorphic_container.dart';
import '../widgets/scaffold_page.dart';
import '../widgets/shape.dart';

enum UseStep { pay, mode, using }

class MachinePage extends StatefulWidget {
  const MachinePage(this.data, {Key? key}) : super(key: key);

  final Machine data;
  final UseStep? step;

  @override
  State<MachinePage> createState() => _MachinePageState();
}

class _MachinePageState extends State<MachinePage> {
  Machine get data => widget.data;

  // UseStep step = UseStep.pay;

  // goToNextState() => setState(() {
  //       print(step.index);
  //       step = UseStep.values[step.index + 1];
  //     }),;

  goToNextStep(data, {state}) => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => MachinePage(data),
        ),
      );

  Widget _machinePicture() => NeumorphicContainer(
        width: null,
        padding: const EdgeInsets.all(32),
        borderRadius: 43.0,
        child: Circle(
          shadows: [
            BoxShadow(color: ThemeColors.grey.withOpacity(0.38), offset: const Offset(1, 2), blurRadius: 4, spreadRadius: -1),
            const BoxShadow(color: Colors.white, offset: Offset(-1, -2), blurRadius: 4, spreadRadius: -1),
          ],
          child: SvgPicture.asset('assets/images/machine_${data.status.code.name}.svg'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    // TODO: refactor this
    // TODO: Message for dryer machine
    // TODO: i18n strings
    var contents = {
      StatusCode.available: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          height: 76,
          child: Text("Pay to use", style: ThemeFont.header(fontSize: 20, color: ThemeColors.darkGrey)),
        ),
        const SizedBox(height: 24),
        NeumorphicButton(
          gradient: ThemeColors.blueRingGradient,
          text: "Pay by phone",
          onPressed: () => showDialog(context: context, builder: (context) => PaymentDialog(data)),
        ),
        const SizedBox(height: 24),
        Text("or Insert Coin into the machine")
      ],
      UseStep.mode: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          height: 76,
          child: Text(
            "Washing Mode",
            style: ThemeFont.header(fontSize: 20, color: ThemeColors.darkGrey),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
        NeumorphicButton(
          text: "Delicate Wash",
          onPressed: () => goToNextStep(
            data.copyWith(
              status: MachineStatus(
                code: StatusCode.in_use,
                durationEstimated: const Duration(minutes: 40),
                durationPassed: Duration.zero,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        NeumorphicButton(
          text: "Normal Wash",
          onPressed: () => goToNextStep(
            data.copyWith(
              status: MachineStatus(
                code: StatusCode.in_use,
                durationEstimated: const Duration(minutes: 40),
                durationPassed: Duration.zero,
              ),
            ),
          ),
        ),
      ],
      StatusCode.in_use: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          height: 76,
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: "40",
              style: ThemeFont.header(fontSize: 48, color: ThemeColors.darkGrey),
              children: const [
                TextSpan(
                  text: " min left",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "You’ll be reminded when the laundry is done.",
          textAlign: TextAlign.center,
        ),
      ],
      StatusCode.overdue: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          height: 76,
          child: Text(
            "Launry overdue!",
            style: ThemeFont.header(fontSize: 20, color: ThemeColors.darkGrey),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Seem like someone haven’t take their laundry.",
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        NeumorphicButton(
          text: "Ping",
          gradient: ThemeColors.pinkRingGradient,
          onPressed: () => {},
        ),
      ],
    };

    // TODO: Alarm pages
    return ScaffoldPage(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          Text(
            (data.type == WashingMachine ? S.of(context).washing_machine : S.of(context).dryer_machine).capitalizeEach,
            style: ThemeFont.header(fontSize: 24),
          ),
          const SizedBox(height: 14),
          Text(
            "${data.floor} Floor, Area ${data.section}",
          ),
          const SizedBox(height: 40),
          _machinePicture(),
          const SizedBox(height: 48),
          SizedBox(
            height: 220,
            child: Column(
              children: contents[widget.step ?? data.status.code]!,
            ),
          ),
        ],
      ),
    );
  }
}
