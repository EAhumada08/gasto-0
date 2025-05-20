import 'package:flutter/material.dart';
import 'package:gasto_0/Models/expense.dart';
import 'package:gasto_0/features/gastos/widgets/weekly_expenses_chart.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    Color containerBcBackgroundColor = Color.fromARGB(255, 25, 25, 25);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Estadísticas'),
        ),
        body: Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: containerBcBackgroundColor,
              border: Border.all(color: containerBcBackgroundColor),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(14.0),
          child: WeeklyExpensesChart(expenses: <Expense>[
            Expense(
                descpription: 'Gasto',
                amount: 2500,
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
                date: DateTime(2025, 5, 18)),
            Expense(
                descpription: 'Gasto',
                amount: 100,
                category: 'Gasto',
                date: DateTime(2025, 5, 11))
          ]),
        ));
  }
}
