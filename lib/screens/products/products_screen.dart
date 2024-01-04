import 'package:e_commerce_app/config/routes.dart';
import 'package:e_commerce_app/data/products/products_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/product_card.dart';
import '../details/details_screen.dart';

class ProductsScreen extends StatefulWidget {
  final String? category;

  const ProductsScreen({super.key, this.category});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products ${widget.category}"),
      ),
      body: SafeArea(
        child: Consumer<ProductApi>(builder: (context, snapshot, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              itemCount: snapshot.products.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.7,
                mainAxisSpacing: 20,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) => ProductCard(
                  product: snapshot.products[index],
                  onPress: () {
                    print('<<<<<<<<${snapshot.products[index].rating.rate.toString()}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(
                          productsInEachCat: snapshot.products[index],
                          id:snapshot.products[index].id.toString() ,
                          rating: snapshot.products[index].rating.rate.toString(),

                        ),
                      ),
                    );
                  }),
            ),
          );
        }),
      ),
    );
  }
}