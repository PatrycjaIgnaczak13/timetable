import 'package:flutter/widgets.dart';
import 'package:time_machine/time_machine.dart' hide Offset;

import '../controller.dart';
import '../event.dart';
import '../utils/utils.dart';

class MultiHourBackgroundPainter<E extends Event> extends CustomPainter {
  MultiHourBackgroundPainter({
    @required this.controller,
    @required Color dividerColor,
  })  : assert(controller != null),
        assert(dividerColor != null),
        dividerPaint = Paint()..color = dividerColor,
        super(repaint: controller.scrollControllers.pageListenable);

  final TimetableController<E> controller;
  final Paint dividerPaint;

  @override
  void paint(Canvas canvas, Size size) {
    _drawHourDividers(canvas, size);
  }

  void _drawHourDividers(Canvas canvas, Size size) {
    final heightPerHour = size.height / TimeConstants.hoursPerDay;
    for (final h in innerDateHours) {
      final y = h * heightPerHour;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), dividerPaint);
    }
  }

  @override
  bool shouldRepaint(MultiHourBackgroundPainter oldDelegate) =>
      dividerPaint.color != oldDelegate.dividerPaint.color;
}
