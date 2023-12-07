import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_project_online_shop/bloc/authentication/authentication_state.dart';
import 'package:flutter_project_online_shop/bloc/category_page/category_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/category_page/category_page_event.dart';
import 'package:flutter_project_online_shop/bloc/home_page/home_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/home_page/home_page_event.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page/product_detail_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page/product_detail_page_event.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page_comments/product_detail_page_comments_bloc.dart';
import 'package:flutter_project_online_shop/bloc/purchase_cart_page/purchase_cart_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/purchase_cart_page/purchase_cart_page_event.dart';
import 'package:flutter_project_online_shop/di/di.dart';
import 'package:flutter_project_online_shop/models/product.dart';
import 'package:flutter_project_online_shop/models/purchased_product.dart';
import 'package:flutter_project_online_shop/ui/0.login_page.dart';
import 'package:flutter_project_online_shop/ui/0.main_page.dart';
import 'package:flutter_project_online_shop/util/auth_manager.dart';
import 'package:hive_flutter/adapters.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

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
          create: (context) {
            AuthenticationBloc authBloc = locator.get();
            authBloc.stream.forEach((state) {
              if (state is AuthenticationResponseState) {
                state.response.fold(
                  (error) => null,
                  (success) {
                    navigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
                      ),
                    );
                  },
                );
              }
            });
            return authBloc;
          },
        ),
        BlocProvider(
          create: (context) => locator.get<CategoryPageBloc>()
            ..add(
              CategoryPageRequestEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => locator.get<HomePageBloc>()
            ..add(
              HomePageRequestEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => locator.get<ProductDetailPageBloc>()
            ..add(
              ProductDetailPageRequestEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => locator.get<PurchaseCartPageBloc>()
            ..add(
              PurchaseCartPageLoadingRequestEvent(),
            )
            ..add(
              PurchaseCartPagePaymentInitializationEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => locator.get<ProductDetailPageCommentsBloc>(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: (AuthManager.readAuth().isEmpty) ? LoginPage() : const MainPage(),
      ),
    );
  }
}
