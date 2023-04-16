import 'package:api_restaurant_app/bloc/restaurant_list_bloc.dart';
import 'package:api_restaurant_app/modules/restaurant_page/view/restaurant_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(
      title: 'Restaurant App',
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                RestaurantListBloc()..add(FetchRestaurantsEvent()),
          ),
        ],
        child: const RestaurantList(),
      )));
}
