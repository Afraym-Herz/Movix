import 'package:dartz/dartz.dart';
import 'package:movix/core/failure/failure.dart';
import 'package:movix/core/network/api_client.dart';
import 'package:movix/features/explore/data/repo/explore_repo.dart';
class ExploreRepoImpl extends ExploreRepo {
 
  ExploreRepoImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<Either<Failure, Unit>> exploreMethod({required String uId}) {
    // TODO: implement exploreMethod
    throw UnimplementedError();
  }
}
