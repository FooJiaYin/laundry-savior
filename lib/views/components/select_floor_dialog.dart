import 'package:flutter/material.dart';

import '../../models/global_state.dart';
import '../../theme/theme.dart';
import '../../utils/string.dart';
import 'option_item.dart';
import 'select_dialog.dart';

class SelectFloorDialog extends StatelessWidget {
  const SelectFloorDialog(
    this.floors, {
    Key? key,
  }) : super(key: key);

  final List<int> floors;

  @override
  Widget build(BuildContext context) {
    return SelectDialog(
      title: "${GlobalState.of(context).dormitory!.name} Dorm",
      padding: const EdgeInsets.only(top: 36, bottom: 24, left: 8, right: 8),
      // Use ListView to enable scroll
      child: ListView.builder(
        itemCount: floors.length,
        shrinkWrap: true,
        // Wrap with ListTile to prevent clipping shadow
        itemBuilder: (context, id) => ListTile(
          title: FloorItem(id: floors[id]),
        ),
      ),
    );
  }
}

class FloorItem extends StatelessWidget {
  const FloorItem({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    bool isDefault = id == GlobalState.of(context).floor;
    return OptionItem(
      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 14, right: 8),
      verticalMargin: 4,
      onTap: () => {
        // TODO: Set dorm & floor in shared preference
        GlobalState.set(context, floor: id),
        Navigator.pop(context),
        Navigator.pop(context)
      },
      child: Center(
        child: Text(
          "${id.ordinal} Floor",
          style: ThemeFont.header(
            color: isDefault ? ThemeColors.primaryColor : null,
          ),
        ),
      ),
    );
  }
}
