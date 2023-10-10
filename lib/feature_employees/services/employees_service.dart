class EmployeesService {
  //Add repository dependencies as needed
  EmployeesService();

  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Some specific async state from EmployeesService';
  }
}
