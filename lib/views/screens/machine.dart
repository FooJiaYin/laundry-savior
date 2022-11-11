import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/l10n.dart';
import '../../models/global_state.dart';
import '../../models/machine.dart';
import '../../services/fake_data.dart';
import '../../theme/theme.dart';
import '../../utils/string.dart';
import '../components/exit_alert_dialog.dart';
import '../components/neumorphic_button.dart';
import '../components/neumorphic_container.dart';
import '../components/payment_dialog.dart';
import '../widgets/scaffold_page.dart';
import '../widgets/shape.dart';
import 'price_button.dart';

export '../../models/machine.dart';

class MachinePage extends StatefulWidget {
  const MachinePage(this.data, {Key? key}) : super(key: key);

  final Machine data;

  @override
  State<MachinePage> createState() => _MachinePageState();
}

class _MachinePageState extends State<MachinePage> {
  Machine get data => widget.data;
  GlobalState state = GlobalState();
  int _selectedPrice = 10;

  selectPrice(price) {
    setState(() {
      _selectedPrice = price;
    });
  }

  goToNextStep({required MachineStatus machineStatus, Status? status}) {
    var state = GlobalState.of(context, listen: false);
    state.currentMachine!.status = machineStatus;
    state.update(status: status ?? state.status);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<void>(
        builder: (context) => MachinePage(data),
      ),
      (route) => route.isFirst,
    );
  }

  wash(String mode) {
    goToNextStep(
      machineStatus: const MachineStatus(
        code: StatusCode.in_use,
        durationEstimated: Duration(minutes: 40),
        durationPassed: Duration.zero,
      ),
      status: Status.using,
    );
    Future.delayed(const Duration(seconds: 10), () {
      state.currentMachine!.status = MachineStatus(code: StatusCode.overdue);
      state.update();
    });
  }

  Widget _machinePicture() => NeumorphicContainer(
        width: null,
        padding: const EdgeInsets.all(32),
        shadows: [...ThemeDecoration.neumorphicShadow, ...ThemeDecoration.neumorphicShadow],
        borderRadius: 43.0,
        child: Circle(
          shadows: ThemeDecoration.circleShadow,
          child: SvgPicture.asset('assets/images/machine_${data.status.code.name}.svg'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    state = GlobalState.of(context);
    // TODO: refactor this
    // TODO: Message for dryer machine
    // TODO: i18n strings

    var contents = {
      StatusCode.available: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          height: 96,
          child: data.type == DryerMachine
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceButton(price: 10, name: "25 min", onPressed: selectPrice, isSelected: _selectedPrice == 10),
                    PriceButton(price: 20, name: "50 min", onPressed: selectPrice, isSelected: _selectedPrice == 20),
                    PriceButton(price: 30, name: "70 min", onPressed: selectPrice, isSelected: _selectedPrice == 30),
                  ],
                )
              : Text("Pay to use", style: ThemeFont.header(fontSize: 20, color: ThemeColors.darkGrey)),
        ),
        const SizedBox(height: 24),
        if (state.defaultPaymentMethod != null)
          NeumorphicButton(
            gradient: ThemeColors.blueRingGradient,
            text: "Use ${state.defaultPaymentMethod}",
            onPressed: () => FakeData.pay(context, paymentMethod: state.defaultPaymentMethod!, machine: data),
          ),
        if (state.defaultPaymentMethod != null) const SizedBox(height: 12),
        NeumorphicButton(
          gradient: state.defaultPaymentMethod == null ? ThemeColors.blueRingGradient : null,
          text: "Select a payment method",
          onPressed: () => showDialog(context: context, builder: (context) => PaymentDialog(data, price: _selectedPrice)),
        ),
        const SizedBox(height: 24),
        const Text("or Insert Coin into the machine")
      ],
      Status.mode: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          height: 96,
          child: Text(
            data.type == WashingMachine ? "Washing Mode" : "Drying Mode",
            style: ThemeFont.header(fontSize: 20, color: ThemeColors.darkGrey),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
        NeumorphicButton(text: "Normal", onPressed: () => wash("Normal")),
        const SizedBox(height: 24),
        NeumorphicButton(text: data.type == WashingMachine ? "Delicate Wash" : "Low Temperature", onPressed: () => wash("Delicate"),),
      ],
      StatusCode.in_use: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          height: 96,
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
        const Text(
          "You’ll be reminded when the laundry is done.",
          textAlign: TextAlign.center,
        ),
      ],
      StatusCode.overdue: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          height: 96,
          child: Text(
            "Launry is done!",
            style: ThemeFont.header(fontSize: 20, color: ThemeColors.darkGrey),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          data == state.currentMachine ? "Please collect your laundry ASAP!" : "Seem like someone haven’t take their laundry.",
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        // TODO: Notification
        if (data != state.currentMachine)
          NeumorphicButton(
            text: "Ping",
            gradient: ThemeColors.pinkRingGradient,
            onPressed: () => {},
          ),
      ],
    };

    // TODO: Alarm pages
    Widget _machinePage = ScaffoldPage(
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
            "${data.floor} Floor" + (data.section != null ? ", Area ${data.section}" : ""),
          ),
          const SizedBox(height: 40),
          _machinePicture(),
          const SizedBox(height: 48),
          SizedBox(
            height: 240,
            child: Column(
              children: contents[state.status] ?? contents[data.status.code] ?? [],
            ),
          ),
        ],
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        return state.status != Status.mode;
        final willPop = await showDialog<bool>(context: context, builder: (context) => ExitAlertDialog());
        return willPop!;
      },
      child: _machinePage,
    );
  }
}
