// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../theme/theme.dart';

class ProgressRing extends StatelessWidget {
  const ProgressRing({
    Key? key,
    required this.value,
    this.size,
    this.strokeWidth = 1 / 3,
    this.strokeColor = ThemeColors.primaryColor,
    this.innerColor = ThemeColors.backgroundColor,
    this.strokeGradient,
    this.child,
  }) : super(key: key);
  final double value;
  final double? size;
  final double strokeWidth;
  final Color? strokeColor;
  final Color? innerColor;
  final Gradient? strokeGradient;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double _size = size ?? min(constraints.maxWidth, constraints.maxHeight); 
        return Stack(
          alignment: Alignment.center,
          children: [
            // Stroke
            Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              height: _size,
              width: _size,
              decoration: BoxDecoration(
                color: strokeColor,
                shape: BoxShape.circle,
                gradient: strokeGradient,
              ),
            ),
            // Progress (empty)
            SizedBox(
              width: _size * 2 / 3,
              height: _size * 2 / 3,
              child: CircularProgressIndicator(
                value: 1 - value,
                strokeWidth: _size / 3 + 1,
                backgroundColor: Colors.transparent,
                color: ThemeColors.lightGrey,
              ),
            ),
            // Inner space
            Container(
              height: _size - (strokeWidth < 1 ? _size * strokeWidth : strokeWidth * 2),
              width: _size - (strokeWidth < 1 ? _size * strokeWidth : strokeWidth * 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ThemeColors.backgroundColor,
                boxShadow: ThemeDecoration.ringShadow,
              ),
            ),
            Center(
              child: child,
            )
          ],
        );
      }
    );
  }
}
