// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../models/dormitory.dart';
import '../../services/fake_data.dart';
import '../../theme/theme.dart';
import '../../models/global_state.dart';
import '../widgets/container.dart';
import 'select_dialog.dart';
import 'select_floor_dialog.dart';

class SelectDormDialog extends StatefulWidget {
  const SelectDormDialog({Key? key}) : super(key: key);

  @override
  State<SelectDormDialog> createState() => _SelectDormDialogState();
}

class _SelectDormDialogState extends State<SelectDormDialog> {
  List<Dormitory> dorms = [];

  loadItems() async {
    dorms = await FakeData.getDormitories("ntu");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return SelectDialog(
      title: "Select Dormitory",
      child: GridView.count(
        clipBehavior: Clip.none,
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 8.0 / 5,
        primary: true,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: dorms.map((dorm) => DormitoryItem(dorm)).toList(),
      ),
    );
  }
}

class DormitoryItem extends StatelessWidget {
  const DormitoryItem(this.data, {Key? key}) : super(key: key);

  final Dormitory data;

  onDormSelected(context) {
    GlobalState.of(context, listen: false).update(dormitory: data);
    showDialog(context: context, builder: (context) => SelectFloorDialog(data.floors));
  }

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      // TODO: Replace with NetworkImage
      backgroundImage: AssetImage(data.imageUrl),
      onTap: () => onDormSelected(context),
      child: ColoredBox(
        color: ThemeColors.grey.withOpacity(0.5),
        child: Center(
          child: Text(
            data.name,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
