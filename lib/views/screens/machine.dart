// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/l10n.dart';
import '../../models/machine.dart';
import '../../theme/theme.dart';
import '../../utils/string.dart';
import '../components/neumorphic_container.dart';
import '../widgets/button.dart';
import '../widgets/scaffold_page.dart';
import '../widgets/shape.dart';

enum UseStep { pay, mode, using }

class MachinePage extends StatefulWidget {
  const MachinePage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Machine data;

  @override
  State<MachinePage> createState() => _MachinePageState();
}

class _MachinePageState extends State<MachinePage> {
  Machine get data => widget.data;

  Widget _machinePicture() => NeumorphicContainer(
        width: null,
        padding: const EdgeInsets.all(32),
        borderRadius: 43.0,
        child: Circle(
          shadows: [
            BoxShadow(color: ThemeColors.grey.withOpacity(0.38), offset: const Offset(1, 2), blurRadius: 4, spreadRadius: -1),
            const BoxShadow(color: Colors.white, offset: const Offset(-1, -2), blurRadius: 4, spreadRadius: -1),
          ],
          child: SvgPicture.asset('assets/images/machine_${data.status.code.name}.svg'),
        ),
      );

  @override
  Widget build(BuildContext context) {
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
            style: ThemeFont.style(color: ThemeColors.grey),
          ),
          const SizedBox(height: 40),
          _machinePicture(),
          const SizedBox(height: 48),
          Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: 76,
                child: Text("Pay to use", style: ThemeFont.header(fontSize: 20, color: ThemeColors.darkGrey)),
              ),
              const SizedBox(height: 24),
              Button(
                text: "Pay by phone",
              ),
              const SizedBox(height: 24),
              Text("or Insert Coin into the machine", style: ThemeFont.style(color: ThemeColors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
