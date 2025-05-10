import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/screens/laliga_score_board.dart';
import 'package:untitled/themes/theme_colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: ThemeColors.myWhite, body: LaligaScoreBoard()),
      theme: ThemeData(textTheme: GoogleFonts.farroTextTheme()),
      debugShowCheckedModeBanner: false,
    );
  }
}
