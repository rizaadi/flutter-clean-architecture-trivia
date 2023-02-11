import 'package:trivia_clean_architecture/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:trivia_clean_architecture/core/usecases/usecase.dart';
import 'package:trivia_clean_architecture/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_clean_architecture/feature/number_trivia/domain/respositories/number_trivia_repositories.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
