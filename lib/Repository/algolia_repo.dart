import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';

class AlgoliaRepository{



  late final HitsSearcher searcher;
  late final HitsSearcher facetor;

  AlgoliaRepository(){
    searcher = HitsSearcher(
        applicationID: "SK2ZAVEZ6I",
        apiKey: "01c2f79c560be37899bc43d5bf8f138d",
        indexName: "Resturants_data");

    facetor = HitsSearcher(
        applicationID: "SK2ZAVEZ6I",
        apiKey: "01c2f79c560be37899bc43d5bf8f138d",
        indexName: "Resturants_data");
  }
}