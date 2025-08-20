import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider_finder/Repository/algolia_repo.dart';
import 'package:service_provider_finder/models/Resturents.dart';
import 'package:service_provider_finder/models/facetList.dart';

class ResturentListViewModel extends GetxController {
  AlgoliaRepository algoliaRepository = Get.find();
  RxBool cardPage = true.obs;
  RxBool selectedPrice = true.obs;
  late final HitsSearcher Searcher;
  late final HitsSearcher Faceter;
  late final FilterState filterState;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  var AllRatingsInt = <int>[].obs;
  var RatingsList = <int>[].obs;


  var SearchList = <Resturents>[].obs;

  final areaGroup = FilterGroupID('area', FilterOperator.or);
  final priceGroup = FilterGroupID('price_range', FilterOperator.and);
  final ratingGroup = FilterGroupID('stars_count', FilterOperator.or);
  final diningGroup = FilterGroupID('dining_style', FilterOperator.and);
  final foodGroup = FilterGroupID('food_type', FilterOperator.and);

  var ListFood_Type = <FacetFoodList>[].obs;
  var ListPrice_Range = <String>[].obs;
  var ListDining_Style = <String>[].obs;
  var ListArea = <String>[].obs;
  var ListRating = <String>[].obs;

  var SeletedFoodType = <String>[].obs;
  var SeletedAreaType = <String>[].obs;
  var SeletedDiningType = <String>[].obs;
  var SeletedPriceType = <String>[].obs;
  var SeletedRatingType = <String>[].obs;
  RxString queryofEditor = ''.obs;

  var highlightedList = <Map<String, dynamic>>[].obs;

  var currentPage = 0.obs;
  var totalPage = 0.obs;
  var moreData = true.obs;
  var loadingData = false.obs;
  RxBool showMoreAreas = false.obs;
  RxBool showMoreRating = false.obs;

  @override
  void onInit() {
    super.onInit();

    Searcher = algoliaRepository.searcher;
    Faceter = algoliaRepository.facetor;
    filterState = algoliaRepository.filterState;

    scrollController.addListener(() {
      if (!scrollController.hasClients) return;
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        loadMoreData();
      }
    });

    Searcher.responses.listen((response) {
      if (currentPage.value == 0) {
        SearchList.value = response.hits
            .map((hit) => Resturents.fromMap(hit))
            .toList();
        highlightedList.value = response.hits;
      } else {
        SearchList.addAll(
          response.hits.map((hit) => Resturents.fromMap(hit)).toList(),
        );
        highlightedList.addAll(response.hits);
      }

      totalPage.value = response.nbPages;
      moreData.value = currentPage.value < totalPage.value - 1;
      loadingData.value = false;
    });

    Faceter.responses.listen((response) {
      ListFood_Type.value = response.facets['food_type']
          ?.map((facet) => FacetFoodList(facet.value, facet.count))
          .toList() ??
          [];
      ListPrice_Range.value = response.facets['price_range']
          ?.map((facet) => facet.value)
          .toList() ??
          [];
      ListRating.value = response.facets['stars_count']
          ?.map((facet) => facet.value)
          .toList() ??
          [];
      ListDining_Style.value = response.facets['dining_style']
          ?.map((facet) => facet.value)
          .toList() ??
          [];
      ListArea.value = response.facets['area']
          ?.map((facet) => facet.value)
          .toList() ??
          [];
      // convertRatingtoNumbers();
      // discreteRatingValues();
    });


    PerformSearch('');
    LoadFacets();

  }

  void PerformSearch(String query, {int page = 0}) {
    currentPage.value = page;
    queryofEditor.value = query;

    Searcher.query(query);
    Searcher.applyState(
          (state) => state.copyWith(
        page: page,
        attributesToHighlight: ['name'],
        highlightPreTag: '<em>',
        highlightPostTag: '</em>',
        facets: ['food_type', 'price_range', 'dining_style', 'area', 'stars_count'],
        hitsPerPage: 10,
      ),
    );
  }

  void LoadFacets() {
    Faceter.applyState(
          (state) => state.copyWith(
        query: '',
        facets: ['food_type', 'price_range', 'dining_style', 'area', 'stars_count'],
      ),
    );
  }

  void clearArea() {
    SeletedAreaType.clear();
    updateFacets();
  }

  void clearPrice() {
    SeletedPriceType.clear();
    updateFacets();
  }

  void clearDining() {
    SeletedDiningType.clear();
    updateFacets();
  }

  void clearFood() {
    SeletedFoodType.clear();
    updateFacets();
  }

  void clearRating() {
    SeletedRatingType.clear();
    updateFacets();
  }

  void clearall() {
    SeletedFoodType.clear();
    SeletedAreaType.clear();
    SeletedDiningType.clear();
    SeletedPriceType.clear();
    SeletedRatingType.clear();
    updateFacets();
  }

  void applyAreafilter(String area) {
    resetPagination();
    if (SeletedAreaType.contains(area)) {
      SeletedAreaType.remove(area);
    } else {
      SeletedAreaType.add(area);
    }
    updateFacets();
  }

  void applyfoodfilter(String food) {
    resetPagination();
    if (SeletedFoodType.contains(food)) {
      SeletedFoodType.remove(food);
    } else {
      SeletedFoodType.clear();
      SeletedFoodType.add(food);
    }
    print("following is Selected Food Type");
    print(SeletedFoodType);
    print("following is Search list after applying search");
    SearchList.value.map((items) => print(items.Name)).toList();

    updateFacets();
  }

  void applyPricefilter(String price) {
    resetPagination();
    if (SeletedPriceType.contains(price)) {
      SeletedPriceType.remove(price);
    } else {
      SeletedPriceType.clear();
      SeletedPriceType.add(price);
    }
    updateFacets();
  }
