import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_seller_app/data/models/request/product_request_model.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/bloc/add_category/add_category_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/bloc/get_categories/get_categories_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/components/components.dart';
import '../../../data/models/response/category_response_model.dart';
import '../bloc/add_product/add_product_bloc.dart';
import '../bloc/get_products/get_products_bloc.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final categoryController = TextEditingController();
  int categoryId = 0;
  XFile? image;

  @override
  void initState() {
    context.read<GetCategoriesBloc>().add(
          const GetCategoriesEvent.getCategories(),
        );
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();

    priceController.dispose();
    stockController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Product'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                    loaded: (data) {
                      if (data.isEmpty) {
                        return const SizedBox();
                      }
                      categoryId = data.first.id!;

                      return Expanded(
                        child: CustomDropdown<Category>(
                          value: data.first,
                          items: data,
                          label: 'Category',
                          onChanged: (value) => {
                            categoryId = value!.id!,
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              const SpaceWidth(8.0),
              Expanded(
                child: Button.filled(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Tambah Kategori'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomTextField(
                                  controller: categoryController,
                                  label: 'Nama Kategori',
                                  hintText: 'Masukkan nama kategori',
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Batal'),
                              ),
                              BlocConsumer<AddCategoryBloc, AddCategoryState>(
                                listener: (context, state) {
                                  state.maybeWhen(
                                    orElse: () {},
                                    error: (message) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(message),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    },
                                    loaded: () {
                                      categoryController.clear();
                                      Navigator.pop(context);
                                      context.read<GetCategoriesBloc>().add(
                                            const GetCategoriesEvent
                                                .getCategories(),
                                          );
                                    },
                                  );
                                },
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () {
                                      return TextButton(
                                        onPressed: () {
                                          context.read<AddCategoryBloc>().add(
                                                AddCategoryEvent.addCategory(
                                                  name: categoryController.text,
                                                ),
                                              );
                                        },
                                        child: const Text('Tambah'),
                                      );
                                    },
                                    loading: () {
                                      return const CircularProgressIndicator();
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        });
                  },
                  label: 'Tambah Kategori',
                  width: 150.0,
                ),
              ),
            ],
          ),
          const SpaceHeight(8.0),
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
        child: BlocConsumer<AddProductBloc, AddProductState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              success: () {
                context.read<GetProductsBloc>().add(
                      const GetProductsEvent.getProducts(),
                    );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Product berhasil ditambahkan'),
                  ),
                );
                Navigator.pop(context);
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Button.filled(
                  onPressed: () {
                    final data = ProductRequestModel(
                      name: nameController.text,
                      description: descriptionController.text,
                      price: int.parse(priceController.text),
                      stock: int.parse(stockController.text),
                      image: image!,
                      categoryId: categoryId,
                    );
                    context.read<AddProductBloc>().add(
                          AddProductEvent.addProduct(data),
                        );
                  },
                  label: 'Tambah',
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
