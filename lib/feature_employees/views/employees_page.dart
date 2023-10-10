import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';

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
          child: RxResultBuilder<EmployeesBlocType, EmployeesPair>(
            state: (bloc) => bloc.states.data,
            buildSuccess: (context, data, bloc) {
              print('data: $data');
              return Column(
                children: [
                  Text('EmployeeId1 ${data.firstEmployeeId}'),
                  Text('EmployeeId2 ${data.secondEmployeeId}'),
                  Text('ProjectId ${data.projectId}'),
                  Text('Days Worked ${data.daysWorkedTogether}'),
                ],
              );
            },
            buildLoading: (context, bloc) => const CircularProgressIndicator(),
            buildError: (context, error, bloc) => Text(error.toString()),
          ),
        ),
      );
}
