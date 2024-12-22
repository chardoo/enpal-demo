import 'package:enpal/data/models/monitoring_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GrapheWidget extends StatelessWidget {
  final List<MonitoringData> data;
  final double totalEnergy;
  final String eneryType;
  final String units;

  const GrapheWidget({
    super.key,
    required this.data,
    required this.totalEnergy,
    required this.eneryType,
    required this.units,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(eneryType),
                Text('$totalEnergy $units'),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                      300, 
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(
                  // Bottom Titles (X-axis)
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index % 4 == 0 && index < data.length) {
                          final dateTime = data[index].timestamp;
                          return Text(
                            "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}",
                          );
                        }
                        return const SizedBox();
                      },
                      reservedSize: 20,
                    ),
                  ),
                  // Left Titles (Y-axis) - Custom titles to display full numbers
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(), 
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
            
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
               
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    left: BorderSide(color: Colors.black), 
                    bottom: BorderSide(color: Colors.black), 
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: data.asMap().entries.map((entry) {
                      return FlSpot(
                        entry.key.toDouble(),
                        entry.value.value.toDouble(),
                      );
                    }).toList(),
                    isCurved: true,
                    color: Colors.blue,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.blue.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
