// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../widgets/container.dart';
import 'select_dialog.dart';

class SelectDormDialog extends StatelessWidget {
  const SelectDormDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectDialog(
      title: "Select Dormitory",
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 8.0 / 5,
        shrinkWrap: true,
        children: [
          DormitoryItem(),
          DormitoryItem(),
          DormitoryItem(),
          DormitoryItem(),
          DormitoryItem(),
        ],
      ),
    );
  }
}

class DormitoryItem extends StatelessWidget {
  const DormitoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      // TODO: Replace with NetworkImage
      backgroundImage: AssetImage("assets/images/dorm.png"),
      child: ColoredBox(
        color: ThemeColors.grey.withOpacity(0.5),
        child: Center(
          child: Text(
            "Male 1",
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
