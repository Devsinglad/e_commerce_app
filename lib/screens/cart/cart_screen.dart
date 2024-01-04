import 'package:e_commerce_app/data/products/products_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../models/Cart.dart';
import '../../models/Product.dart';
import '../../utils/constants.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      var dB= Provider.of<ProductApi>(context,listen: false);
      dB.getUserCart();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductApi>(builder: (context, snapshot, _) {
      return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              InkWell(
                onTap: () {
                  snapshot.getUserCarts();
                },
                child: const Text(
                  "Your Cart",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Text(
                "${snapshot.userCartItems.first.userCarts.first.products.length} items",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          // child: ListView.builder(
          //   itemCount: snapshot.userCartItems.length,
          //   itemBuilder: (context, i) {
          //     final cartIt=snapshot.userCartItems[i];
          //     return Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 10),
          //       child:  Text(snapshot.userCartItems[i].userCarts[i].products[i].quantity.toString())
          //     );
          //   }
          // ),
        ),
        bottomNavigationBar: const CheckoutCard(),
      );
    });
  }
}

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    this.image,
    this.price,
    this.title,
    this.rating,
    this.quantity,
  }) : super(key: key);

  final String? image;
  final String? price;
  final String? title;
  final String? rating;
  final String? quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(image!),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title!,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: "\$${price}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: " x${rating}",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

//
// Dismissible(
// key: Key(cartIt.userCarts[index]
//     .products[index].productId
//     .toString()),
// direction: DismissDirection.endToStart,
// onDismissed: (direction) {
// setState(() {
// snapshot.userCartItems.removeAt(index);
// });
// },
// background: Container(
// padding: const EdgeInsets.symmetric(horizontal: 20),
// decoration: BoxDecoration(
// //Color(0xFFFFE6E6)
// color: Colors.redAccent,
// borderRadius: BorderRadius.circular(15),
// ),
// child: Row(
// children: [
// const Spacer(),
// SvgPicture.asset("assets/icons/Trash.svg"),
// ],
// ),
// ),
// child: Text(cartIt.userCarts[index].userId.toString()),
// ),