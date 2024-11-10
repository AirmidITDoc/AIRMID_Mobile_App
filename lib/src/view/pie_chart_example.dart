// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class PieChartSample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: PieChart(
//         PieChartData(
//           sectionsSpace: 0,
//           centerSpaceRadius: 40,
//           sections: showingSections(),
//           borderData: FlBorderData(
//             show: false,
//           ),
//           pieTouchData: PieTouchData(
//             touchCallback: (FlTouchEvent event, pieTouchResponse) {
//               // Handle touch events here if needed
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   List<PieChartSectionData> showingSections() {
//     return List.generate(4, (i) {
//       final isTouched = false;
//       final double fontSize = isTouched ? 25 : 16;
//       final double radius = isTouched ? 60 : 50;
//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color: Colors.green,
//             value: 0,
//             title: '45%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 1:
//           return PieChartSectionData(
//             color: Colors.blue,
//             value: 1,
//             title: '25%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 2:
//           return PieChartSectionData(
//             color: Colors.orange,
//             value: 30,
//             title: '30%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 3:
//           return PieChartSectionData(
//             color: Colors.red,
//             value: 50,
//             title: '50%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         default:
//           throw Error();
//       }
//     });
//   }
// }

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample extends StatelessWidget {
  final List<PieChartSectionData> sections = showingSections();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Stack(
        children: [
          Center(
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: sections,
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
          CustomPaint(
            painter: LinePainter(sections: sections),
            child: Container(),
          ),
        ],
      ),
    );
  }

  static List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: 10,
        title: '10',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: 10,
        title: '10',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 10,
        title: '10',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 50,
        title: '50%',
        radius: 50,
      ),
    ];
  }
}

class LinePainter extends CustomPainter {
  final List<PieChartSectionData> sections;

  LinePainter({required this.sections});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final center = Offset(size.width / 2, size.height / 2);
    final radius = 50.0;
    final double total = sections.fold(0, (sum, item) => sum + item.value);

    double startAngle = -3.14 / 2; // Start from the top

    for (final section in sections) {
      final sweepAngle = (section.value / total) * 2 * 3.14;
      final endAngle = startAngle + sweepAngle;

      final angle = startAngle + sweepAngle / 2;
      final x = center.dx + radius * 1.5 * cos(angle);
      final y = center.dy + radius * 1.5 * sin(angle);
      final position = Offset(x, y);

      final labelPosition = Offset(
        center.dx + (radius + 20) * cos(angle),
        center.dy + (radius + 20) * sin(angle),
      );

      canvas.drawLine(center + Offset(radius * cos(angle), radius * sin(angle)),
          position, paint);

      textPainter.text = TextSpan(
        text: section.title,
        style: TextStyle(color: section.color, fontSize: 14),
      );
      textPainter.layout();
      textPainter.paint(
          canvas,
          labelPosition -
              Offset(textPainter.width / 2, textPainter.height / 2));

      startAngle = endAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
