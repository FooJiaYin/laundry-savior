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
    var defaultPadding = const EdgeInsets.all(Dimensions.screenPadding);
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
              padding: padding ?? (appBar != null ? defaultPadding.copyWith(top: 8) : defaultPadding),
              child: child,
            ),
          ),
        ),
      );
  }
}