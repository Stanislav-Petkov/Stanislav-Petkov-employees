//A data structure to represent the input data entry in the CSV file.
class EmployeeProject {
  EmployeeProject({
    required this.employeeID,
    required this.projectID,
    required this.dateFrom,
    required this.dateTo,
  });

// todo dateTo can be null
  final int employeeID;
  final int projectID;
  final DateTime dateFrom;
  final DateTime dateTo;
}
