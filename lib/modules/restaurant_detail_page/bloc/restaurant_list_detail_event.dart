part of 'restaurant_list_detail_bloc.dart';


@immutable
abstract class RestaurantListDetailEvent {}


class FetchRestaurantDetailEvent extends RestaurantListDetailEvent {
  final String id;

  FetchRestaurantDetailEvent(this.id);
}