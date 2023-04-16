import 'package:api_restaurant_app/models/restaurant_detail_model.dart';
import 'package:api_restaurant_app/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatelessWidget {
  final String id;

  const RestaurantDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<RestaurantDetail>(
        future: fetchRestaurantDetail(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final restaurant = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: restaurant.id,
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}'),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 5),
                              ),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                restaurant.name,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Pacifico',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16.0,
                        left: 8.0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.grey),
                                const SizedBox(width: 8),
                                Text(
                                  restaurant.city,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber),
                                const SizedBox(width: 8),
                                Text(
                                  restaurant.rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          restaurant.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Categories:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: restaurant.categories
                              .map((category) => Chip(
                                    label: Text(category.name),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Menus:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Foods:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: restaurant.menus.foods
                              .map((food) => Chip(label: Text(food.name)))
                              .toList(),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Drinks:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: restaurant.menus.drinks
                              .map((drink) => Chip(label: Text(drink.name)))
                              .toList(),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Customer Reviews:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Column(
                          children: restaurant.customerReviews
                              .map((review) => ListTile(
                                    title: Text(review.name),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(review.review),
                                        Text(
                                          review.date,
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
