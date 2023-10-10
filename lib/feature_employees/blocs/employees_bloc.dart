import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/extensions/error_model_extensions.dart';
import '../../../base/models/errors/error_model.dart';
import '../models/employees_pair.dart';
import '../repositories/employees_repository.dart';

part 'employees_bloc.rxb.g.dart';

/// A contract class containing all events of the EmployeesBloC.
abstract class EmployeesBlocEvents {
  /// TODO: Document the event
  void fetchData();
}

/// A contract class containing all states of the EmployeesBloC.
abstract class EmployeesBlocStates {
  /// The loading state
  Stream<bool> get isLoading;

  /// The error state
  Stream<ErrorModel> get errors;

  /// TODO: Document the state
  Stream<Result<EmployeesPair>> get data;
}

@RxBloc()
class EmployeesBloc extends $EmployeesBloc {
  EmployeesBloc({required this.repository});

  final EmployeesRepository repository;

  @override
  Stream<Result<EmployeesPair>> _mapToDataState() => _$fetchDataEvent
      .startWith(null)
      .switchMap((value) => repository.fetchData().asResultStream())
      .setResultStateHandler(this)
      .shareReplay(maxSize: 1);

  /// TODO: Implement error event-to-state logic
  @override
  Stream<ErrorModel> _mapToErrorsState() => errorState.mapToErrorModel();

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;
}
