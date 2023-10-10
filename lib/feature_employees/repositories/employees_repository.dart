import '../../base/common_mappers/error_mappers/error_mapper.dart';
import '../data_source/employees_data_source.dart';
import '../models/employees_pair.dart';

class EmployeesRepository {
  EmployeesRepository({required this.dataSource, required this.errorMapper});

  final EmployeesDataSource dataSource;
  final ErrorMapper errorMapper;

  Future<EmployeesPair> fetchData() async {
    return errorMapper.execute(() async => dataSource.getEmployeesPair());
  }
}
