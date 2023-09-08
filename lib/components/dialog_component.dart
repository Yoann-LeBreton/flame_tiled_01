import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class DialogComponent extends TextBoxComponent with HasGameRef {
  DialogComponent({required String dialog, required Vector2 position})
      : super(
          text: dialog,
          position: position,
          textRenderer: TextPaint(
              style: const TextStyle(fontSize: 18, color: Colors.black)),
          boxConfig: TextBoxConfig(
            dismissDelay: 3.0,
            timePerChar: 0.1,
          ),
        );

  @override
  void drawBackground(Canvas c) {
    Rect rect = Rect.fromLTWH(0, 0, width, height);
    c.drawRect(rect, Paint()..color = Colors.white70);
  }
}
