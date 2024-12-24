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
              selectedDate: '2024-12-16', // Ensure initial date is passed correctly
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
              selectedDate: '2024-12-16',
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
              selectedDate: '2024-12-16',
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
              selectedDate: '2024-12-16', // Ensure the initial date is explicitly set
            ),
          ),
        ),
      );

      // Tap on the date text to open the date picker
      await tester.tap(find.text('2024-12-16'));
      await tester.pumpAndSettle();

      // Select a specific date (e.g., 20th day of the current month)
      await tester.tap(find.text('20')); // Adjust for your test environment's DatePicker behavior
      await tester.pumpAndSettle();

      // Verify the selected date was updated correctly
      expect(selectedDate, '2024-12-24');
    });

    testWidgets('disables the next button when the selected date is today', (WidgetTester tester) async {
      final today = todayDateFormat();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DateFilter(
              onDateSelected: (date) => selectedDate = date,
              selectedDate: today,
            ),
          ),
        ),
      );

      // Locate the next button and verify it's disabled
      final IconButton nextButton =
          tester.widget(find.byType(IconButton).at(1)); // Correctly locate IconButton
      expect(nextButton.onPressed, isNull);
    });
  });
}

String todayDateFormat() {
  return DateFormat('yyyy-MM-dd').format(DateTime.now());
}
