import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/global_state.dart';
import '../../models/machine.dart';
import '../../services/fake_data.dart';
import '../../theme/theme.dart';
import '../../utils/string.dart';
import '../components/app_bar.dart';
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

  final Machine? data;

  @override
  State<MachinePage> createState() => _MachinePageState();
}

class _MachinePageState extends State<MachinePage> {
  Machine get data => widget.data ?? GlobalState.instance.currentMachine!;
  int _selectedPrice = 10;
  int get _selectedDuration => data.type == WashingMachine ? 40 : (_selectedPrice * 2.5).toInt();

  @override
  void initState() {
    super.initState();
    collectLaundry();
  }

  /// Take out clothes if laundry done
  collectLaundry() {
    var state = GlobalState.instance;
    if (data == state.currentMachine && data.status.code == StatusCode.overdue) {
      Future.delayed(const Duration(seconds: 1), () => FakeData.collectLaundry(state));
    }
  }

  selectPrice(price) {
    setState(() {
      _selectedPrice = price;
    });
  }

  Widget _machinePicture() => NeumorphicContainer(
        width: null,
        padding: const EdgeInsets.all(32),
        shadows: const [...ThemeDecoration.neumorphicShadow, ...ThemeDecoration.neumorphicShadow],
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

    showPaymentDialog() {
      showDialog(
        context: context,
        builder: (context) => PaymentDialog(
          data,
          price: _selectedPrice,
          minutes: _selectedDuration,
        ),
      );
    }

    List<Widget> getContents(data) {
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
                  : null,
            ),
            const SizedBox(height: 24),
            if (defaultPaymentMethod != null) ...[
              NeumorphicButton(
                gradient: ThemeColors.blueRingGradient,
                text: "Pay with $defaultPaymentMethod",
                onPressed: () => FakeData.pay(context, paymentMethod: defaultPaymentMethod, minutes: _selectedDuration, machine: data),
              ),
              const SizedBox(height: 12),
              NeumorphicButton(text: "Other payment method", onPressed: showPaymentDialog),
            ] else
              NeumorphicButton(
                gradient: ThemeColors.blueRingGradient,
                text: "Pay to use",
                onPressed: showPaymentDialog,
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
          NeumorphicButton(text: "Normal", onPressed: () => FakeData.wash(context)),
          const SizedBox(height: 24),
          NeumorphicButton(
            text: data.type == WashingMachine ? "Delicate Wash" : "Low Temperature",
            onPressed: () => FakeData.wash(context, mode: data.type == WashingMachine ? "Delicate Wash" : "Low Temperature"),
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
              "Laundry is done!",
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
        ],
      };

      return contents[status] ?? contents[data.status.code] ?? [];
    }

    // TODO: Alarm pages
    Widget machinePage = ScaffoldPage(
      appBar: AppBar(
        title: const CenterAppBar(),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      alignment: Alignment.center,
      extendBodyBehindAppBar: true,
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: ChangeNotifierProvider<Machine>.value(
        value: FakeData.machines.firstWhere((machine) => machine.id == data.id),
        child: Builder(
          builder: (context) {
            var machine = context.watch<Machine>();

            return Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  data.type.name.capitalizeEach,
                  style: ThemeFont.header(fontSize: 24),
                ),
                const SizedBox(height: 14),
                Text(
                  "${data.floor} Floor${machine.section != null ? ", Area ${data.section}" : ""}",
                ),
                const SizedBox(height: 40),
                _machinePicture(),
                const SizedBox(height: 48),
                SizedBox(
                  height: 240,
                  child: Column(
                    children: getContents(machine),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        return status != Status.mode;
        final willPop = await showDialog<bool>(context: context, builder: (context) => const ExitAlertDialog());
        return willPop!;
      },
      child: machinePage,
    );
  }
}
