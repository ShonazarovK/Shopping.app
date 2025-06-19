

import 'package:assigment_4/features/auth/presentation/pages/register_page.dart';
import 'package:assigment_4/features/home/presentation/pages/home_page.dart';
import 'package:assigment_4/features/home/presentation/pages/products_detail_page.dart';
import 'package:assigment_4/features/home/presentation/pages/search_page.dart';
import 'package:assigment_4/features/home/presentation/pages/wishlist_page.dart';
import 'package:flutter/material.dart';

import 'core/common/responsivenes/app_responsicenes.dart';
import 'core/route/route_generator.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    return MaterialApp(
      navigatorKey: AppRoute.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: SignInPage(),
    );
  }
}
