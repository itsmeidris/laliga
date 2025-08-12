import 'package:flutter/material.dart';
import 'package:untitled/themes/theme_colors.dart';

class ThemeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ThemeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      titleSpacing: 0,
      toolbarHeight: 80,
      backgroundColor: ThemeColors.myBlack,
      elevation: 0,
      title: Image.asset(
        'assets/clubPics/laliga.png',
        color: ThemeColors.myWhite,
        width: 60,
        height: 60,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
