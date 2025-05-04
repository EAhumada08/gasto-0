import 'package:flutter/material.dart';

class _Row {
  final String cellA;
  final String cellB;
  final String cellC;
  final String cellD;

  _Row(this.cellA, this.cellB, this.cellC, this.cellD);

  bool selected = false;
}

class DataSource extends DataTableSource {
  final BuildContext context;
  late List<_Row> rows;

  int _selectedCount = 0;

  DataSource(this.context) {
    rows = [
      _Row('Fruta', '\$ 100', 'Comida', '02-05-2025'),
      _Row('Pasaje', '\$ 50', 'Transporte', '02-05-2025'),
      _Row('Pago de luz', '\$ 10000', 'Hogar', '01-01-2025'),
      _Row('Despensa', '\$ 2000', 'Hogar', '-02-05-2025'),
    ];
  }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= rows.length) return null!;
    final row = rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.cellA)),
        DataCell(Text(row.cellB)),
        DataCell(Text(row.cellC)),
        DataCell(Text(row.cellD)),
      ],
    );
  }

  @override
  int get rowCount => rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
