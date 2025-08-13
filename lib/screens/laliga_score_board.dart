import 'package:flutter/material.dart';
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
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  // Goal Animation Controllers
  late AnimationController _goalAnimationController;
  late Animation<Offset> _goalSlideAnimation;
  late Animation<double> _goalScaleAnimation;
  late Animation<double> _goalOpacityAnimation;
  late Animation<double> _goalRotationAnimation;

  bool _showGoalText = false;
  String _goalScorer = '';

  @override
  void initState() {
    super.initState();
    // Initialize main animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Scale animation for the expanding effect
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    // Opacity animation for smooth transitions
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Goal Animation Controller
    _goalAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Goal animations - slide from left to center to right
    _goalSlideAnimation = TweenSequence<Offset>([
      // Move from left to center (0.0, 0) over first 40% of duration
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(-1.5, 0),
          end: const Offset(0.0, 0),
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      // Stay in center (pause) for ~1 second
      TweenSequenceItem(
        tween: ConstantTween<Offset>(const Offset(0.0, 0)),
        weight: 200, // This controls pause duration
      ),
      // Move from center to right
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0.0, 0),
          end: const Offset(1.5, 0),
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 40,
      ),
    ]).animate(CurvedAnimation(
      parent: _goalAnimationController,
      curve: Curves.easeInOut,
    ));

    // Goal scale animation - grows then shrinks
    _goalScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.5),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.5, end: 1.2),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 0.0),
        weight: 30,
      ),
    ]).animate(_goalAnimationController);

    // Goal opacity animation
    _goalOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: 20,
      ),
    ]).animate(_goalAnimationController);

    // Goal rotation animation for extra flair
    _goalRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5, // Half rotation
    ).animate(CurvedAnimation(
      parent: _goalAnimationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _goalAnimationController.dispose();
    super.dispose();
  }

  // Track which side is expanded (0 = none, 1 = madrid, 2 = barca)
  int _expandedSide = 0;
  int barcaScore = 0;
  int madridScore = 0;

  void _triggerGoalAnimation(String playerName) {
    setState(() {
      _showGoalText = true;
      _goalScorer = playerName;
    });

    _goalAnimationController.forward().then((_) {
      setState(() {
        _showGoalText = false;
      });
      _goalAnimationController.reset();
    });
  }

  void _onMadridTap() {
    setState(() {
      _expandedSide = _expandedSide == 1 ? 0 : 1;
      madridScore++;
    });
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    // Trigger goal animation
    _triggerGoalAnimation('Kylian Mbappe');
  }

  void _onBarcaTap() {
    setState(() {
      _expandedSide = _expandedSide == 2 ? 0 : 2;
      barcaScore++;
    });
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    // Trigger goal animation
    _triggerGoalAnimation('Lamine Yamal');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.myBlack,
      appBar: const ThemeAppBar(),
      body: Stack(
        children: [
          Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ThemeLigaTimer(madridScore: madridScore, barcaScore: barcaScore),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Row(
                    spacing: 10,
                    children: [
                      // Madrid Container
                      Expanded(
                        flex: _expandedSide == 1
                            ? 3
                            : (_expandedSide == 2 ? 1 : 2),
                        child: GestureDetector(
                          onTap: _onMadridTap,
                          child: Transform.scale(
                            scale: _expandedSide == 1
                                ? _scaleAnimation.value
                                : 1.0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.elasticOut,
                              decoration: BoxDecoration(
                                color: ThemeColors.myWhite,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(35),
                                  bottomRight: Radius.circular(35),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: _expandedSide == 1
                                        ? Colors.white54
                                        : Colors.black54,
                                    blurRadius: _expandedSide == 1 ? 15 : 8,
                                    offset:
                                        Offset(0, _expandedSide == 1 ? 6 : 4),
                                    spreadRadius: _expandedSide == 1 ? 2 : 0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  spacing: 5,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Player name - animate opacity
                                    AnimatedOpacity(
                                      opacity: _expandedSide == 1 ? 1.0 : 0.0,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: _expandedSide != 1
                                          ? const SizedBox.shrink()
                                          : Flexible(
                                              child: FittedBox(
                                                child: Text(
                                                  'Kylian Mbappe',
                                                  style: TextStyle(
                                                    color: ThemeColors.myBlack,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                    // Jersey number - animate scale
                                    AnimatedScale(
                                      scale: _expandedSide == 1 ? 1.2 : 1.0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Text(
                                        "10",
                                        style: TextStyle(
                                          color: ThemeColors.myBlack,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                    // Player image - animate with bounce
                                    AnimatedScale(
                                      scale: _expandedSide == 1 ? 1.1 : 1.0,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.bounceOut,
                                      child: Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ThemeColors.myWhite,
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/playersPics/madrid/mbappe.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Barcelona Container
                      Expanded(
                        flex: _expandedSide == 2
                            ? 3
                            : (_expandedSide == 1 ? 1 : 2),
                        child: GestureDetector(
                          onTap: _onBarcaTap,
                          child: Transform.scale(
                            scale: _expandedSide == 2
                                ? _scaleAnimation.value
                                : 1.0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.elasticOut,
                              decoration: BoxDecoration(
                                color: ThemeColors.myRed,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  bottomLeft: Radius.circular(35),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: _expandedSide == 2
                                        ? ThemeColors.myRed.withOpacity(.5)
                                        : Colors.black54,
                                    blurRadius: _expandedSide == 2 ? 15 : 8,
                                    offset:
                                        Offset(0, _expandedSide == 2 ? 6 : 4),
                                    spreadRadius: _expandedSide == 2 ? 2 : 0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  spacing: 5,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Player image - animate with bounce
                                    AnimatedScale(
                                      scale: _expandedSide == 2 ? 1.1 : 1.0,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.bounceOut,
                                      child: Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ThemeColors.myRed,
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/playersPics/barca/yamal.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Jersey number - animate scale
                                    AnimatedScale(
                                      scale: _expandedSide == 2 ? 1.2 : 1.0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Text(
                                        "10",
                                        style: TextStyle(
                                          color: ThemeColors.myWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                    // Player name - animate opacity
                                    AnimatedOpacity(
                                      opacity: _expandedSide == 2 ? 1.0 : 0.0,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: _expandedSide != 2
                                          ? const SizedBox.shrink()
                                          : Flexible(
                                              child: FittedBox(
                                                child: Text(
                                                  'Lamine Yamal',
                                                  style: TextStyle(
                                                    color: ThemeColors.myWhite,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),

          // GOAL Animation Overlay
          if (_showGoalText)
            Center(
              child: AnimatedBuilder(
                animation: _goalAnimationController,
                builder: (context, child) {
                  return SlideTransition(
                    position: _goalSlideAnimation,
                    child: Transform.scale(
                      scale: _goalScaleAnimation.value,
                      child: Transform.rotate(
                        angle: _goalRotationAnimation.value,
                        child: Opacity(
                          opacity: _goalOpacityAnimation.value,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  _goalScorer == 'Kylian Mbappe'
                                      ? ThemeColors.myWhite
                                      : ThemeColors.myRed,
                                  _goalScorer == 'Kylian Mbappe'
                                      ? ThemeColors.myWhite
                                      : ThemeColors.myRed,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'GOOOOAAL!!!',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: _goalScorer == 'Kylian Mbappe'
                                        ? ThemeColors.myBlack
                                        : ThemeColors.myWhite,
                                    shadows: [
                                      Shadow(
                                        offset: const Offset(3, 3),
                                        blurRadius: 6,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  _goalScorer,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: _goalScorer == 'Kylian Mbappe'
                                        ? ThemeColors.myBlack
                                        : Colors.white,
                                    shadows: [
                                      Shadow(
                                        offset: const Offset(2, 2),
                                        blurRadius: 4,
                                        color: Colors.black45,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
