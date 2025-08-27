import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider_finder/Repository/algolia_repo.dart';
import 'package:service_provider_finder/models/facet_list.dart';

import '../models/restaurant.dart';

class RestaurantListViewModel extends GetxController {
  AlgoliaRepository algoliaRepository = Get.find();
  RxBool cardPage = true.obs;
  RxBool selectedPrice = true.obs;
  late final HitsSearcher hitsSearcher;
  late final FilterState filterState;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

bool run = true;

  final searchList = <Restaurants>[].obs;

  final areaGroup = FilterGroupID('area', FilterOperator.or);
  final priceGroup = FilterGroupID('price_range', FilterOperator.and);
  final ratingGroup = FilterGroupID('stars_count', FilterOperator.or);
  final diningGroup = FilterGroupID('dining_style', FilterOperator.and);
  final foodGroup = FilterGroupID('food_type', FilterOperator.and);

  List<FacetFoodList> listFoodType = <FacetFoodList>[].obs;
  List<String> listPriceRange = <String>[].obs;
  List<String> listDiningStyle = <String>[].obs;
  List<String> listArea = <String>[].obs;
  List<String> listRating = <String>[].obs;
  List<FacetFoodList> listFoodTypes = <FacetFoodList>[].obs;
  List<String> listPriceRanges = <String>[].obs;
  List<String> listDiningStyles = <String>[].obs;
  List<String> listAreas = <String>[].obs;
  List<String> listRatings = <String>[].obs;

  List<String> seletedFoodType = <String>[].obs;
  List<String> seletedAreaType = <String>[].obs;
  List<String> seletedDiningType = <String>[].obs;
  List<String> seletedPriceType = <String>[].obs;
  List<String> seletedRatingType = <String>[].obs;
  String queryofEditor = '';

  List<Map<String,dynamic>> highlightedList = <Map<String, dynamic>>[].obs;

  int currentPage = 0;
  int totalPage = 0;
  RxBool moreData = true.obs;
  RxBool loadingData = false.obs;
  RxBool showMoreAreas = false.obs;
  RxBool showMoreRating = false.obs;

  @override
  void onInit() {
    super.onInit();

    hitsSearcher = algoliaRepository.hitsSearcher;
    filterState = algoliaRepository.filterState;

    scrollController.addListener(() {
      if (!scrollController.hasClients) return;
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        loadMoreData();
      }
    });

    hitsSearcher.responses.listen((response) {
      if (currentPage == 0) {
        searchList.value = response.hits
            .map((hit) => Restaurants.fromMap(hit))
            .toList();
        highlightedList= response.hits;
      } else {
        searchList.addAll(
          response.hits.map((hit) => Restaurants.fromMap(hit)).toList(),
        );
        highlightedList.addAll(response.hits);
      }

      totalPage = response.nbPages;
      moreData.value = currentPage < totalPage- 1;
      loadingData.value = false;

      listFoodTypes = response.facets['food_type']
          ?.map((facet) => FacetFoodList(facet.value, facet.count))
          .toList() ??
          [];
      listPriceRanges = response.facets['price_range']
          ?.map((facet) => facet.value)
          .toList() ??
          [];
      listRatings = response.facets['stars_count']
          ?.map((facet) => facet.value)
          .toList() ??
          [];
      listDiningStyles = response.facets['dining_style']
          ?.map((facet) => facet.value)
          .toList() ??
          [];
      listAreas = response.facets['area']
          ?.map((facet) => facet.value)
          .toList() ??
          [];
      if(run == true){
        loadFacets();
      }
      run = false;

      // convertRatingtoNumbers();
      // discreteRatingValues();
    });


