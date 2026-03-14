import 'package:dartz/dartz.dart';
import 'package:movix/core/failure/failure.dart';
import 'package:movix/core/models/show_response.dart';

abstract class SearchRepo {


  Future<Either<Failure, ShowResponse>> searchMethod({required String showTitle});


}
