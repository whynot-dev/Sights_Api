import 'package:api/core/map_api/domain/entities/response/feature_collection_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'map_api_remote_gateway.g.dart';

const String baseLang = 'ru';

const String apikey = '5ae2e3f221c38a28845f05b690c12d20384d5483ff8643101641fa7a';

@RestApi()
abstract class MapApiRemoteGateway {
  factory MapApiRemoteGateway({required Dio dio, String? baseUrl}) {
    final apiClient = _MapApiRemoteGateway(dio, baseUrl: baseUrl);
    return apiClient;
  }

  @GET('/{lang}/places/bbox')
  Future<HttpResponse<FeatureCollectionResponse>> getFeatures({
    @Path() String lang = baseLang,
    @Query('apikey') String apikey = apikey,
    @Query('lon_min') required double lonMin,
    @Query('lon_max') required double lonMax,
    @Query('lat_min') required double latMin,
    @Query('lat_max') required double latMax,
  });
}
