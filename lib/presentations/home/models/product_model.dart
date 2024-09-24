import '../../../core/core.dart';

class ProductModel {
  final String name;
  final String imageUrl;
  final int price;
  final int quantity;
  final String description;

  ProductModel({
    required this.name,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
    required this.description,
  });

  String get priceFormatted => price.currencyFormatRp;
}

final products = [
  ProductModel(
    name: 'Premium Hijab Pasmina',
    imageUrl:
        'https://asset-3.tstatic.net/jualbeli/img/2021/10/2389263/1-1065772244-Premium-Hijab-Pashmina-Beelove-Magelang.jpg',
    price: 35000,
    description: 'Lorem ipsum dulur',
  ),
  ProductModel(
    name: 'Pakaian wanita model terbaru',
    imageUrl:
        'https://s0.bukalapak.com/bukalapak-kontenz-production/content_attachments/44635/w-475/shutterstock_589577570.jpg',
    price: 155000,
    description: 'Lorem ipsum dulur',
  ),
  ProductModel(
    name: 'Premium Hijab Pasmina',
    imageUrl:
        'https://asset-3.tstatic.net/jualbeli/img/2021/10/2389263/1-1065772244-Premium-Hijab-Pashmina-Beelove-Magelang.jpg',
    price: 35000,
    description: 'Lorem ipsum dulur',
  ),
  ProductModel(
    name: 'Pakaian wanita model terbaru',
    imageUrl:
        'https://s0.bukalapak.com/bukalapak-kontenz-production/content_attachments/44635/w-475/shutterstock_589577570.jpg',
    price: 155000,
    description: 'Lorem ipsum dulur',
  ),
  ProductModel(
    name: 'Premium Hijab Pasmina',
    imageUrl:
        'https://asset-3.tstatic.net/jualbeli/img/2021/10/2389263/1-1065772244-Premium-Hijab-Pashmina-Beelove-Magelang.jpg',
    price: 35000,
    description: 'Lorem ipsum dulur',
  ),
  ProductModel(
    name: 'Pakaian wanita model terbaru',
    imageUrl:
        'https://s0.bukalapak.com/bukalapak-kontenz-production/content_attachments/44635/w-475/shutterstock_589577570.jpg',
    price: 155000,
    description: 'Lorem ipsum dulur',
  ),
  ProductModel(
    name: 'Premium Hijab Pasmina',
    imageUrl:
        'https://asset-3.tstatic.net/jualbeli/img/2021/10/2389263/1-1065772244-Premium-Hijab-Pashmina-Beelove-Magelang.jpg',
    price: 35000,
    description: 'Lorem ipsum dulur',
  ),
  ProductModel(
    name: 'Pakaian wanita model terbaru',
    imageUrl:
        'https://s0.bukalapak.com/bukalapak-kontenz-production/content_attachments/44635/w-475/shutterstock_589577570.jpg',
    price: 155000,
    description: 'Lorem ipsum dulur',
  ),
];
