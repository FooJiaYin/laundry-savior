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
import '../components/price_button.dart';
import '../widgets/scaffold_page.dart';
import '../widgets/shape.dart';

export '../../models/machine.dart';

class MachinePage extends StatefulWidget {
  const MachinePage(this.data, {Key? key}) : super(key: key);

  final Machine data;

  @override
  State<MachinePage> createState() => _MachinePageState();
}

class _MachinePageState extends State<MachinePage> {
  Machine get data => widget.data;
  int _selectedPrice = 10;
  int get _selectedDuration => (_selectedPrice * 0.25).toInt();

  @override
  void initState() {
    super.initState();
    collectClothes();
  }

  collectClothes() {
    var state = GlobalState.instance;
    if (data == state.currentMachine && data.status.code == StatusCode.overdue) {
      Future.delayed(const Duration(seconds: 1), () => FakeData.takeOutClothes(state));
    }
  }

  selectPrice(price) {
    setState(() {
      _selectedPrice = price;
    });
  }

  wash({String mode = "Normal"}) {
    FakeData.wash(GlobalState.of(context, listen: false));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<void>(
        builder: (context) => MachinePage(data),
      ),
      (route) => route.isFirst,
    );
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
    var defaultPaymentMethod = context.defaultPaymentMethod;
    var currentMachine = context.currentMachine;
    var status = context.status;
    // TODO: refactor this
    // TODO: Message for dryer machine
    // TODO: i18n strings

    var contents = {
      // TODO: Use multiple machines
      StatusCode.available: <Widget>[
        if (status == Status.using) ...[
          Container(
            alignment: Alignment.bottomCenter,
            height: 96,
            child: Text(
              "Machine Available!",
              style: ThemeFont.header(fontSize: 20, color: ThemeColors.darkGrey),
            ),
          ),
          const SizedBox(height: 24),
          const Text("You are using another machine", textAlign: TextAlign.center),
        ] else ...[
          Container(
            alignment: Alignment.bottomCenter,
            height: 96,
            child: data.type == DryerMachine
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PriceButton(price: 10, name: "25 min", onPressed: selectPrice, isSelected: _selectedPrice == 10),
                      PriceButton(price: 20, name: "50 min", onPressed: selectPrice, isSelected: _selectedPrice == 20),
                      PriceButton(price: 30, name: "75 min", onPressed: selectPrice, isSelected: _selectedPrice == 30),
                    ],
                  )
                : Text("Pay to use", style: ThemeFont.header(fontSize: 20, color: ThemeColors.darkGrey)),
          ),
          const SizedBox(height: 24),
          if (defaultPaymentMethod != null)
            NeumorphicButton(
              gradient: ThemeColors.blueRingGradient,
              text: "Use $defaultPaymentMethod",
              onPressed: () => FakeData.pay(context, paymentMethod: defaultPaymentMethod, machine: data),
            ),
          if (defaultPaymentMethod != null) const SizedBox(height: 12),
          NeumorphicButton(
            gradient: defaultPaymentMethod == null ? ThemeColors.blueRingGradient : null,
            text: "Select a payment method",
            onPressed: () => showDialog(context: context, builder: (context) => PaymentDialog(data, price: _selectedPrice)),
          ),
          const SizedBox(height: 24),
          const Text("or Insert Coin into the machine")
        ]
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
        NeumorphicButton(text: "Normal", onPressed: () => wash(mode: "Normal")),
        const SizedBox(height: 24),
        NeumorphicButton(
          text: data.type == WashingMachine ? "Delicate Wash" : "Low Temperature",
          onPressed: () => wash(mode: data.type == WashingMachine ? "Delicate Wash" : "Low Temperature"),
        ),
      ],
      StatusCode.in_use: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          height: 96,
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: data.status.minutesLeft.toString(),
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
          data == currentMachine ? "Please collect your laundry ASAP!" : "Seem like someone haven’t take their laundry.",
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        // TODO: Notification
        if (data != currentMachine)
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
              children: contents[status] ?? contents[data.status.code] ?? [],
            ),
          ),
        ],
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        return status != Status.mode;
        final willPop = await showDialog<bool>(context: context, builder: (context) => ExitAlertDialog());
        return willPop!;
      },
      child: _machinePage,
    );
  }
}
