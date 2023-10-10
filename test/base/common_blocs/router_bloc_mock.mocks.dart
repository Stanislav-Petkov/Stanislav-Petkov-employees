// Mocks generated by Mockito 5.4.2 from annotations
// in employees/test/base/common_blocs/router_bloc_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:employees/base/models/errors/error_model.dart' as _i5;
import 'package:employees/lib_router/blocs/router_bloc.dart' as _i3;
import 'package:employees/lib_router/models/route_data_model.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart/rxdart.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeConnectableStream_0<T> extends _i1.SmartFake
    implements _i2.ConnectableStream<T> {
  _FakeConnectableStream_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRouterBlocEvents_1 extends _i1.SmartFake
    implements _i3.RouterBlocEvents {
  _FakeRouterBlocEvents_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRouterBlocStates_2 extends _i1.SmartFake
    implements _i3.RouterBlocStates {
  _FakeRouterBlocStates_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [RouterBlocEvents].
///
/// See the documentation for Mockito's code generation for more information.
class MockRouterBlocEvents extends _i1.Mock implements _i3.RouterBlocEvents {
  MockRouterBlocEvents() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void go(
    _i4.RouteDataModel? route, {
    Object? extra,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #go,
          [route],
          {#extra: extra},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void goToLocation(String? location) => super.noSuchMethod(
        Invocation.method(
          #goToLocation,
          [location],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void push(
    _i4.RouteDataModel? route, {
    Object? extra,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #push,
          [route],
          {#extra: extra},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void pushReplace(
    _i4.RouteDataModel? route, {
    Object? extra,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #pushReplace,
          [route],
          {#extra: extra},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void pop([Object? result]) => super.noSuchMethod(
        Invocation.method(
          #pop,
          [result],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [RouterBlocStates].
///
/// See the documentation for Mockito's code generation for more information.
class MockRouterBlocStates extends _i1.Mock implements _i3.RouterBlocStates {
  MockRouterBlocStates() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ConnectableStream<_i5.ErrorModel> get errors => (super.noSuchMethod(
        Invocation.getter(#errors),
        returnValue: _FakeConnectableStream_0<_i5.ErrorModel>(
          this,
          Invocation.getter(#errors),
        ),
      ) as _i2.ConnectableStream<_i5.ErrorModel>);

  @override
  _i2.ConnectableStream<void> get navigationPath => (super.noSuchMethod(
        Invocation.getter(#navigationPath),
        returnValue: _FakeConnectableStream_0<void>(
          this,
          Invocation.getter(#navigationPath),
        ),
      ) as _i2.ConnectableStream<void>);
}

/// A class which mocks [RouterBlocType].
///
/// See the documentation for Mockito's code generation for more information.
class MockRouterBlocType extends _i1.Mock implements _i3.RouterBlocType {
  MockRouterBlocType() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.RouterBlocEvents get events => (super.noSuchMethod(
        Invocation.getter(#events),
        returnValue: _FakeRouterBlocEvents_1(
          this,
          Invocation.getter(#events),
        ),
      ) as _i3.RouterBlocEvents);

  @override
  _i3.RouterBlocStates get states => (super.noSuchMethod(
        Invocation.getter(#states),
        returnValue: _FakeRouterBlocStates_2(
          this,
          Invocation.getter(#states),
        ),
      ) as _i3.RouterBlocStates);

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
