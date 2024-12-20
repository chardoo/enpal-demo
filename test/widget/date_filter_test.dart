import 'package:enpal/presentation/widget/common/date_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('DateFilter Widget Tests', () {
    late String selectedDate;

    setUp(() {
      selectedDate = todayDateFormat();
    });

    testWidgets('displays the initial date correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DateFilter(
              onDateSelected: (date) => selectedDate = date,
              initialDate: '2024-12-16',
            ),
          ),
        ),
      );

      expect(find.text('2024-12-16'), findsOneWidget);
    });

    testWidgets('navigates to the previous date when the previous button is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DateFilter(
              onDateSelected: (date) => selectedDate = date,
              initialDate: '2024-12-16',
            ),
          ),
        ),
      );

 
      await tester.tap(find.byIcon(Icons.navigate_before));
      await tester.pump();


      expect(find.text('2024-12-15'), findsOneWidget);
      expect(selectedDate, '2024-12-15');
    });

    testWidgets('navigates to the next date when the next button is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DateFilter(
              onDateSelected: (date) => selectedDate = date,
              initialDate: '2024-12-16',
            ),
          ),
        ),
      );


      await tester.tap(find.byIcon(Icons.navigate_next));
      await tester.pump();

     
      expect(find.text('2024-12-17'), findsOneWidget);
      expect(selectedDate, '2024-12-17');
    });

    testWidgets('shows date picker when the date text is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DateFilter(
              onDateSelected: (date) => selectedDate = date,
              initialDate: '2024-12-16',
            ),
          ),
        ),
      );

  
      await tester.tap(find.text('2024-12-16'));
      await tester.pumpAndSettle();

  
      await tester.tap(find.text('20')); 
      await tester.pumpAndSettle();


      expect(selectedDate, '2024-12-20');
    });

    testWidgets('disables the next button when the selected date is today', (WidgetTester tester) async {
      final today = todayDateFormat();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DateFilter(
              onDateSelected: (date) => selectedDate = date,
              initialDate: today,
            ),
          ),
        ),
      );

      final nextButton = tester.widget<IconButton>(find.byIcon(Icons.navigate_next));
      expect(nextButton.onPressed, isNull);
    });
  });
}


String todayDateFormat() {
  return DateFormat('yyyy-MM-dd').format(DateTime.now());
}
