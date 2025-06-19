import 'package:assigment_4/features/auth/presentation/bloc/profile/profile_bloc.dart';
import 'package:assigment_4/features/home/presentation/bloc/search_product/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/auth/presentation/bloc/register/bloc.dart';
import 'features/home/presentation/bloc/category/bloc.dart';
import 'features/home/presentation/bloc/category/single_category_bloc.dart';
import 'features/home/presentation/bloc/get_product/bloc.dart';
import 'features/home/presentation/bloc/product_details/bloc.dart';

class MyBlocProvider extends StatelessWidget {
  const MyBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Auth BLoCs
        BlocProvider<LogInUserBloc>(
          create: (context) => GetIt.I<LogInUserBloc>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => GetIt.I<ProfileBloc>(),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => GetIt.I<ProductBloc>(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => GetIt.I<SearchBloc>(),
        ),
        BlocProvider<AllProductBloc>(
          create: (context) => GetIt.I<AllProductBloc>(),
        ),
        BlocProvider<CategoryProductBloc>(
          create: (context) => GetIt.I<CategoryProductBloc>(),
        ),
        BlocProvider<SingleProductBloc>(
          create: (context) => GetIt.I<SingleProductBloc>(),
        ),
      ],
      child: child,
    );
  }
}