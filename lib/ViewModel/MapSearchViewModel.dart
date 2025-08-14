import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:get/get.dart';
import 'package:service_provider_finder/Repository/algolia_repo.dart';
import 'package:service_provider_finder/models/Resturents.dart';
import 'package:service_provider_finder/models/facetList.dart';

class MapSearchViewModel extends GetxController {
  AlgoliaRepository algoliaRepository = Get.find();
  late final HitsSearcher Searcher;
  late final HitsSearcher Faceter;

  var SearchList = <Resturents>[].obs;

  var ListFood_Type = <FacetFoodList>[].obs;
  var ListPrice_Range = <String>[].obs;
  var ListDining_Style = <String>[].obs;
  var ListArea = <String>[].obs;

  var SeletedFoodType = <String>[].obs;
  var SeletedAreaType = [].obs;
  var SeletedDiningType = [].obs;
  var SeletedPriceType = [].obs;
  RxString queryofEditor = ''.obs;

  var highlightedList = <Map<String, dynamic>>[].obs;

  var currentPage = 0.obs;
  var totalPage = 0.obs;
  var moreData = true.obs;
  var loadingData = false.obs;

  // var minPrice = 0.obs;
  // var maxPrice = 100.obs;
  //
  // var minPriceRange = 0.obs;
  // var maxPriceRange = 100.obs;

  void onInit() {
    super.onInit();
    Searcher = algoliaRepository.searcher;
    Faceter = algoliaRepository.facetor;
    Searcher.responses.listen((responce) {
      if (currentPage.value == 0) {
        SearchList.value = responce.hits
            .map((hit) => Resturents.fromMap(hit))
            .toList();
        highlightedList.value = responce.hits;
      } else {
        SearchList.addAll(
          responce.hits.map((hit) => Resturents.fromMap(hit)).toList(),
        );
        highlightedList.addAll(responce.hits);
      }

      totalPage.value = responce.nbPages;
      if (currentPage.value < totalPage.value - 1) {
        moreData.value = true;
      } else {
        moreData.value = false;
      }
      loadingData.value = false;
    });

    Faceter.responses.listen((responce) {
      ListFood_Type.value =
          responce.facets['food_type']
              ?.map((facet) => FacetFoodList(facet.value, facet.count))
              .toList() ??
          [];
      ListPrice_Range.value =
          responce.facets['price_range']
              ?.map((facet) => facet.value)
              .toList() ??
          [];
      ListDining_Style.value =
          responce.facets['dining_style']
              ?.map((facet) => facet.value)
              .toList() ??
          [];
      ListArea.value =
          responce.facets['area']?.map((facet) => facet.value).toList() ?? [];
      // calculatePriceboundry();
    });

    PerformSearch('');
    LoadFacets();
  }

  void PerformSearch(String query, {int page = 0}) {
    List<String> FacetFilter = [];
    for (var food in SeletedFoodType) {
      FacetFilter.add('food_type:${food}');
    }
    for (var area in SeletedAreaType) {
      FacetFilter.add('area:${area}');
    }
    for (var dining in SeletedDiningType) {
      FacetFilter.add('dining_style:${dining}');
    }
    for (var price in SeletedPriceType) {
      FacetFilter.add('price_range:${price}');
    }
    // if(maxPrice.value != maxPriceRange.value ){
    // for(var price in ListPrice_Range){
    //   List<int> priceValue = extractPriceFromString(price);
    //   if(priceValue.isNotEmpty){
    //     int maxValue = priceValue.last;
    //       if(maxValue <= maxPrice.value){
    //         FacetFilter.add("price_range:${price}");
    //       }
    //   }
    // }}
    currentPage.value = page;

    Searcher.applyState(
      (state) => state.copyWith(
        page: page,
        query: query,
        attributesToHighlight: ['name'],
        highlightPreTag: '<em>',
        highlightPostTag: '</em>',
        facets: ['food_type', 'price_range', 'dining_style', 'area', 'city'],
        facetFilters: FacetFilter,
        hitsPerPage: 10,
      ),
    );
  }

