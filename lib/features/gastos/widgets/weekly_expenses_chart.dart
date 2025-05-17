import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gasto_0/Models/expense.dart';
import 'package:intl/intl.dart';

class WeeklyExpensesChart extends StatefulWidget {
  final List<Expense> expenses;

  const WeeklyExpensesChart({super.key, required this.expenses});

  @override
  State<WeeklyExpensesChart> createState() => _WeeklyExpensesChartState();
}

class _WeeklyExpensesChartState extends State<WeeklyExpensesChart> {
  DateTimeRange selectedWeek = _getCurrentWeek();

  static DateTimeRange _getCurrentWeek() {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: now.weekday - 1));
    return DateTimeRange(
        start: DateTime(start.year, start.month, start.day),
        end: start.add(const Duration(days: 6)));
  }

  @override
  Widget build(BuildContext context) {
    final weeklyExpenses = widget.expenses
        .where((expense) =>
            (expense.date.isAfter(selectedWeek.start) ||
                expense.date.isAtSameMomentAs(selectedWeek.start)) &&
            (expense.date.isBefore(selectedWeek.end) ||
                expense.date.isAtSameMomentAs(selectedWeek.end)))
        .toList();

    List<DateTime> weeklyDates = [];
    for (int i = 0; i < 7; i++) {
      weeklyDates.add(DateTime(selectedWeek.start.year,
          selectedWeek.start.month, selectedWeek.start.day + i));
    }

    final dailyData = _processExpensesByDay(weeklyExpenses, weeklyDates);

    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () => _changeWeek(-1),
                    icon: const Icon(Icons.chevron_left)),
                Text('${DateFormat('dd/MM').format(selectedWeek.start)}-'
                    '${DateFormat('dd/MM').format(selectedWeek.end)}'),
                IconButton(
                    onPressed: () => _changeWeek(1),
                    icon: Icon(Icons.chevron_right)),
              ],
            ),
            Expanded(
              child: BarChart(BarChartData(
                  maxY: _calculateMaxY(dailyData),
                  barGroups: _buildBarGroups(dailyData),
                  titlesData: _buildTitlesData(),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false))),
            )
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(Map<DateTime, double> dailyData) {
    final sortedDates = dailyData.keys.toList()..sort();

    return List.generate(sortedDates.length, (index) {
      final date = sortedDates[index];
      final amount = dailyData[date]!;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: amount,
            color: Colors.blue,
            width: 20,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      );
    });
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      show: true,
      topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false, reservedSize: 0)),
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              getTitlesWidget: bottomTitles,
              showTitles: true,
              reservedSize: 40)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true, getTitlesWidget: leftTitles, reservedSize: 50)),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    final Widget text = Text(
      '\$${value.toInt()}',
      style: const TextStyle(
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      meta: meta,
      space: 8,
      child: text,
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab', 'Dom'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
    return SideTitleWidget(
      meta: meta,
      space: 5,
      child: text,
    );
  }

  double _calculateMaxY(Map<DateTime, double> dailyData) {
    double maxY = 0;
    for (var value in dailyData.values) {
      if (value > maxY) {
        maxY = value;
      }
    }
    return maxY + 100;
  }

  Map<DateTime, double> _processExpensesByDay(
      List<Expense> expenses, List<DateTime> weeklyDates) {
    final dailyExpenses = <DateTime, double>{};

    for (var expense in expenses) {
      final date = DateTime(
        expense.date.year,
        expense.date.month,
        expense.date.day,
      );

      dailyExpenses.update(
        date,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    for (var date in weeklyDates) {
      dailyExpenses.putIfAbsent(date, () => 0);
    }
    return dailyExpenses;
  }

  void _changeWeek(int delta) {
    setState(() {
      final duration = Duration(days: 7);
      if (delta < 0) {
        selectedWeek = DateTimeRange(
            start: selectedWeek.start.subtract(duration),
            end: selectedWeek.end.subtract(duration));
      } else {
        selectedWeek = DateTimeRange(
            start: selectedWeek.start.add(duration),
            end: selectedWeek.end.add(duration));
      }
    });
  }
}
