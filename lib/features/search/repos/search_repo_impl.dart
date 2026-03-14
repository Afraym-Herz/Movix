import 'package:dartz/dartz.dart';
import 'package:movix/core/failure/failure.dart';
import 'package:movix/core/models/show_response.dart';
import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/features/search/repos/search_repo.dart';

class SearchRepoImpl extends SearchRepo {
 
  SearchRepoImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<Either<Failure, ShowResponse>> searchMethod({required String showTitle}) async {
    try {
      final response = await apiClient.get(
        ApiEndpoints.multiSearch,
        queryParameters: {
          'query': showTitle,
        }
        );

      if (response.success && response.data != null) {
        return Right(ShowResponse.mixedFromJson(response.data!));
      } else {
        return Left(
          ServerFailure(
            message: response.message ?? 'Failed to load search movies',
          ),
        );
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
