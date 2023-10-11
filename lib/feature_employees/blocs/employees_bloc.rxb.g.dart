// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'employees_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class EmployeesBlocType extends RxBlocTypeBase {
  EmployeesBlocEvents get events;
  EmployeesBlocStates get states;
}

/// [$EmployeesBloc] extended by the [EmployeesBloc]
/// {@nodoc}
abstract class $EmployeesBloc extends RxBlocBase
    implements EmployeesBlocEvents, EmployeesBlocStates, EmployeesBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [fetchData]
  final _$fetchDataEvent = BehaviorSubject<void>();

  /// The state of [isLoading] implemented in [_mapToIsLoadingState]
  late final Stream<bool> _isLoadingState = _mapToIsLoadingState();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<ErrorModel> _errorsState = _mapToErrorsState();

  /// The state of [data] implemented in [_mapToDataState]
  late final Stream<EmployeesPair> _dataState = _mapToDataState();

  @override
  void fetchData() => _$fetchDataEvent.add(null);

  @override
  Stream<bool> get isLoading => _isLoadingState;

  @override
  Stream<ErrorModel> get errors => _errorsState;

  @override
  Stream<EmployeesPair> get data => _dataState;

  Stream<bool> _mapToIsLoadingState();

  Stream<ErrorModel> _mapToErrorsState();

  Stream<EmployeesPair> _mapToDataState();

  @override
  EmployeesBlocEvents get events => this;

  @override
  EmployeesBlocStates get states => this;

  @override
  void dispose() {
    _$fetchDataEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
