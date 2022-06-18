import 'package:dartz/dartz.dart';
import 'package:phononxchallenge/data/repository/users_repository.dart';
import 'package:phononxchallenge/domain/models/user.dart';

class GetUserUseCase {
  final UsersRepository? _projectRepository;

  GetUserUseCase(this._projectRepository);

  Future<Either<String,List<User>>> execute(String user) async{
    List<User> list = [];
    final usr = await _projectRepository!.getUser(user);
    return usr.fold((error) {
      return Left(error);
    }, (successUser) async {
      list.add(successUser);
      final companies = await _projectRepository!.getCompanies(user);
      return companies.fold((error) {
        return Left(error);
      }, (successCompanies) {
        list.addAll(successCompanies);
        return Right(list);
      });
    });
  }
}