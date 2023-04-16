part of '../bloc/restaurant_list_bloc.dart';

abstract class RestaurantListState {}

class RestaurantListLoading extends RestaurantListState {}

class RestaurantListLoaded extends RestaurantListState {
  final List<Restaurant> restaurants;

  RestaurantListLoaded(this.restaurants);
}


class SearchResultsState extends RestaurantListState {
  final List<Restaurant> searchResults;

  SearchResultsState(this.searchResults);
}

class RestaurantListEmpty extends RestaurantListState {}

class RestaurantListError extends RestaurantListState {
  final String message;

  RestaurantListError(this.message);
}
