part of 'restaurant_list_bloc.dart';

@immutable
abstract class RestaurantListEvent {}

class FetchRestaurantsEvent extends RestaurantListEvent {}

class SearchRestaurantsEvent extends RestaurantListEvent {
  final String query;

  SearchRestaurantsEvent(this.query);
}

class ClearSearchEvent extends RestaurantListEvent {}
