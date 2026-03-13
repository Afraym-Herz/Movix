import 'package:dartz/dartz.dart';
import 'package:movix/core/failure/failure.dart';

abstract class ExploreRepo {


  Future<Either<Failure, Unit>> exploreMethod({required String uId});


}