// bool isRatingSelected(int rating){
//     return SeletedRatingType.any((r_value) => double.tryParse(r_value)?.round() == rating);
// }
  // void applyRatingfilter(int rating) {
  //   resetPagination();
  //   if(isRatingSelected(rating)){
  //    SeletedRatingType.removeWhere((item) => double.tryParse(item)?.round() == rating);
  //   }
  //   else{
  //   for(var ratings in ListRating){
  //     if(double.tryParse(ratings)?.round() == rating){
  //       SeletedRatingType.value.add(ratings);}
  //     }
  //   }
  //   SeletedRatingType.refresh();
  //   updateFacets();
  // }

  void applyRatingfilter(String area) {
    resetPagination();
    if (SeletedRatingType.contains(area)) {
      SeletedRatingType.remove(area);
    } else {
      SeletedRatingType.add(area);
    }
    updateFacets();
  }

  void applyDinningfilter(String dining) {
    resetPagination();
    if (SeletedDiningType.contains(dining)) {
      SeletedDiningType.remove(dining);
    } else {
      SeletedDiningType.clear();
      SeletedDiningType.add(dining);
    }
    updateFacets();
  }

  void searchEditor(String query) {
    queryofEditor.value = query;
    resetPagination();
    updateFacets();
  }

  void loadMoreData() {
    if (moreData.value == true && !loadingData.value) {
      loadingData.value = true;
      PerformSearch(queryofEditor.value, page: currentPage.value + 1);
    }
  }

  void resetPagination() {
    currentPage.value = 0;
    loadingData.value = false;
    moreData.value = true;
    totalPage.value = 0;
  }

  bool filters() {
    return SeletedPriceType.isNotEmpty ||
        SeletedFoodType.isNotEmpty ||
        SeletedRatingType.isNotEmpty ||
        SeletedAreaType.isNotEmpty ||
        SeletedDiningType.isNotEmpty;
  }

  void showArea() {
    showMoreAreas.value = !showMoreAreas.value;
  }

  void showRating() {
    showMoreRating.value = !showMoreRating.value;
  }

  void updateFacets() {
    filterState.clear();

    if (SeletedAreaType.isNotEmpty) {
      List<Filter> areaFilters = SeletedAreaType
          .map((area) => Filter.facet('area', area))
          .toList();
      filterState.add(areaGroup, areaFilters);
    }

    if (SeletedPriceType.isNotEmpty) {
      List<Filter> priceFilters = SeletedPriceType
          .map((price) => Filter.facet('price_range', price))
          .toList();
      filterState.add(priceGroup, priceFilters);
    }

    if (SeletedRatingType.isNotEmpty) {
      List<Filter> ratingFilters = SeletedRatingType
          .map((rating) => Filter.facet('stars_count', rating))
          .toList();
      filterState.add(ratingGroup, ratingFilters);
    }

    if (SeletedDiningType.isNotEmpty) {
      List<Filter> diningFilters = SeletedDiningType
          .map((dining) => Filter.facet('dining_style', dining))
          .toList();
      filterState.add(diningGroup, diningFilters);
    }

    if (SeletedFoodType.isNotEmpty) {
      List<Filter> foodFilters = SeletedFoodType
          .map((food) => Filter.facet('food_type', food))
          .toList();
      filterState.add(foodGroup, foodFilters);
    }


    PerformSearch(queryofEditor.value, page: currentPage.value);
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }
//   void convertRatingtoNumbers(){
//     AllRatingsInt.value = ListRating.value.map((item) => double.tryParse(item)!.round()).toList();
//     print("following is list of rating");
//     print(AllRatingsInt);
// }
//   void discreteRatingValues(){
//     for(var r_value in AllRatingsInt){
//       if(!RatingsList.contains(r_value)){
//         RatingsList.value.add(r_value);
//       }
//     }
//     print("following is list of rating in Int");
//     print(RatingsList);
//   }
bool notfound(){
    if(SearchList.isEmpty && filters()){
      return true;
    }
    else{
      return false;
    }
}


}