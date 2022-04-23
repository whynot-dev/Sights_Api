import 'package:api/core/map_api/dio/dio_helper.dart';
import 'package:api/core/map_api/gateway/remote/map_api_remote_gateway.dart';
import 'package:api/core/map_api/gateway/repositories/map_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt injection = GetIt.I;

void registerDio() async {
  injection.registerSingleton<Dio>(DioHelper.getDio());

  injection.registerLazySingleton<MapApiRemoteGateway>(() => MapApiRemoteGateway(dio: injection()));

  injection.registerLazySingleton<MapApiRepository>(() => MapApiRepository(
        mapApiRemoteGateway: injection(),
      ));
}
