import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../models/employees_pair.dart';
import 'employee_data_source.dart';

class EmployeeDataGrid extends StatelessWidget {
   const EmployeeDataGrid({required this.employeesPair, super.key});

  final EmployeesPair employeesPair;
  // final p = EmployeesPair(
  //   firstEmployeeId: '1',
  //   secondEmployeeId: '1',
  //   projectId: 1,
  //   daysWorkedTogether: 2,
  // );

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
        headerRowHeight: 100,
      source: EmployeeDataSource(employees: [employeesPair]),
      columns: <GridColumn>[
        GridColumn(
            columnName: 'firstEmployeeId',
            label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.centerRight,
                child: const Text(
                  'Employee ID #1',
                ))),
        GridColumn(
            columnName: 'secondEmployeeId',
            label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: const Text('Employee ID #2'))),
        GridColumn(
            columnName: 'projectId',
            width: 120,
            label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: const Text('Project ID'))),
        GridColumn(
            columnName: 'daysWorkedTogether',
            label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.centerRight,
                child: const Text('Days worked'))),
      ],
    );
  }
}
