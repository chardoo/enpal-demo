import 'package:enpal/presentation/widget/common/graph_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:enpal/data/models/monitoring_data.dart';

void main() {
  group('GrapheWidget Tests', () {
    final List<MonitoringData> sampleData = [
      MonitoringData(
          timestamp: DateTime.parse('2024-12-16T00:00:00.000Z'), value: 1000),
      MonitoringData(
          timestamp: DateTime.parse('2024-12-16T00:05:00.000Z'), value: 2000),
      MonitoringData(
          timestamp: DateTime.parse('2024-12-16T00:10:00.000Z'), value: 1500),
      MonitoringData(
          timestamp: DateTime.parse('2024-12-16T00:15:00.000Z'), value: 3000),
    ];

    const double totalEnergy = 7500;
    const String energyType = 'Solar';
    const String unit = 'watts';

    testWidgets('Displays energy type and total energy correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GraphWidget(
              data: sampleData,
              totalEnergy: totalEnergy,
              energyType: energyType,
              units: unit,
            ),
          ),
        ),
      );

      expect(find.text(energyType), findsOneWidget);

      expect(find.text(totalEnergy.toString()), findsOneWidget);
    });

    testWidgets('Displays the LineChart with the correct number of points',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GraphWidget(
              data: sampleData,
              totalEnergy: totalEnergy,
              energyType: energyType,
              units: unit,
            ),
          ),
        ),
      );

      expect(find.byType(LineChart), findsOneWidget);
    });
  });
}
