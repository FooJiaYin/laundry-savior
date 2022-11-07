import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/theme.dart';
import '../../utils/config.dart';
import '../components/instruction_card.dart';
import '../widgets/button.dart';
import '../widgets/scaffold_page.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  final String title = AppConfig.title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: Dimensions.containerPadding),
          child: _titleRow(),
        ),
      ),
      child: Column(
        children: <Widget>[
          const InstructionCard(
            title: "Welcome to Laundry Savior",
            description: 'Tell us where do you live!',
            actionWidget: ActionText('Select Dorm', color: ThemeColors.royalBlue),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _titleRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title),
          RoundIconButton(
            SvgPicture.asset("assets/icons/settings.svg", width: 20, height: 20),
            backgroundSize: 40,
            backgroundColor: ThemeColors.backgroundColor,
            shadows: ThemeDecoration.neumorphicShadow,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const SettingPage(),
              ),
            ),
          ),
        ],
      );
}
