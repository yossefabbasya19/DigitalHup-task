import 'package:dartz/dartz.dart';
import 'package:digital_hub_task/core/api_service/api_constant.dart';
import 'package:digital_hub_task/core/api_service/api_service.dart';
import 'package:digital_hub_task/core/failure/failure.dart';
import 'package:digital_hub_task/feature/home/data/model/New_post.dart';
import 'package:digital_hub_task/feature/home/data/repo/home_repo.dart';
import 'package:dio/dio.dart';

class HomeRepoImple extends HomeRepo {
  @override
  Future<Either<Failure, NewsResponse>> getNewsByCategory(
    String category,
    int pageNumber,
  ) async {
    try {
      var response = await ApiService.get(ApiConstant.topHeadlineEndpoint, {
        "category": category,
        "apiKey": ApiConstant.apiKey,
        "page": pageNumber,
       // "pageSize":20
      });
      NewsResponse newsResponse = NewsResponse.fromJson(response);
      return Right(newsResponse);
    } catch (e) {
      if (e is DioException) {
        print(e);
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
