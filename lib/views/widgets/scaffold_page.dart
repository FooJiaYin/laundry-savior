import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class ScaffoldPage extends StatelessWidget {
  const ScaffoldPage({
    Key? key,
    this.child,
    this.appBar,
    this.padding,
    this.height,
    this.backgroundColor,
    this.backgroundGradient,
    this.backgroundImage,
    this.alignment = Alignment.topCenter,
  }) : super(key: key);

  final Widget? child;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final DecorationImage? backgroundImage;
  final EdgeInsets? padding;
  final Alignment alignment;
  final double? height;


  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        appBar: appBar,
        backgroundColor: backgroundColor,
        body: Container(
          alignment: alignment,
          decoration: BoxDecoration(
            gradient: backgroundGradient,
            image: backgroundImage,
          ),
          child: SingleChildScrollView(
            child: Container(
              height: height,
              padding: padding ?? const EdgeInsets.all(Dimensions.screenPadding),
              child: child,
            ),
          ),
        ),
      );
  }
}