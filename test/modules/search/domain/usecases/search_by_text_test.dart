import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:flutter_clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:flutter_clean_architecture/modules/search/domain/repositories/search_repository.dart';
import 'package:flutter_clean_architecture/modules/search/domain/usecases/search_by_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

main() {

  final repository = SearchRepositoryMock();

  final usecase = SearchByTextImpl(repository);
  
  test('deve retornar uma lista de ResultSearch', () async {
    
    when(repository.search(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
    
    final result = await usecase("jacob");
    expect(result, isA<Right>());
    expect(result.getOrElse(() => null), isA<List<ResultSearch>>());
  });

  test('deve retornar um exception caso o texto seja invalido - cenario null', () async {

    when(repository.search(any)).thenAnswer((_) async => Right(<ResultSearch>[]));

    final result = await usecase(null);
    expect(result, isA<Left>());
    expect(result.getOrElse(() => null), null); // Outra forma seria expect(result.isLeft(), true);
    expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());
  });

  test('deve retornar um exception caso o texto seja invalido - cenario texto vazio', () async {

    when(repository.search(any)).thenAnswer((_) async => Right(<ResultSearch>[]));

    final result = await usecase("");
    expect(result, isA<Left>());
    expect(result.isLeft(), true);
    expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());
  });
}