import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_screen_project/bloc/income_chart/income_cubit.dart';
import 'package:new_screen_project/data/income_data.dart';

class CustomSlider extends StatelessWidget {
  final Function(double)? onChange;
  const CustomSlider({super.key, this.onChange});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: Color(0xFF3E62EC),
        inactiveTrackColor: Color(0xFFA8A8A8),
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
        thumbShape: DualCircleThumbShape(
          outerColor: Color(0xFF3E62EC),
          innerColor: Colors.white,
        ),
      ),
      child: BlocBuilder<IncomeCubit, IncomeState>(
        builder: (context, state) {
          return Slider(
            value: state.slideValue,
            min: 0,
            max: dummyIncomeData.length.toDouble() - 5,
            divisions: dummyIncomeData.length - 5,
            onChanged: onChange,
          );
        },
      ),
    );
  }
}

_buildThumbShape(center, cornerRadius, width, height) {
  return RRect.fromRectXY(
    Rect.fromCenter(
        center: Offset(center.dx - 5, center.dy), width: width, height: height),
    cornerRadius,
    cornerRadius,
  );
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
    return Size.fromRadius(10);
  }

  @override
  void paint(PaintingContext context,
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
    final Canvas canvas = context.canvas;

    final Paint outerPaint = Paint()
      ..color = outerColor
      ..style = PaintingStyle.fill;

    final Paint innerPaint = Paint()
      ..color = innerColor
      ..style = PaintingStyle.fill;

    const cornerRadius = 10.0;

    canvas.drawRRect(
      RRect.fromRectXY(
        Rect.fromCenter(center: center, width: 30, height: 20),
        cornerRadius,
        cornerRadius,
      ),
      outerPaint,
    );
    canvas.drawRRect(
      RRect.fromRectXY(
        Rect.fromCenter(center: center, width: 3, height: 12),
        cornerRadius,
        cornerRadius,
      ),
      innerPaint,
    );
    canvas.drawRRect(
      RRect.fromRectXY(
        Rect.fromCenter(
            center: Offset(center.dx - 5, center.dy), width: 3, height: 12),
        cornerRadius,
        cornerRadius,
      ),
      innerPaint,
    );
    canvas.drawRRect(
      RRect.fromRectXY(
        Rect.fromCenter(
            center: Offset(center.dx + 5, center.dy), width: 3, height: 12),
        cornerRadius,
        cornerRadius,
      ),
      innerPaint,
    );
  }
}
