library subtitle_view;

import 'package:flutter/material.dart';
import 'package:subtitle_view/src/controller/subtitle_controller.dart';
export 'package:subtitle_view/src/controller/subtitle_controller.dart';

class SubtitleView extends StatelessWidget {
  final SubtitleController subtitleController;
  final int currentTimeInMilliseconds;
  final Color textColor;
  final Color borderColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Color backgroundSubtitleColor;
  final String? fontFamily;
  const SubtitleView({
    Key? key,
    this.backgroundSubtitleColor = const Color.fromRGBO(0, 0, 0, 0.6),
    this.borderColor = Colors.white,
    this.textColor = Colors.black,
    this.fontSize = 24,
    this.fontFamily,
    this.fontWeight = FontWeight.w400,
    required this.currentTimeInMilliseconds,
    required this.subtitleController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      color: subtitleController.textFromWebttvBasedOnMilliseconds(
                  currentTimeInMilliseconds,
                  subtitleController.subtitleDataList) ==
              ""
          ? Colors.transparent
          : backgroundSubtitleColor,
      child: Stack(
        children: [
          Text(
            subtitleController.textFromWebttvBasedOnMilliseconds(
                currentTimeInMilliseconds, subtitleController.subtitleDataList),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: fontSize,
              fontWeight: fontWeight,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = borderColor,
            ),
          ),
          Text(
            subtitleController.textFromWebttvBasedOnMilliseconds(
                currentTimeInMilliseconds, subtitleController.subtitleDataList),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: fontWeight,
              fontFamily: fontFamily,
              fontSize: fontSize,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