  void LoadFacets() {
    Faceter.applyState(
      (state) => state.copyWith(
        query: '',
        facets: ['food_type', 'price_range', 'dining_style', 'area'],
      ),
    );
  }

  void clearArea() {
    SeletedAreaType.value = [];
    PerformSearch(queryofEditor.value ?? "");
  }

  void clearPrice() {
    SeletedPriceType.value = [];
    PerformSearch(queryofEditor.value ?? "");
  }

  void clearDining() {
    SeletedDiningType.value = [];
    PerformSearch(queryofEditor.value ?? "");
  }

  void clearFood() {
    SeletedFoodType.value = [];
    PerformSearch(queryofEditor.value ?? "");
  }

  void clearall() {
    SeletedFoodType.value = [];
    SeletedAreaType.value = [];
    SeletedDiningType.value = [];
    SeletedPriceType.value = [];
    PerformSearch(queryofEditor.value ?? "");
  }

  void applyfoodfilter(String food) {
    resetPagination();
    if (SeletedFoodType.contains(food)) {
      SeletedFoodType.remove(food);
    } else {
      SeletedFoodType.value = [];
      SeletedFoodType.value.add(food);
    }

    PerformSearch(queryofEditor.value ?? "");
  }

  void applyAreafilter(String area) {
    if (SeletedAreaType.contains(area)) {
      SeletedAreaType.remove(area);
    } else {
      SeletedAreaType.value = [];
      resetPagination();

      SeletedAreaType.value.add(area);
    }
    PerformSearch(queryofEditor.value ?? "");
  }

  void applyPricefilter(String price) {
    if (SeletedPriceType.contains(price)) {
      SeletedPriceType.remove(price);
    } else {
      SeletedPriceType.value = [];
      resetPagination();

      SeletedPriceType.value.add(price);
    }
    PerformSearch(queryofEditor.value ?? "");
  }

  void applyDinningfilter(String dining) {
    if (SeletedDiningType.contains(dining)) {
      SeletedDiningType.remove(dining);
    } else {
      SeletedDiningType.value = [];
      resetPagination();
      SeletedDiningType.value.add(dining);
    }

    PerformSearch(queryofEditor.value ?? "");
  }

  void searchEditor(String query) {
    queryofEditor.value = query;
    resetPagination();
    PerformSearch(queryofEditor.value ?? "");
  }

  // List<int> extractPriceFromString(String priceString){
  //   RegExp expression = RegExp(r'\d+');
  //   List<String> priceRange = expression.allMatches(priceString).map((price) => price.group(0)!).toList();
  //   return priceRange.map((intPrice) => int.parse(intPrice)).toList();
  // }

  //   void calculatePriceboundry(){
  //     List<int> totalPriceValues = [];
  //     for(String price in ListPrice_Range){
  //       List<int> priceint = extractPriceFromString(price);
  //       totalPriceValues.addAll(priceint);
  //     }
  // if(totalPriceValues.isNotEmpty){
  //     minPriceRange.value = totalPriceValues.reduce((val1, val2) => val1 < val2 ? val1 : val2);
  //     maxPriceRange.value = totalPriceValues.reduce((val1, val2) => val1 > val2 ? val1 : val2);
  //     if(maxPrice.value == 100 || maxPrice.value == 0){
  //       maxPrice.value = maxPriceRange.value;
  //     }
  //
  //   }
  //   }
  void loadMoreData() {

    if (moreData.value == true && !loadingData.value) {
      loadingData.value = true;
      PerformSearch(queryofEditor.value??"", page: currentPage.value + 1);
    }
  }

  void resetPagination() {
    currentPage.value = 0;
    loadingData.value = false;
    moreData.value = true;
    totalPage.value = 0;
  }

  bool filters(){
    return SeletedPriceType.isNotEmpty || SeletedFoodType.isNotEmpty || SeletedAreaType.isNotEmpty || SeletedDiningType.isNotEmpty;

    }

  }


