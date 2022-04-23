import 'package:api/core/map_api/domain/entities/request/get_features_body.dart';
import 'package:api/core/map_api/domain/entities/response/feature_collection_response.dart';
import 'package:dartz/dartz.dart';

import '../failures.dart';
import '../remote/map_api_remote_gateway.dart';
import 'base_repository.dart';

class MapApiRepository extends BaseRepository {
  MapApiRepository({
    required this.mapApiRemoteGateway,
  }) : super();

  MapApiRemoteGateway mapApiRemoteGateway;

  Future<Either<FeatureCollectionResponse, Failure>> getFeatures({
    required GetFeaturesBody body,
  }) async {
    try {
      var result = await sendRequest(
        mapApiRemoteGateway.getFeatures(
          lonMin: body.lonMin,
          lonMax: body.lonMax,
          latMin: body.latMin,
          latMax: body.latMax,
        ),
      );
      return result.fold(
        (response) => Left(response),
        (error) => Right(error),
      );
    } on Exception catch (e) {
      return Right(Failure.undefined(error: e));
    }
  }
}
