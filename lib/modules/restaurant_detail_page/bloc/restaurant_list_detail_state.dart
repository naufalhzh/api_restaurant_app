part of '../bloc/restaurant_list_detail_bloc.dart';

abstract class RestaurantListDetailState {}

class RestaurantListDetailLoading extends RestaurantListDetailState {}

class RestaurantListDetailLoaded extends RestaurantListDetailState {
  final List<RestaurantDetail> restaurantsDetail;

  RestaurantListDetailLoaded(this.restaurantsDetail);
}


class RestaurantListDetailEmpty extends RestaurantListDetailState {}

class RestaurantListDetailError extends RestaurantListDetailState {
  final String message;

  RestaurantListDetailError(this.message);
}
