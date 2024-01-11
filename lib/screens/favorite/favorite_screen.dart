import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/product_card.dart';
import '../../data/products/products_api.dart';
import '../../provider/controller.dart';
import '../details/details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
          "Favorites",
          style: Theme.of(context).textTheme.titleLarge,
        ),),
        body: Consumer<ProductApi>(builder: (context, snapshot, _) {
          final favoriteProducts = snapshot.products
              .where((product) =>
                  context.read<AppControllers>().isFavorite(product.id))
              .toList();
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child:favoriteProducts.isNotEmpty
                ? Column(
              children: [

                 Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: GridView.builder(
                            itemCount: favoriteProducts.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 0.7,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 16,
                            ),
                            itemBuilder: (context, index) => ProductCard(
                                product: favoriteProducts[index],
                                onPress: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => DetailsScreen(
                                              id: favoriteProducts[index]
                                                  .id
                                                  .toString(),
                                              productsInEachCat:
                                                  favoriteProducts[index],
                                              rating: favoriteProducts[index]
                                                  .rating
                                                  .toString(),
                                            )))),
                          ),
                        ),
                      )

              ],
            ): Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset('assets/images/empty.png')),
              const Text(
                'No Items Added',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          );
        }),
      ),
    );
  }
}