    performSearch('');

  }
  void loadFacets(){
    listFoodType.addAll(listFoodTypes);
    listRating.addAll(listRatings);
    listDiningStyle.addAll(listDiningStyles);
    listArea.addAll(listAreas);
    listPriceRange.addAll(listPriceRanges);
  }

  void performSearch(String query, {int page = 0}) {
    currentPage = page;
    queryofEditor = query;

    hitsSearcher.query(query);
    hitsSearcher.applyState(
          (state) => state.copyWith(
        page: currentPage,
        attributesToHighlight: ['name'],
        highlightPreTag: '<em>',
        highlightPostTag: '</em>',
        facets: ['food_type', 'price_range', 'dining_style', 'area', 'stars_count'],
        hitsPerPage: 10,
      ),
    );
  }

  void clearArea() {
    seletedAreaType.clear();
    updateFacets();
  }

  void clearPrice() {
    seletedPriceType.clear();
    updateFacets();
  }

  void clearDining() {
    seletedDiningType.clear();
    updateFacets();
  }

  void clearFood() {
    seletedFoodType.clear();
    updateFacets();
  }

  void clearRating() {
    seletedRatingType.clear();
    updateFacets();
  }

  void clearAll() {
    seletedFoodType.clear();
    seletedAreaType.clear();
    seletedDiningType.clear();
    seletedPriceType.clear();
    seletedRatingType.clear();
    updateFacets();
  }

  void applyAreaFilter(String area) {
    resetPagination();
    if (seletedAreaType.contains(area)) {
      seletedAreaType.remove(area);
    } else {
      seletedAreaType.add(area);
    }
    updateFacets();
  }

  void applyFoodFilter(String food) {
    resetPagination();
    if (seletedFoodType.contains(food)) {
      seletedFoodType.remove(food);
    } else {
      seletedFoodType.clear();
      seletedFoodType.add(food);
    }
    updateFacets();
  }

  void applyPriceFilter(String price) {
    resetPagination();
    if (seletedPriceType.contains(price)) {
      seletedPriceType.remove(price);
    } else {
      seletedPriceType.clear();
      seletedPriceType.add(price);
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

  void applyRatingFilter(String area) {
    resetPagination();
    if (seletedRatingType.contains(area)) {
      seletedRatingType.remove(area);
    } else {
      seletedRatingType.add(area);
    }
    updateFacets();
  }

  void applyDinningFilter(String dining) {
    resetPagination();
    if (seletedDiningType.contains(dining)) {
      seletedDiningType.remove(dining);
    } else {
      seletedDiningType.clear();
      seletedDiningType.add(dining);
    }
    updateFacets();
  }

  void searchEditor(String query) {
    queryofEditor= query;
    resetPagination();
    updateFacets();
  }

  void loadMoreData() {
    if (moreData.value == true && !loadingData.value) {
      loadingData.value = true;
      performSearch(queryofEditor, page: currentPage + 1);
    }
  }

  void resetPagination() {
    currentPage = 0;
    loadingData.value = false;
    moreData.value = true;
    totalPage = 0;
  }

  bool filters() {
    return seletedPriceType.isNotEmpty ||
        seletedFoodType.isNotEmpty ||
        seletedRatingType.isNotEmpty ||
        seletedAreaType.isNotEmpty ||
        seletedDiningType.isNotEmpty;
  }

  void showArea() {
    showMoreAreas.value = !showMoreAreas.value;
  }

  void showRating() {
    showMoreRating.value = !showMoreRating.value;
  }

  void updateFacets() {
    filterState.clear();

    if (seletedAreaType.isNotEmpty) {
      List<Filter> areaFilters = seletedAreaType
          .map((area) => Filter.facet('area', area))
          .toList();
      filterState.add(areaGroup, areaFilters);
    }

    if (seletedPriceType.isNotEmpty) {
      List<Filter> priceFilters = seletedPriceType
          .map((price) => Filter.facet('price_range', price))
          .toList();
      filterState.add(priceGroup, priceFilters);
    }

    if (seletedRatingType.isNotEmpty) {
      List<Filter> ratingFilters = seletedRatingType
          .map((rating) => Filter.facet('stars_count', rating))
          .toList();
      filterState.add(ratingGroup, ratingFilters);
    }

    if (seletedDiningType.isNotEmpty) {
      List<Filter> diningFilters = seletedDiningType
          .map((dining) => Filter.facet('dining_style', dining))
          .toList();
      filterState.add(diningGroup, diningFilters);
    }

    if (seletedFoodType.isNotEmpty) {
      List<Filter> foodFilters = seletedFoodType
          .map((food) => Filter.facet('food_type', food))
          .toList();
      filterState.add(foodGroup, foodFilters);
    }


    performSearch(queryofEditor, page: currentPage);
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
bool notFound(){
    if(searchList.isEmpty && filters()){
      return true;
    }
    else{
      return false;
    }
}


}