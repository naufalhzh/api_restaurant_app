import 'package:api_restaurant_app/modules/restaurant_detail_page/bloc/restaurant_list_detail_bloc.dart';
import 'package:api_restaurant_app/modules/restaurant_page/bloc/restaurant_list_bloc.dart';
import 'package:api_restaurant_app/modules/restaurant_detail_page/view/restaurant_detail_page.dart';
import 'package:api_restaurant_app/modules/restaurant_page/bloc/restaurant_list_bloc.dart';
import 'package:flutter/material.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  late final InternetConnectionChecker _connectionChecker;
  bool _hasInternetConnection = true;

  @override
  void initState() {
    super.initState();
    _connectionChecker = InternetConnectionChecker();
    _connectionChecker.onStatusChange.listen((status) {
      setState(() {
        _hasInternetConnection = status == InternetConnectionStatus.connected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Restaurant App',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),
        body: _hasInternetConnection
            ? Column(
                children: [
                  Container(
                    height: 60.0,
                    margin: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16.0),
                        const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration.collapsed(
                              hintText: 'Search for a restaurant',
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.7),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            onChanged: (query) {
                              context
                                  .read<RestaurantListBloc>()
                                  .add(SearchRestaurantsEvent(query));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<RestaurantListBloc, RestaurantListState>(
                      builder: (context, state) {
                        if (state is RestaurantListLoading) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                CircularProgressIndicator(),
                                SizedBox(height: 16.0),
                                Text('Loading...'),
                              ],
                            ),
                          );
                        } else if (state is RestaurantListLoaded) {
                          final restaurants = state.restaurants;
                          return ListView.builder(
                            itemCount: restaurants.length,
                            itemBuilder: (context, index) {
                              final restaurant = restaurants[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) =>
                                              RestaurantListDetailBloc()
                                                ..add(
                                                    FetchRestaurantDetailEvent(
                                                        restaurant.id)),
                                          child: RestaurantDetailPage(
                                            id: restaurant.id,
                                            deviceIndex: index,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    elevation: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Hero(
                                          tag: restaurant.id,
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                top: Radius.circular(8.0),
                                              ),
                                              child: Image.network(
                                                'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    restaurant.name,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 16,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        restaurant.rating
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    restaurant.city,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (state is SearchResultsState) {
                          final restaurants = state.searchResults;
                          return ListView.builder(
                            itemCount: restaurants.length,
                            itemBuilder: (context, index) {
                              final restaurant = restaurants[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) =>
                                              RestaurantListDetailBloc(),
                                          child: RestaurantDetailPage(
                                            id: restaurant.id,
                                            deviceIndex: index,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    elevation: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                              top: Radius.circular(8.0),
                                            ),
                                            child: Image.network(
                                              'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    restaurant.name,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 16,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        restaurant.rating
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    restaurant.city,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (state is RestaurantListEmpty) {
                          return const Center(
                            child: Text('No restaurants found'),
                          );
                        } else if (state is RestaurantListError) {
                          return const Center(
                            child: Text('Failed to load restaurants'),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text('No internet connection'),
              ));
  }
}
