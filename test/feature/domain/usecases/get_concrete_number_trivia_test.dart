import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:trivia_clean_architecture/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_clean_architecture/feature/number_trivia/domain/respositories/number_trivia_repositories.dart';
import 'package:trivia_clean_architecture/feature/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  mockNumberTriviaRepository = MockNumberTriviaRepository();
  usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, text: "text");
  test('should get trivia for the number from the repository', () async {
    when(() => mockNumberTriviaRepository.getConcreteNumberTrivia(any())).thenAnswer((_) async => Right(tNumberTrivia));

    final result = await usecase(Params(number: tNumber));

    expect(result, Right(tNumberTrivia));
    verify(() => mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));

    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
