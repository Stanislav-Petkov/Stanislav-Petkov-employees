import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../../base/common_ui_components/app_error_modal_widget.dart';
import '../blocs/employees_bloc.dart';
import '../models/employees_pair.dart';

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
              SizedBox(
                width: 220,
                child: FloatingActionButton.extended(
                  onPressed: () =>
                      context.read<EmployeesBlocType>().events.fetchData(),
                  label: const Text('Pick a csv file'),
                  icon: const Icon(Icons.description),
                ),
              ),
              RxBlocBuilder<EmployeesBlocType, EmployeesPair>(
                state: (bloc) => bloc.states.data,
                builder: (context, pair, bloc) {
                  if (pair.hasData) {
                    return Column(
                      children: [
                        Text('EmployeeId1 ${pair.data!.firstEmployeeId}'),
                        Text('EmployeeId2 ${pair.data!.secondEmployeeId}'),
                        Text('ProjectId ${pair.data!.projectId}'),
                        Text('Days Worked ${pair.data!.daysWorkedTogether}'),
                      ],
                    );
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
