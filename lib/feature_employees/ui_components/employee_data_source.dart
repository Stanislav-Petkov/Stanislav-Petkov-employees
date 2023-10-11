import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../models/employees_pair.dart';

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<EmployeesPair> employees}) {
    _employees = employees
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'firstEmployeeId', value: e.firstEmployeeId),
              DataGridCell<String>(
                  columnName: 'secondEmployeeId', value: e.secondEmployeeId),
              DataGridCell<int>(columnName: 'projectId', value: e.projectId),
              DataGridCell<int>(
                  columnName: 'daysWorkedTogether',
                  value: e.daysWorkedTogether),
            ]))
        .toList();
  }

  List<DataGridRow> _employees = [];

  @override
  List<DataGridRow> get rows => _employees;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
