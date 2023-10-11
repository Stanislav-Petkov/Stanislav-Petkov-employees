import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../../base/common_ui_components/app_error_modal_widget.dart';
import '../blocs/employees_bloc.dart';
import '../models/employees_pair.dart';
import '../ui_components/employee_data_grid.dart';

class EmployeesPage extends StatelessWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Employees'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              SizedBox(
                width: 220,
                child: FloatingActionButton.extended(
                  onPressed: () =>
                      context.read<EmployeesBlocType>().events.fetchData(),
                  label: const Text('Pick a csv file'),
                  icon: const Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 10,),
              RxBlocBuilder<EmployeesBlocType, EmployeesPair>(
                state: (bloc) => bloc.states.data,
                builder: (context, pair, bloc) {
                  if (pair.hasData) {
                    return EmployeeDataGrid(employeesPair: pair.data!);
                  }
                  return Container();
                },
              ),
              AppErrorModalWidget<EmployeesBlocType>(
                errorState: (bloc) => bloc.states.errors,
              ),
            ],
          ),
        ),
      );
}
