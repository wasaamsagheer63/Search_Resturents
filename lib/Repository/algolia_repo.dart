import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';

class AlgoliaRepository {
  late final HitsSearcher searcher;
  late final HitsSearcher facetor;
  late final FilterState filterState;

  AlgoliaRepository() {
    filterState = FilterState();

    searcher = HitsSearcher(
      applicationID: "SK2ZAVEZ6I",
      apiKey: "01c2f79c560be37899bc43d5bf8f138d",
      indexName: "Resturants_data",
      disjunctiveFacetingEnabled: true,
    );

    searcher.connectFilterState(filterState);

    facetor = HitsSearcher(
      applicationID: "SK2ZAVEZ6I",
      apiKey: "01c2f79c560be37899bc43d5bf8f138d",
      indexName: "Resturants_data",
    );
  }
}