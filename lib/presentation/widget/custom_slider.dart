import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_screen_project/data/income_data.dart';

import '../bloc/income_chart/income_cubit.dart';

class CustomSlider extends StatelessWidget {
  final ValueChanged<double>? onChange;
  const CustomSlider({super.key, this.onChange});

  static const int _visibleItems = 5;

  @override
  Widget build(BuildContext context) {
    final int itemCount = dummyIncomeData.length;
    final double maxValue =
    (itemCount > _visibleItems) ? (itemCount - _visibleItems).toDouble() : 0.0;
    final int? divisions = (maxValue > 0) ? maxValue.toInt() : null;
    final bool enabled = maxValue > 0 && onChange != null;

    final sliderTheme = SliderTheme.of(context).copyWith(
      activeTrackColor: const Color(0xFF3E62EC),
      inactiveTrackColor: const Color(0xFFA8A8A8),
      activeTickMarkColor: Colors.transparent,
      inactiveTickMarkColor: Colors.transparent,
      thumbShape: DualCircleThumbShape(
        outerColor: const Color(0xFF3E62EC),
        innerColor: Colors.white,
      ),
    );

    return SliderTheme(
      data: sliderTheme,
      child: BlocSelector<IncomeCubit, IncomeState, double>(
        selector: (state) => state.slideValue,
        builder: (context, slideValue) {
          final double value = slideValue.clamp(0.0, maxValue);

          if (!enabled) {
            return Slider(
              value: 0.0,
              min: 0.0,
              max: (maxValue > 0) ? maxValue : 1.0,
              divisions: null,
              onChanged: null,
            );
          }
          return Slider(
            value: value,
            min: 0.0,
            max: maxValue,
            divisions: divisions,
            onChanged: onChange,
          );
        },
      ),
    );
  }
}

class DualCircleThumbShape extends SliderComponentShape {
  final Color outerColor;
  final Color innerColor;

  const DualCircleThumbShape({
    required this.outerColor,
    required this.innerColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(30, 20);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final canvas = context.canvas;

    final outerPaint = Paint()
      ..color = outerColor
      ..style = PaintingStyle.fill;

    final innerPaint = Paint()
      ..color = innerColor
      ..style = PaintingStyle.fill;

    const double outerW = 30.0;
    const double outerH = 20.0;
    const double innerW = 3.0;
    const double innerH = 12.0;
    const double innerOffset = 5.0;
    const double cornerRadius = 6.0;

    final outerRRect = RRect.fromRectXY(
      Rect.fromCenter(center: center, width: outerW, height: outerH),
      cornerRadius,
      cornerRadius,
    );
    canvas.drawRRect(outerRRect, outerPaint);

    for (final dx in [-innerOffset, 0.0, innerOffset]) {
      final innerCenter = Offset(center.dx + dx, center.dy);
      final innerRRect = RRect.fromRectXY(
        Rect.fromCenter(center: innerCenter, width: innerW, height: innerH),
        cornerRadius,
        cornerRadius,
      );
      canvas.drawRRect(innerRRect, innerPaint);
    }
  }
}
