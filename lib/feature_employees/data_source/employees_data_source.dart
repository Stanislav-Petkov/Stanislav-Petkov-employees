import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

import '../models/employee_project.dart';
import '../models/employees_pair.dart';

class EmployeesDataSource {
  //Add repository dependencies as needed
  EmployeesDataSource();

//
  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Some specific async state from EmployeesService';
  }

  Future<List<EmployeeProject>> parseCSV(String filePath) async {
    final input = File(filePath).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();

    final employeeProjects = fields.map((row) {
      final empID = int.parse(row[0]);
      final projectID = int.parse(row[1]);
      final dateFrom = DateTime.parse(row[2]);
      final dateTo = row[3] == 'NULL' ? DateTime.now() : DateTime.parse(row[3]);

      return EmployeeProject(empID, projectID, dateFrom, dateTo);
    }).toList();

    return employeeProjects;
  }

  Map<String, int> findLongestWorkingPair(List<EmployeeProject> data) {
    final pairs = <String, int>{};

    for (int i = 0; i < data.length; i++) {
      for (int j = i + 1; j < data.length; j++) {
        if (data[i].projectID == data[j].projectID) {
          final daysWorked =
              data[i].dateTo.difference(data[i].dateFrom).inDays +
                  data[j].dateTo.difference(data[j].dateFrom).inDays;

          final pairKey = '${data[i].empID}-${data[j].empID}';

          if (!pairs.containsKey(pairKey) || pairs[pairKey]! < daysWorked) {
            pairs[pairKey] = daysWorked;
          }
        }
      }
    }

    return pairs;
  }

  EmployeesPair getEmployeesPair() {
    return EmployeesPair(
        firstEmployeeId: 1,
        secondEmployeeId: 2,
        projectId: 3,
        daysWorkedTogether: 4);
  }
}
