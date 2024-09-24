import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/assets/assets.dart';
import '../../../core/core.dart';
import '../bloc/get_products/get_products_bloc.dart';
import '../widgets/product_card.dart';
import 'add_product_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    context.read<GetProductsBloc>().add(const GetProductsEvent.getProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddProductPage(),
                ),
              );
            },
            icon: const Icon(Icons.add_circle_outline),
          ),
          const SpaceWidth(10.0),
        ],
      ),
      body: BlocBuilder<GetProductsBloc, GetProductsState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const Center(child: CircularProgressIndicator()),
            success: (products) {
              if (products.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icons.alert.empty.image(height: 154.0),
                      const SpaceHeight(50.0),
                      const Text(
                        'Product belum tersedia',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SpaceHeight(16.0),
                      const Text(
                        'Anda tidak memiliki product di toko. Silakan tambahkan menu terlebih dahulu.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: AppColors.gray,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: products.length,
                separatorBuilder: (context, index) => const SpaceHeight(16.0),
                itemBuilder: (context, index) => ProductCard(
                  item: products[index],
                ),
              );
            },
          );
          // return ListView.separated(
          //   padding: const EdgeInsets.all(16.0),
          //   itemCount: products.length,
          //   separatorBuilder: (context, index) => const SpaceHeight(16.0),
          //   itemBuilder: (context, index) => ProductCard(
          //     item: products[index],
          //   ),
          // );
        },
      ),
    );
  }
}
