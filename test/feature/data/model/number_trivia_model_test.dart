import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_clean_architecture/feature/number_trivia/data/models/number_trivia_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(text: "Test Text", number: 1);

  test('should be a subclass of NumberTrivia entity', () async {
    expect(tNumberTriviaModel, isA<NumberTriviaModel>());
  });
  group('fromJson', () {
    test('should return a valid model when the JSON number is an integer', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });
  });
  group("toJson", () {
    test('should return a JSON map containing the proper data', () async {
      final result = tNumberTriviaModel.toJson();
      final expectedJsonMap = {
        "text": "Test Text",
        "number": 1,
      };
      expect(result, expectedJsonMap);
    });
  });
}
