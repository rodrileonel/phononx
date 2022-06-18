import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:phononxchallenge/core/constants.dart';
import 'package:phononxchallenge/data/environments.dart';
import 'package:phononxchallenge/data/response/company_response.dart';
import 'package:phononxchallenge/data/response/error_response.dart';
import 'package:phononxchallenge/data/response/user_response.dart';

class UsersApi{

  final String usersApi = 'users';

  Future<Either<ErrorResponse,UserResponse>> getUser(String user) async{
    try {
      final response = await http.get(Uri.parse('${Environments.apiUrl}/$usersApi/$user'),
        headers: {
          'Content-Type':'application/json',
        }
      );
      if(response.statusCode==200||response.statusCode==201){
        return Right(userResponseFromJson(response.body));
      } else{
        return Left(errorResponseFromJson(response.body));
      }
    } catch (e) {
      return Left(ErrorResponse(message: UNKNOW_ERROR));
    }
  }

  Future<Either<ErrorResponse,List<CompanyResponse>>> getCompanies(String user) async{
    try {
      final response = await http.get(Uri.parse('${Environments.apiUrl}/$usersApi/$user/orgs'),
        headers: {
          'Content-Type':'application/json',
        }
      );
      if(response.statusCode==200||response.statusCode==201){
        return Right(companyResponseFromJson(response.body));
      } else{
        return Left(errorResponseFromJson(response.body));
      }
    } catch (e) {
      return Left(ErrorResponse(message: UNKNOW_ERROR));
    }
  }

}