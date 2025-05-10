import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaligaController extends GetxController {
  RxInt barcaScore = 0.obs;
  RxInt realScore = 0.obs;
  late AnimationController controller;
  late TickerProvider vsync;
  LaligaController({required TickerProvider vsync}) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 3),
      reverseDuration: const Duration(milliseconds: 2300),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward(); // Start the animation
  }

  void setVsync(TickerProvider tickerProvider) {
    vsync = tickerProvider;
  }

  void updateBarcaScore() {
    barcaScore++;
  }

  void updateRealScore() {
    realScore++;
  }

  void decreaseBarcaScore() {
    if (barcaScore.value == 0.obs) {
      barcaScore;
    }
    barcaScore--;
  }

  void decreaseRealScore() {
    if (realScore.value == 0.obs) {
      realScore;
    }
    realScore--;
  }

  @override
  void onClose() {
    controller.dispose(); // Dispose of the controller to avoid memory leaks
    super.onClose();
  }
}
