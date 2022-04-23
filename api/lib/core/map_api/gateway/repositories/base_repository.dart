import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/entities/error_body.dart';
import '../failures.dart';

class BaseRepository {
  Future<Either<M, Failure>> sendRequest<M>(Future<HttpResponse<M>> request) async {
    try {
      final result = await request;
      if (result.response.statusCode.toString().startsWith('2')) {
        return Left(result.data);
      } else {
        return Right(Failure.request(
          code: result.response.statusCode,
          message: result.response.statusMessage,
          errorBody: ErrorBody.fromJson(result.response.data),
        ));
      }
    } on DioError catch (error) {
      return Right(Failure.request(
        code: error.response?.statusCode,
        message: error.response?.statusMessage,
        // errorBody: ErrorBody.fromJson(error.response?.data),
      ));
    } on Exception catch (error) {
      return Right(Failure.undefined(error: error));
    }
  }
}
