import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../blocs/employees_bloc.dart';
import '../data_source/employees_data_source.dart';
import '../repositories/employees_repository.dart';
import '../views/employees_page.dart';

class MoviePageWithDependencies extends StatelessWidget {
  const MoviePageWithDependencies({
    Key? key,
  }) : super(key: key);

  List<Provider> get _dataSources => [
        Provider<EmployeesDataSource>(
          create: (context) => EmployeesDataSource(),
        ),
      ];

  List<Provider> get _repositories => [
        Provider<EmployeesRepository>(
          create: (context) => EmployeesRepository(
            dataSource: context.read(),
            errorMapper: context.read(),
          ),
        ),
      ];

  List<RxBlocProvider> get _blocs => [
        RxBlocProvider<EmployeesBlocType>(
          create: (context) => EmployeesBloc(
            repository: context.read(),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ..._dataSources,
          ..._repositories,
          ..._blocs,
        ],
        child: const EmployeesPage(),
      );
}
