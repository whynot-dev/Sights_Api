import 'package:api/core/injection/injection.dart';
import 'package:api/core/map_api/domain/entities/request/get_features_body.dart';
import 'package:api/core/map_api/domain/entities/response/feature_collection_response.dart';
import 'package:api/core/map_api/gateway/failures.dart';
import 'package:api/core/map_api/gateway/repositories/map_api_repository.dart';
import 'package:bones_api/bones_api.dart';
import 'package:dartz/dartz.dart';

class MapModule extends APIModule {
  MapModule(APIRoot apiRoot) : super(apiRoot, '');

  _Responses _responses = _Responses(mapApiRepository: injection());

  @override
  String? get defaultRouteName => '/';

  @override
  void configure() {
    routes.get('/', (request) => APIResponse.ok('hello'));
    routes.get('map-api', (request) => _responses.featuresResponse());
  }
}

class _Responses {
  _Responses({
    required this.mapApiRepository,
  });

  final MapApiRepository mapApiRepository;

  Future<APIResponse> featuresResponse() async {
    GetFeaturesBody getFeaturesBody = GetFeaturesBody(
      lonMin: 39.703685,
      lonMax: 39.734575,
      latMin: 47.211769,
      latMax: 47.240241,
    );

    FeatureCollectionResponse? featureCollectionResponse;

    Either<FeatureCollectionResponse, Failure> result = await mapApiRepository.getFeatures(body: getFeaturesBody);
    result.fold(
      (data) {
        featureCollectionResponse = data;
      },
      (error) {
        return APIResponse.error(error: error);
      },
    );

    return APIResponse.ok(featureCollectionResponse);
  }
}
