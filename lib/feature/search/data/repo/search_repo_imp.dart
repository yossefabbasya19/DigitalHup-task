import 'package:dartz/dartz.dart';
import 'package:digital_hub_task/core/api_service/api_constant.dart';
import 'package:digital_hub_task/core/api_service/api_service.dart';
import 'package:digital_hub_task/core/failure/failure.dart';
import 'package:digital_hub_task/feature/home/data/model/New_post.dart';
import 'package:digital_hub_task/feature/search/data/repo/search_repo.dart';
import 'package:dio/dio.dart';

 class SearchRepoImp extends SearchRepo {
  @override
  Future<Either<Failure,NewsResponse>> searchByKeyword(String keyword,int pageNumber)async{
    try {
      var response = await ApiService.get(ApiConstant.everyThingEndpoint, {
        "q":keyword,
        "apiKey": ApiConstant.apiKey,
        "page": pageNumber,
        "pageSize":10
      });
      NewsResponse newsResponse = NewsResponse.fromJson(response);
      return Right(newsResponse);
    } catch (e) {
      if (e is DioException) {
        print(e.response!.data);
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}