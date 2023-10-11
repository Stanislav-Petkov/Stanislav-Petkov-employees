import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

import '../../base/models/errors/error_model.dart';
import '../models/employee_project.dart';
import '../models/employees_pair.dart';

class EmployeesDataSource {
  Future<EmployeesPair> getEmployeesPair() async {
    final fileContent = await _pickCSVFile();
    final listOfEmployeeProjects = await _parseCSV(fileContent);
    final allCouplesWorkingTogether =
        _findDaysWorkedTogetherNew(listOfEmployeeProjects);

    final longestWorkingCouple =
        _calculateLongestWorkingCouple(allCouplesWorkingTogether);
    return longestWorkingCouple;
  }

  Future<String> _pickCSVFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        return await file.readAsString();
      } else {
        // Handle the case when no file is selected
        throw NoFileSelectedErrorModel();
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<List<EmployeeProject>> _parseCSV(String fileContent) async {
    // Read from local file in the app
    // final String csvString = await rootBundle.loadString('assets/values.csv');
    final List<List<dynamic>> csvTable =
        const CsvToListConverter().convert(fileContent);

    final employeeProjects = csvTable.map((row) {
      final empID = row[0];
      final projectID = row[1];
      final dateFrom = parseDate(row[2]);
      final dateTo = row[3] == 'NULL' ? DateTime.now() : parseDate(row[3]);

      return EmployeeProject(
        employeeID: empID,
        projectID: projectID,
        dateFrom: dateFrom,
        dateTo: dateTo,
      );
    }).toList();

    return employeeProjects;
  }

  DateTime parseDate(String dateString) {
    DateTime? result;
    // yyyy-MM-dd format pattern
    const patternDay = r'\d{2}-\d{2}-\d{4}';
    // regex to match yyyy-MM-dd
    const patternYear = r'^\d{4}-\d{2}-\d{2}$';
    // MM/dd/yyyy
    const patternMonth = r'^\d{2}/\d{2}/\d{4}$';

    if (_matchesPattern(dateString, patternDay)) {
      result = DateFormat('dd-MM-yyyy').parse(dateString);
    } else if (_matchesPattern(dateString, patternYear)) {
      result = DateFormat('yyyy-MM-dd').parse(dateString);
    } else if (_matchesPattern(dateString, patternMonth)) {
      result = DateFormat('MM/dd/yyyy').parse(dateString);
    } else {
      throw FormatException('Date format not recognized: $dateString');
    }

    return result;
  }

  bool _matchesPattern(String input, String pattern) {
    final regex = RegExp(pattern);
    return regex.hasMatch(input);
  }

  Map<String, Map<int, int>> _findDaysWorkedTogetherNew(
      List<EmployeeProject> data) {
    final pairs = <String, Map<int, int>>{};

    for (int first = 0; first < data.length; first++) {
      for (int second = first + 1; second < data.length; second++) {
        if (data[first].projectID == data[second].projectID) {
          final dateFrom1 = data[first].dateFrom;
          final dateTo1 = data[first].dateTo;
          final dateFrom2 = data[second].dateFrom;
          final dateTo2 = data[second].dateTo;

          // Calculate the overlap between date ranges
          final overlapStart =
              dateFrom1.isBefore(dateFrom2) ? dateFrom2 : dateFrom1;
          final overlapEnd = dateTo1.isBefore(dateTo2) ? dateTo1 : dateTo2;

          if (overlapStart.isBefore(overlapEnd)) {
            // Calculate the number of days worked together
            final daysWorked = overlapEnd.difference(overlapStart).inDays;

            final pairKey =
                '${data[first].employeeID}-${data[second].employeeID}';
            final projectID = data[first].projectID;

            pairs.putIfAbsent(pairKey, () => {});
            pairs[pairKey]!.update(
              projectID,
              (value) => value + daysWorked,
              ifAbsent: () => daysWorked,
            );
          }
        }
      }
    }

    return pairs;
  }

  EmployeesPair _calculateLongestWorkingCouple(
      Map<String, Map<int, int>> allCouplesWorkingTogether) {
    String? maxCouple;
    int? maxDaysWorked;
    int? projectId;
    String? firstEmployeeId;
    String? secondEmployeeId;
    for (final couple in allCouplesWorkingTogether.keys) {
      final daysWorked =
          allCouplesWorkingTogether[couple]!.values.reduce((a, b) => a + b);
      if (couple == allCouplesWorkingTogether.keys.first) {
        maxCouple = couple;
        maxDaysWorked = daysWorked;
      }

      if (daysWorked > maxDaysWorked!) {
        maxDaysWorked = daysWorked;
        maxCouple = couple;
        firstEmployeeId = maxCouple.split('-')[0];
        secondEmployeeId = maxCouple.split('-')[1];
        projectId = allCouplesWorkingTogether[couple]!.keys.first;
      }
    }

    return EmployeesPair(
      firstEmployeeId: firstEmployeeId!,
      secondEmployeeId: secondEmployeeId!,
      projectId: projectId!,
      daysWorkedTogether: maxDaysWorked!,
    );
  }
}
