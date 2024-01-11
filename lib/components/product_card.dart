import 'package:e_commerce_app/models/product_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../provider/controller.dart';
import '../utils/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRetio;
  final ProductsInEachCat product;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return Consumer<AppControllers>(
      builder: (context, snapshot,_) {
        return SizedBox(
          width: width,
          child: GestureDetector(
            onTap: onPress,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.02,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.network(product.image),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${product.price}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        snapshot.toggleFavorite(product: product, );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          color: snapshot.isFavorite(product.id)
                              ? kPrimaryColor.withOpacity(0.15)
                              : kSecondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/Heart Icon_2.svg",
                          colorFilter: ColorFilter.mode(
                              snapshot.isFavorite(product.id)
                                  ? const Color(0xFFFF4848)
                                  : const Color(0xFFDBDEE4),
                              BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}