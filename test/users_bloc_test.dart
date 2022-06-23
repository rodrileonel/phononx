import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:phononxchallenge/app/users/bloc/users_bloc.dart';
import 'package:phononxchallenge/domain/usecases/get_user.dart';
import 'package:phononxchallenge/core/di.dart' as di;

import 'users_bloc_test.mocks.dart';


@GenerateMocks([GetUserUseCase])
void main() {
  late MockGetUserUseCase? mockGetUser;
  late UsersBloc? usersBloc;

  setUpAll(() {
    di.init();
    mockGetUser = MockGetUserUseCase();
    usersBloc = UsersBloc(mockGetUser);
  });

  tearDown(() {
    usersBloc?.close();
  });

  test('should initial state equals to InitialState', () async {
    //assert
    expect(usersBloc?.state, equals(InitialState()));
  });

  blocTest<UsersBloc, UsersState>(
    'emits Loading and SuccessfulState',
    build: () {
      when(mockGetUser?.execute('user')).thenAnswer((any) async => const Right([]));
      return UsersBloc(mockGetUser);
    },
    act: (bloc) => bloc.add(const GetUserEvent('user')),
    expect: () => [
      LoadingState(),
      const SuccessfulState([])
    ],
  );

  blocTest<UsersBloc, UsersState>(
    'emits Loading and ErrorState',
    build: () {
      when(mockGetUser?.execute('user')).thenAnswer((any) async => const Left(''));
      return UsersBloc(mockGetUser);
    },
    act: (bloc) => bloc.add(const GetUserEvent('user')),
    expect: () => [
      LoadingState(),
      const ErrorState('')
    ],
  ); 
}
