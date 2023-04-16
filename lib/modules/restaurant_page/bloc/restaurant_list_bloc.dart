import 'package:api_restaurant_app/models/restaurant_detail_model.dart';
import 'package:api_restaurant_app/models/restaurant_model.dart';
import 'package:api_restaurant_app/repository/restaurant_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part '../bloc/restaurant_list_event.dart';
part '../bloc/restaurant_list_state.dart';

class RestaurantListBloc
    extends Bloc<RestaurantListEvent, RestaurantListState> {
  RestaurantListBloc() : super(RestaurantListLoading()) {
    on<FetchRestaurantsEvent>((event, emit) async {
      try {
        final restaurants = await fetchRestaurants();
        emit(RestaurantListLoaded(restaurants));
      } catch (e) {
        emit(RestaurantListError(e.toString()));
      }
    });

    

    on<SearchRestaurantsEvent>((event, emit) async {
      final searchResults = await searchRestaurants(event.query);
      if (event.query.isEmpty) {
        emit(SearchResultsState(searchResults));
      } else {
        try {
          emit(SearchResultsState(searchResults));
        } catch (e) {
          emit(RestaurantListError(e.toString()));
        }
      }
    });

    on<ClearSearchEvent>((event, emit) {
      emit(RestaurantListEmpty());
    });
  }
}
