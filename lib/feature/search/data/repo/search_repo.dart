import 'package:dartz/dartz.dart';
import 'package:digital_hub_task/core/failure/failure.dart';
import 'package:digital_hub_task/feature/home/data/model/New_post.dart';

abstract class SearchRepo {
  Future<Either<Failure,NewsResponse>> searchByKeyword(String keyword,int pageNumber);
}