import 'dart:io';

import 'package:flutter_clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:flutter_clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:flutter_clean_architecture/modules/search/infra/datasources/search_datasource.dart';
import 'package:flutter_clean_architecture/modules/search/infra/models/result_search_model.dart';
import 'package:flutter_clean_architecture/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchDataSourceMock extends Mock implements SearchDatasource {}

main() {
  final datasource = SearchDataSourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('deve retornar uma lista de ResultSearch', () async {
    when(datasource.getSearch(any))
        .thenAnswer((_) async => <ResultSearchModel>[]);
    final result = await repository.search("jacob");

    expect(result.getOrElse(() => null), isA<List<ResultSearch>>()); // No lugar de result.getOrElse(() => null) poderia ser result | null
  });

  test('deve retornar uma DataSourceError se o datasource falhar', () async {
    when(datasource.getSearch(any)).thenThrow(Exception());
    final result = await repository.search("jacob");

    expect(result.fold((l) => l, (r) => r), isA<DataSourceError>()); // No lugar de result.getOrElse(() => null) poderia ser result | null
  });
}
