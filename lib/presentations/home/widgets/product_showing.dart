import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../models/product_model.dart';

class ProductShowing extends StatefulWidget {
  final List<ProductModel> products;
  final void Function(ProductModel value) onChanged;

  const ProductShowing({
    super.key,
    required this.products,
    required this.onChanged,
  });

  @override
  State<ProductShowing> createState() => _ProductShowingState();
}

class _ProductShowingState extends State<ProductShowing> {
  ProductModel? selectedProduct;
  bool showProducts = false;

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
    widget.onChanged(product);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.deviceWidth,
      height: 300.0,
      child: Stack(
        children: [
          InkWell(
            onTap: toggleShowProducts,
            child: SizedBox(
              width: 100.0,
              height: 100.0,
              child: selectedProduct == null
                  ? DottedBorder(
                      color: Colors.white,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(8.0),
                      dashPattern: const [6, 3],
                      strokeWidth: 2,
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.black.withOpacity(0.16),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                              size: 18.0,
                            ),
                            SpaceHeight(4.0),
                            SizedBox(
                              width: 100.0,
                              child: Text(
                                'Klik Untuk Tampilkan Produk',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CachedNetworkImage(
                            imageUrl: selectedProduct!.imageUrl,
                            width: 100.0,
                            height: 100.0,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                          ColoredBox(
                            color: AppColors.black.withOpacity(0.53),
                            child: SizedBox(
                              width: context.deviceWidth,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${selectedProduct!.priceFormatted}\nubah',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          if (showProducts) ...[
            Positioned(
              top: 110.0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.31),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Klik “tampilkan” untuk menampilkan produk yang ingin di promosikan',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: SizedBox(
                        height: 150.0,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.products
                                .map(
                                  (item) => _ProductShowingCard(
                                    item: item,
                                    onTap: () => selectProduct(item),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ProductShowingCard extends StatelessWidget {
  final ProductModel item;
  final VoidCallback onTap;

  const _ProductShowingCard({
    required this.item,
    required this.onTap,
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
                      width: context.deviceWidth - 285.0,
                      child: Text(
                        item.priceFormatted,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SpaceWidth(20.0),
                    Button.filled(
                      onPressed: onTap,
                      label: 'Tampilkan',
                      borderRadius: 30.0,
                      height: 30.0,
                      width: 100.0,
                      fontSize: 10.0,
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
