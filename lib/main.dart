import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_seller_app/data/datasources/agora_remote_datasource.dart';
import 'package:flutter_ecommerce_seller_app/data/datasources/category_remote_datasource.dart';
import 'package:flutter_ecommerce_seller_app/data/datasources/rajaongkir_remote_datasource.dart';
import 'package:flutter_ecommerce_seller_app/presentations/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/bloc/add_category/add_category_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/bloc/agora_token/agora_token_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/bloc/get_categories/get_categories_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/bloc/add_product/add_product_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/auth/bloc/get_city/get_city_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/auth/bloc/get_subdistrict/get_subdistrict_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/auth/bloc/login/login_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/auth/bloc/register/register_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/auth/pages/splash_page.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/bloc/delete_product/delete_product_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/bloc/set_livestreaming/set_livestreaming_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/bloc/update_product/update_product_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

import 'core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasources/auth_remote_datasource.dart';
import 'data/datasources/product_remote_datasource.dart';
import 'presentations/auth/bloc/get_province/get_province_bloc.dart';
import 'presentations/home/bloc/get_products/get_products_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProvinceBloc(RajaongkirRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetCityBloc(RajaongkirRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetSubdistrictBloc(RajaongkirRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetProductsBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => DeleteProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => UpdateProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetCategoriesBloc(CategoryRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddCategoryBloc(CategoryRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => SetLivestreamingBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AgoraTokenBloc(AgoraRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          scaffoldBackgroundColor: AppColors.white,
          dialogBackgroundColor: AppColors.white,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.white,
          ),
          bottomSheetTheme:
              const BottomSheetThemeData(backgroundColor: AppColors.white),
          dividerTheme: const DividerThemeData(color: AppColors.stroke),
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.inter(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.black,
            ),
            centerTitle: true,
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
