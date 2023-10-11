import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

import '../models/employee_project.dart';
import '../models/employees_pair.dart';

class EmployeesDataSource {
  Future<String> pickAndReadCSVFile() async {
    try {
      // Open the file picker dialog
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'], // Specify the allowed file extensions
      );

      if (result != null) {
        File file = File(result.files.single.path!);

        // Read the content of the selected CSV file as a string
        String fileContent = await file.readAsString();

        // Do something with the file content (e.g., parse or display)
        return fileContent;
      } else {
        // Handle the case when no file is selected
        return 'No file selected';
      }
    } catch (e) {
      // Handle any potential exceptions (e.g., file not found, permission issues)
      return 'Error picking or reading file: $e';
    }
  }

  Future<List<EmployeeProject>> parseCSV(String fileContent) async {
    // read from local file in the app
    // final String csvString = await rootBundle.loadString('assets/values1.csv');
    // print('2: $csvString');
    final List<List<dynamic>> csvTable =
        const CsvToListConverter().convert(fileContent);

    final employeeProjects = csvTable.map((row) {
      final empID = row[0];
      final projectID = row[1];
      final dateFrom = DateTime.parse(row[2]);
      final dateTo = row[3] == 'NULL' ? DateTime.now() : DateTime.parse(row[3]);

      return EmployeeProject(
        employeeID: empID,
        projectID: projectID,
        dateFrom: dateFrom,
        dateTo: dateTo,
      );
    }).toList();

    return employeeProjects;
  }

  Map<String, Map<int, int>> findDaysWorkedTogetherNew(
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

  EmployeesPair calculateLongestWorkingCouple(
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
        daysWorkedTogether: maxDaysWorked!);
  }

  Future<EmployeesPair> getEmployeesPair() async {
    final fileContext = await pickAndReadCSVFile();
    print('1: $fileContext');

    final listOfEmployeeProjects = await parseCSV(fileContext);
    final allCouplesWorkingTogether =
        findDaysWorkedTogetherNew(listOfEmployeeProjects);

    final longestWorkingCouple =
        calculateLongestWorkingCouple(allCouplesWorkingTogether);

    return longestWorkingCouple;
  }
}
