import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_seller_app/core/constants/variables.dart';
import 'package:flutter_ecommerce_seller_app/core/core.dart';
import 'package:flutter_ecommerce_seller_app/data/models/request/update_product_request_model.dart';
import 'package:flutter_ecommerce_seller_app/data/models/response/products_response_model.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/bloc/update_product/update_product_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProductPage extends StatefulWidget {
  final Product item;
  const EditProductPage({super.key, required this.item});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;
  late final TextEditingController stockController;
  XFile? image;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.item.name);
    descriptionController =
        TextEditingController(text: widget.item.description);

    priceController = TextEditingController(text: '${widget.item.price}');
    stockController = TextEditingController(text: '${widget.item.stock}');
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();

    priceController.dispose();
    stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CustomTextField(
            controller: nameController,
            label: 'Nama Product',
            hintText: 'Masukkan nama product',
            textInputAction: TextInputAction.next,
          ),
          const SpaceHeight(8.0),
          CustomTextField(
            controller: descriptionController,
            label: 'Deskripsi',
            hintText: 'Masukkan Deskripsi',
            textInputAction: TextInputAction.next,
          ),
          const SpaceHeight(8.0),
          CustomImagePicker(
            label: 'Gambar',
            imageUrl: '${Variables.baseUrl}/storage/${widget.item.image}',
            onChanged: (imagePath) {
              if (imagePath != null) {
                image = imagePath;
              }
            },
          ),
          const SpaceHeight(8.0),
          CustomTextField(
            controller: priceController,
            label: 'Harga',
            hintText: 'Masukkan Harga',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
          ),
          const SpaceHeight(8.0),
          CustomTextField(
            controller: stockController,
            label: 'Total Stok',
            hintText: 'Masukkan jumlah ketersediaan',
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<UpdateProductBloc, UpdateProductState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              success: () {
                Navigator.pop(context);
                context.read<GetProductsBloc>().add(
                      const GetProductsEvent.getProducts(),
                    );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Product updated successfully'),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              orElse: () => Button.filled(
                onPressed: () {
                  final data = UpdateProductRequestModel(
                    id: widget.item.id!,
                    name: nameController.text,
                    description: descriptionController.text,
                    price:
                        int.parse(priceController.text.replaceAll('.00', '')),
                    stock: int.parse(stockController.text),
                    categoryId: 2,
                    image: image,
                  );
                  context.read<UpdateProductBloc>().add(
                        UpdateProductEvent.updateProduct(
                          data,
                        ),
                      );
                },
                label: 'Update',
              ),
            );
          },
        ),
      ),
    );
  }
}
