import 'package:api_restaurant_app/models/restaurant_detail_model.dart';
import 'package:api_restaurant_app/repository/restaurant_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part '../bloc/restaurant_list_detail_event.dart';
part '../bloc/restaurant_list_detail_state.dart';

class RestaurantListDetailBloc
    extends Bloc<RestaurantListDetailEvent, RestaurantListDetailState> {
  RestaurantListDetailBloc() : super(RestaurantListDetailLoading()) {
    on<FetchRestaurantDetailEvent>((event, emit) async {
      try {
        final restaurantDetail = await fetchRestaurantDetail(event.id);
        print('Restaurant detail fetched successfully!');
        emit(RestaurantListDetailLoaded([restaurantDetail]));
      } catch (e) {
        print('Restaurant detail failed to fetch!');
        emit(RestaurantListDetailError(e.toString()));
      }
    });
  }
}
