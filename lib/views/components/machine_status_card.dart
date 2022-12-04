import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/global_state.dart';
import '../../theme/theme.dart';
import '../../utils/string.dart';
import '../screens/machine.dart';
import '../widgets/progress_ring.dart';
import 'neumorphic_container.dart';
import 'select_dorm_dialog.dart';

class MachineStatusCard extends StatelessWidget {
  const MachineStatusCard(this.data, {Key? key}) : super(key: key);

  final Machine data;

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      padding: const EdgeInsets.all(16),
      onTap: () => GlobalState.of(context, listen: false).anonymous
          ? showDialog(context: context, builder: (context) => const SelectDormDialog())
          : Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => MachinePage(data),
              ),
            ),
      child: Column(
        children: [
          Text(
            data.locationString,
            style: ThemeFont.small,
          ),
          const SizedBox(height: 4),
          
          Expanded(
            child: data.status.code == StatusCode.in_use
                ? ProgressRing(
                    value: data.status.durationPassed.inMinutes / data.status.durationEstimated.inMinutes,
                    strokeWidth: 5.5,
                    strokeGradient: ThemeColors.blueRingGradient,
                    child: Text("${data.status.minutesLeft}m"),
                  )
                : SvgPicture.asset('assets/images/home_${data.status.code.name}.svg'),
          ),
          const SizedBox(height: 6),
          Text(
            data.status.code.name.splitUnderScore.capitalizeEach,
            style: ThemeFont.title(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
