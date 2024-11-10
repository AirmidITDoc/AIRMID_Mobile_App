import 'package:airmid/src/model/hospital_summry/parmasy_dashboard_summry.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartJsBarChart extends StatelessWidget {
  final HospitalPharmacySummry? hospitalSummryData;

  const ChartJsBarChart({Key? key, this.hospitalSummryData});
  final double width = 20;
  static const Color chartJsBarChart = Color(0xff37a499);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData(context),
        titlesData: titlesData,
        borderData: FlBorderData(show: false),
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: (hospitalSummryData?.cashPay == 0.0 ||
                    hospitalSummryData?.cashPay == null) &&
                (hospitalSummryData?.chequePay == null ||
                    hospitalSummryData?.chequePay == 0.0) &&
                (hospitalSummryData?.onlinePay == null ||
                    hospitalSummryData?.onlinePay == 0.0)
            ? 10
            : null,
      ),
    );
  }

  BarTouchData barTouchData(BuildContext context) {
    return BarTouchData(
      enabled: true,
      touchTooltipData: BarTouchTooltipData(
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          return BarTooltipItem(
            rod.toY.toString(),
            const TextStyle(
              color: Color(0xFFE9ECEF),
              fontWeight: FontWeight.w700,
            ),
          );
        },
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String? text;
    switch (value.toInt()) {
      case 0:
        text = 'Cash';
        break;
      case 1:
        text = 'Cheque';
        break;
      case 2:
        text = 'Online';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(text ?? "", style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            // interval: _getMaxDataValue() / 4,
            getTitlesWidget: leftTitles,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(value.toInt().toString(), style: style),
    );
  }

  BarChartRodData _barChartRodData({
    required double toY,
  }) {
    return BarChartRodData(
      width: width,
      toY: toY,
      color: chartJsBarChart,
      borderRadius: BorderRadius.zero,
    );
  }

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            _barChartRodData(toY: hospitalSummryData?.cashPay ?? 0),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            _barChartRodData(toY: hospitalSummryData?.chequePay ?? 0),
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            _barChartRodData(toY: hospitalSummryData?.onlinePay ?? 0),
          ],
        ),
      ];
}
