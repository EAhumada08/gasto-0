import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gasto_0/Models/expense.dart';
import 'package:gasto_0/features/gastos/widgets/weekly_expenses_chart.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Estadísticas'),
        ),
        body: Center(
          child: WeeklyExpensesChart(expenses: <Expense>[
            Expense(
                descpription: 'Gasto',
                amount: 1500,
                category: 'Gasto',
                date: DateTime(2025, 5, 15)),
            Expense(
                descpription: 'Gasto',
                amount: 500,
                category: 'Gasto',
                date: DateTime(2025, 5, 12)),
            Expense(
                descpription: 'Gasto',
                amount: 100,
                category: 'Gasto',
                date: DateTime(2025, 5, 18))
          ]),
        ));
  }
}
