part of 'restaurant_list_bloc.dart';

abstract class RestaurantListState {}

class LoadingState extends RestaurantListState {}

class RestaurantListLoadedState extends RestaurantListState {
  final List<Restaurant> restaurants;

  RestaurantListLoadedState(this.restaurants);
}

class SearchResultsState extends RestaurantListState {
  final List<Restaurant> searchResults;

  SearchResultsState(this.searchResults);
}

class EmptyState extends RestaurantListState {}

class ErrorState extends RestaurantListState {
  final String message;

  ErrorState(this.message);
}
