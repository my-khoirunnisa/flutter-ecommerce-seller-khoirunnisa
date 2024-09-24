import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../models/product_model.dart';

class ProductShowingBottomSheet extends StatefulWidget {
  const ProductShowingBottomSheet({super.key});

  @override
  State<ProductShowingBottomSheet> createState() =>
      _ProductShowingBottomSheetState();
}

class _ProductShowingBottomSheetState extends State<ProductShowingBottomSheet> {
  ProductModel? selectedProduct;
  bool showProducts = false;
  List<ProductModel> displayedProducts = [];

  void toggleShowProducts() {
    setState(() {
      showProducts = !showProducts;
    });
  }

  void selectProduct(ProductModel product) {
    setState(() {
      selectedProduct = product;
      showProducts = false;
    });
  }

  void toggleProductDisplay(ProductModel product) {
    setState(() {
      if (displayedProducts.contains(product)) {
        displayedProducts.remove(product);
      } else {
        displayedProducts.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SpaceHeight(8.0),
          const SizedBox(
            width: 48.0,
            child: Divider(
              color: AppColors.gray,
              height: 4.0,
              thickness: 4.0,
            ),
          ),
          const SpaceHeight(40.0),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (context, index) => const SpaceHeight(20.0),
            itemBuilder: (context, index) => _ProductShowingCard(
              item: products[index],
              onTap: () => toggleProductDisplay(products[index]),
              isDisplayed: displayedProducts.contains(products[index]),
            ),
          ),
          const SpaceHeight(12.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Button.filled(
              onPressed: () {},
              // =>
              //     context.pushReplacement(const LiveStreamingOnPage()
              // ),
              label: 'Mulai Sekarang',
            ),
          ),
          const SpaceHeight(12.0),
        ],
      ),
    );
  }
}

class _ProductShowingCard extends StatelessWidget {
  final ProductModel item;
  final VoidCallback onTap;
  final bool isDisplayed;

  const _ProductShowingCard({
    required this.item,
    required this.onTap,
    required this.isDisplayed,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: item.imageUrl,
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            const SpaceWidth(16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SpaceHeight(10.0),
                Row(
                  children: [
                    SizedBox(
                      width: context.deviceWidth - 260.0,
                      child: Text(
                        item.priceFormatted,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SpaceWidth(20.0),
                    SizedBox(
                      width: 120.0,
                      child: !isDisplayed
                          ? Button.filled(
                              onPressed: onTap,
                              label: 'Tampilkan',
                              borderRadius: 30.0,
                              height: 30.0,
                              width: 120.0,
                              fontSize: 10.0,
                            )
                          : Button.outlined(
                              onPressed: onTap,
                              label: 'Sembunyikan',
                              borderRadius: 30.0,
                              height: 30.0,
                              width: 120.0,
                              fontSize: 10.0,
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
