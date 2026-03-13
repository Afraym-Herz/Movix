import 'package:movix/core/network/api_client.dart';
import 'package:movix/core/network/api_endpoints.dart';
import 'package:movix/features/tv_series_details/models/tv_series_details_model.dart';

abstract class TVSeriesDetailsRepository {
  Future<TVSeriesDetailsModel> getTVSeriesDetails(int tvSeriesId);
}

class TVSeriesDetailsRepositoryImpl implements TVSeriesDetailsRepository {
  final ApiClient _apiClient;

  TVSeriesDetailsRepositoryImpl(this._apiClient);

  @override
  Future<TVSeriesDetailsModel> getTVSeriesDetails(int tvSeriesId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/3/tv/$tvSeriesId',
      queryParameters: {
        'api_key': ApiEndpoints.apiKey,
        'language': 'en-US',
      },
    );

    if (response.success && response.data != null) {
      return TVSeriesDetailsModel.fromJson(response.data!);
    } else {
      throw Exception(response.message ?? 'Failed to load TV series details');
    }
  }
}
