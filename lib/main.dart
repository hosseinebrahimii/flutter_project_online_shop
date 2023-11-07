import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_project_online_shop/bloc/category_page/category_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/home_page/home_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/home_page/home_page_event.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page/product_detail_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/purchase_cart_page/purchase_cart_page_bloc.dart';
import 'package:flutter_project_online_shop/di/di.dart';
import 'package:flutter_project_online_shop/models/product.dart';
import 'package:flutter_project_online_shop/models/purchased_product.dart';
import 'package:flutter_project_online_shop/ui/0.main_page.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(PurchasedProductAdapter());
  await Hive.openBox<PurchasedProduct>('purchasedProductItems');

  await getItInit();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator.get<AuthenticationBloc>(),
        ),
        BlocProvider(
          create: (context) => locator.get<CategoryPageBloc>(),
        ),
        BlocProvider(
          create: (context) {
            var bloc = locator.get<HomePageBloc>();
            bloc.add(HomePageRequestEvent());
            return bloc;
          },
        ),
        BlocProvider(
          create: (context) => locator.get<ProductDetailPageBloc>(),
        ),
        BlocProvider(
          create: (context) => locator.get<PurchaseCartPageBloc>(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
