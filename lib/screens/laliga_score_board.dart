import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controllers/laliga_controller.dart';
import 'package:untitled/themes/theme_app_bar.dart';
import 'package:untitled/themes/theme_colors.dart';
import 'package:untitled/themes/theme_player_card.dart';

class LaligaScoreBoard extends StatefulWidget {
  LaligaScoreBoard({super.key});

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
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 400,
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: ThemeColors.myRed)),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              top: 10,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: ThemePlayerCard(
                                    animationController:
                                        laligaController.controller,
                                    teamOfPlayer: 'Real Madrid',
                                    teamPlayerPic: 'madrid/bellingham.png'),
                              ),
                            ),
                            Positioned.fill(
                              right: 20,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: ThemePlayerCard(
                                    animationController:
                                        laligaController.controller,
                                    teamOfPlayer: 'Real Madrid',
                                    teamPlayerPic: 'madrid/vini.png'),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: ThemePlayerCard(
                                    animationController:
                                        laligaController.controller,
                                    teamOfPlayer: 'Real Madrid',
                                    teamPlayerPic: 'madrid/mbappe.png'),
                              ),
                            ),
                            Positioned.fill(
                              left: 20,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: ThemePlayerCard(
                                    animationController:
                                        laligaController.controller,
                                    teamOfPlayer: 'Real Madrid',
                                    teamPlayerPic: 'madrid/rodri.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: ThemeColors.myBlack)),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: ThemePlayerCard(
                                    animationController:
                                        laligaController.controller,
                                    teamOfPlayer: 'Barca',
                                    teamPlayerPic: 'barca/raphinha.png'),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: ThemePlayerCard(
                                    animationController:
                                        laligaController.controller,
                                    teamOfPlayer: 'Barca',
                                    teamPlayerPic: 'barca/lewa.png'),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: ThemePlayerCard(
                                    animationController:
                                        laligaController.controller,
                                    teamOfPlayer: 'Barca',
                                    teamPlayerPic: 'barca/yamal.png'),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: ThemePlayerCard(
                                    animationController:
                                        laligaController.controller,
                                    teamOfPlayer: 'Barca',
                                    teamPlayerPic: 'barca/pedri.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () => null,
          style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColors.myRed,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              )),
          child: Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.tv,
                color: ThemeColors.myWhite,
              ),
              Text(
                'VAR',
                style: TextStyle(color: ThemeColors.myWhite),
              ),
            ],
          )),
    );
  }
}
