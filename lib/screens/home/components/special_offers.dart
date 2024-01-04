import 'package:e_commerce_app/components/c_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/products/products_api.dart';
import '../../products/products_screen.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      var category = Provider.of<ProductApi>(context, listen: false);
      category.getCategories();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Categories for you",
              style: TextStyle(
                fontFamily: 'Muli',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
        Consumer<ProductApi>(builder: (context, api, _) {
          if(!api.initCatPage) {
            return SizedBox(
            height: MediaQuery.of(context).size.height*0.9,
            width: double.maxFinite,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (ctx, i) => SpecialOfferCard(
                image: i == 0 || i == 1
                    ? "assets/images/Image Banner 2.png"
                    : 'assets/images/Image Banner 3.png',
                category: api.categories[i],
                press: () {
                  api.getCategoriesProducts(api.categories[i]).then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductsScreen(
                          category: api.categories[i],
                        ),
                      ),
                    );
                  });
                },
              ),
              itemCount: api.categories.length,
            ),
          );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height*0.9,
              width: double.maxFinite,
              child: Center(child: customLoader()),
            );
          }
        }),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 242,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}