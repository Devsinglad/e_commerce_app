import 'package:e_commerce_app/data/products/products_api.dart';
import 'package:e_commerce_app/models/product_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'components/product_description.dart';
import 'components/product_images.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatefulWidget {
  final ProductsInEachCat? productsInEachCat;
  final String? id;
  final String? rating;

    const DetailsScreen({super.key, this.productsInEachCat,  this.id, this.rating});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
   int quantity=1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      widget.rating.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          ProductImages(product: widget.productsInEachCat!),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: widget.productsInEachCat!,
                ),
              ],
            ),
          ),
          QuantityWidget(
            initialQuantity: 1,
            onQuantityChanged: (newQuantity) {
              quantity=newQuantity;
              setState(() {

              });
            },
          ),
        ],
      ),
      bottomNavigationBar:
          Consumer<ProductApi>(builder: (context, snapshot, _) {
        return TopRoundedContainer(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ElevatedButton(
              onPressed: () {
                snapshot.addToCart(products: [
                  {"productId": widget.id, "quantity": quantity.toString()},
                ]);
                //Navigator.pushNamed(context, RouteGenerator.cartScreen);
              },
              child:  const Text("Add To Cart"),
            ),
          ),
        );
      }),
    );
  }
}

class QuantityWidget extends StatefulWidget {
  final int initialQuantity;
  final ValueChanged<int> onQuantityChanged;

  const QuantityWidget(
      {super.key,
      required this.initialQuantity,
      required this.onQuantityChanged});

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quantity',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (quantity > 1) {
                    setState(() {
                      quantity--;
                      widget.onQuantityChanged(quantity);
                    });
                  }
                },
              ),
              Text(
                '$quantity',
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    quantity++;
                    widget.onQuantityChanged(quantity);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}