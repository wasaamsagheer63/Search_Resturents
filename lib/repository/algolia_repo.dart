import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';

class AlgoliaRepository {
  late final HitsSearcher hitsSearcher;
  late final FilterState filterState;

  AlgoliaRepository() {
    filterState = FilterState();

    hitsSearcher = HitsSearcher.create(applicationID: "SK2ZAVEZ6I",
        apiKey: "01c2f79c560be37899bc43d5bf8f138d",
        state: SearchState(indexName: "Resturants_data",
        facets: ['food_type', 'price_range', 'dining_style', 'area', 'stars_count']),
      disjunctiveFacetingEnabled: true,
    );

    hitsSearcher.connectFilterState(filterState);


  }
}