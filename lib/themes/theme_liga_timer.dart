import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/themes/theme_colors.dart';

class ThemeLigaTimer extends StatefulWidget {
  const ThemeLigaTimer({super.key});

  @override
  State<ThemeLigaTimer> createState() => _ThemeLigaTimerState();
}

class _ThemeLigaTimerState extends State<ThemeLigaTimer> {
  Timer? _timer;
  int _seconds = 0;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '4');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: ThemeColors.myRed,
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/clubPics/laliga.png',
                          color: ThemeColors.myWhite,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: ThemeColors.myWhite,
                  padding: const EdgeInsets.all(4),
                  child: Expanded(
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          _formatTime(_seconds),
                          style: TextStyle(
                              fontSize: 36,
                              color: ThemeColors.myBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: ThemeColors.myBlack,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: Image.asset('assets/clubPics/madrid.png'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Center(
                        child: Image.asset('assets/clubPics/fcbarca.png'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: ThemeColors.myBlack,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: ThemeColors.myWhite,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: ThemeColors.myRed,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: ThemeColors.myBlue,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: ThemeColors.myWhite,
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          '0',
                          //'$_madridScore',
                          style: TextStyle(
                              fontSize: 45,
                              color: ThemeColors.myBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: ThemeColors.myBlack,
                    endIndent: 5,
                    indent: 5,
                  ),
                  Expanded(
                    child: FittedBox(
                      child: Center(
                        child: Text(
                          '0',
                          //'$_barcaScore',
                          style: TextStyle(
                              fontSize: 45,
                              color: ThemeColors.myBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
