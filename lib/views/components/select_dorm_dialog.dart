// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../widgets/container.dart';
import 'app_bar.dart';

class SelectDormDialog extends StatelessWidget {
  const SelectDormDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: Dimensions.dialogInsetPadding,
      child: CardContainer(
        padding: Dimensions.dialogContainerPadding,
        child: Column(
          children: [
            CenterAppBar(title: "Select Dormitory", titleStyle: ThemeFont.header(fontSize: 20)),
            const SizedBox(height: 32),
            GridView.count(
              clipBehavior: Clip.none,
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 8.0 / 5,
              primary: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CardContainer(margin: EdgeInsets.zero, child: Text(''), backgroundColor: Colors.red),
                CardContainer(margin: EdgeInsets.zero, child: Text(''), backgroundColor: Colors.red),
                CardContainer(margin: EdgeInsets.zero, child: Text(''), backgroundColor: Colors.red),
                CardContainer(margin: EdgeInsets.zero, child: Text(''), backgroundColor: Colors.red),
                CardContainer(margin: EdgeInsets.zero, child: Text(''), backgroundColor: Colors.red),
              ]
            ),
          ],
        ),
      ),
    );
  }
}