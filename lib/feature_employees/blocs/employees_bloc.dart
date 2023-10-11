import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/extensions/error_model_extensions.dart';
import '../../../base/models/errors/error_model.dart';
import '../models/employees_pair.dart';
import '../repositories/employees_repository.dart';

part 'employees_bloc.rxb.g.dart';

/// A contract class containing all events of the EmployeesBloC.
abstract class EmployeesBlocEvents {
  @RxBlocEvent(
    type: RxBlocEventType.behaviour,
  )
  void fetchData();
}

/// A contract class containing all states of the EmployeesBloC.
abstract class EmployeesBlocStates {
  /// The loading state
  Stream<bool> get isLoading;

  /// The error state
  Stream<ErrorModel> get errors;

  Stream<EmployeesPair> get data;
}

@RxBloc()
class EmployeesBloc extends $EmployeesBloc {
  EmployeesBloc({required this.repository});

  final EmployeesRepository repository;

  @override
  Stream<EmployeesPair> _mapToDataState() => _$fetchDataEvent
      .throttleTime(const Duration(milliseconds: 200))
      .switchMap((value) => repository.fetchData().asResultStream())
      .setResultStateHandler(this)
      .whereSuccess();

  @override
  Stream<ErrorModel> _mapToErrorsState() => errorState.mapToErrorModel();

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;
}
