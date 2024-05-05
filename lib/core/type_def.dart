import 'package:fpdart/fpdart.dart';
import 'package:student_verification_system/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
