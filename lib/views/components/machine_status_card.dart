// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/machine.dart';
import '../../theme/theme.dart';
import '../../utils/string.dart';
import'../screens/machine.dart';
import 'neumorphic_container.dart';

class MachineStatusCard extends StatelessWidget {
  const MachineStatusCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Machine data;

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      padding: const EdgeInsets.all(16),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => MachinePage(data: data),
        ),
      ),
      child: Column(
        children: [
          Text(
            '${data.floor}${data.section}',
            style: ThemeFont.style(fontSize: 12, color: ThemeColors.grey),
          ),
          const SizedBox(height: 4),
          // TODO: Render circular progress for in_use status
          SvgPicture.asset('assets/images/home_${data.status.code.name}.svg'),
          const SizedBox(height: 6),
          Text(
            data.status.code.name.splitUnderScore.capitalizeEach,
            style: ThemeFont.style(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
