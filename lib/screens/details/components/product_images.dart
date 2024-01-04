import 'package:e_commerce_app/models/product_category.dart';
import 'package:flutter/material.dart';


class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductsInEachCat product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 238,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(widget.product.image),
          ),
        ),
        // SizedBox(height: 20),
      ],
    );
  }
}