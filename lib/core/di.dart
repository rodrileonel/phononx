import 'package:get_it/get_it.dart';
import 'package:phononxchallenge/app/users/bloc/users_bloc.dart';
import 'package:phononxchallenge/data/repository/users_repository.dart';
import 'package:phononxchallenge/domain/usecases/get_user.dart';

final getIt = GetIt.instance;

void init(){
  getIt.registerFactory(() => UsersBloc(getIt()));

  getIt.registerLazySingleton(() => GetUserUseCase(getIt()));

  getIt.registerLazySingleton<UsersRepository>(() => UsersRepositoryNetwork());
}