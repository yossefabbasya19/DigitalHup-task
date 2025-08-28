import 'package:dartz/dartz.dart';
import 'package:digital_hub_task/core/failure/failure.dart';
import 'package:digital_hub_task/feature/home/data/model/New_post.dart';

abstract class HomeRepo {
  Future<Either<Failure, NewsResponse>>  getNewsByCategory(String category,int pageNumber);
}
