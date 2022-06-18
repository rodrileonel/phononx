import 'package:dartz/dartz.dart';
import 'package:phononxchallenge/core/constants.dart';
import 'package:phononxchallenge/data/api/users_api.dart';
import 'package:phononxchallenge/data/response/company_response.dart';
import 'package:phononxchallenge/domain/models/user.dart';

abstract class UsersRepository{
  Future<Either<String, User>> getUser(String user);
  Future<Either<String,List<User>>> getCompanies(String user);
}

class UsersRepositoryNetwork implements UsersRepository{
  final usersApi = UsersApi();

  @override
  Future<Either<String, User>> getUser(String user) async{
    final data = await usersApi.getUser(user);
    return data.fold((error) {
      return Left(error.message??UNKNOW_ERROR);
    },(success){
      return Right(
        User(
          name: success.name,
          avatar: success.avatarUrl,
          repositories: success.publicRepos,
        )
      );
    });
  }

  @override
  Future<Either<String,List<User>>> getCompanies(String user) async{
    List<User>? users = [];
    final companies = await usersApi.getCompanies(user);
    return companies.fold((error) {
      return Left(error.message??UNKNOW_ERROR);
    },(success) async{
      for(CompanyResponse company in success) {
        final dataUser = await getUser(company.login??'');
        dataUser.fold((error) {
          return Left(error);
        },(successDataUser){
          users.add(successDataUser);
        });
      }
      return Right(users);
    });
  }

}