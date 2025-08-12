import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controllers/laliga_controller.dart';
import 'package:untitled/themes/theme_app_bar.dart';
import 'package:untitled/themes/theme_colors.dart';
import 'package:untitled/themes/theme_liga_timer.dart';

class LaligaScoreBoard extends StatefulWidget {
  const LaligaScoreBoard({super.key});

  @override
  State<LaligaScoreBoard> createState() => _LaligaScoreBoardState();
}

class _LaligaScoreBoardState extends State<LaligaScoreBoard>
    with TickerProviderStateMixin {
  late LaligaController laligaController;

  @override
  void initState() {
    super.initState();
    laligaController = LaligaController(vsync: this); // Provide vsync
    Get.put(laligaController); // Register the controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.myWhite,
      appBar: const ThemeAppBar(),
      body: ThemeLigaTimer(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(onPressed: () {}, child: Text("lamine yamal")),
          //  ElevatedButton(onPressed: () {}, child: Text("Kylan Mbappe "))
        ],
      ),
    );
  }
}
