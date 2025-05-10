import 'package:flutter/material.dart';
import 'package:untitled/themes/theme_colors.dart';

class ThemePlayerCard extends StatelessWidget {
  final AnimationController animationController;
  final String teamOfPlayer;
  final String teamPlayerPic;
  const ThemePlayerCard(
      {super.key,
      required this.animationController,
      required this.teamOfPlayer,
      required this.teamPlayerPic});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
              begin: teamOfPlayer == 'Real Madrid'
                  ? const Offset(0, -0.24)
                  : const Offset(0, 0.1),
              end: teamOfPlayer == 'Real Madrid'
                  ? const Offset(0, 0.1)
                  : const Offset(0, -0.24))
          .animate(animationController),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: teamOfPlayer == 'Real Madrid'
                  ? [ThemeColors.myBlack, ThemeColors.myWhite]
                  : [ThemeColors.myRed, ThemeColors.myBlue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            border: Border.all(),
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
                image: AssetImage('assets/playersPics/$teamPlayerPic'),
                fit: BoxFit.cover)),
      ),
    );
  }
}
