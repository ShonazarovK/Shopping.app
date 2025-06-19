import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import '../../features/auth/data/datasource/local_datasource/auth_local_datasource.dart';
import '../../features/auth/data/datasource/local_datasource/auth_local_datasource_impl.dart';

import '../../features/auth/data/datasource/remote_datasource/auth_remote_datasource.dart';
import '../../features/auth/data/datasource/remote_datasource/auth_remote_datasource_impl.dart';
import '../../features/auth/data/datasource/remote_datasource/profile_remote_datasource.dart';
import '../../features/auth/data/datasource/remote_datasource/profile_remote_datasource_impl.dart';

import '../../features/auth/data/repository/auth_repo.dart';
import '../../features/auth/data/repository/profile_repo.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/repository/profile_repo.dart';

import '../../features/auth/domain/usecase/register_usecase.dart';
import '../../features/auth/domain/usecase/profile_usecase.dart';

import '../../features/auth/presentation/bloc/register/bloc.dart';
import '../../features/auth/presentation/bloc/profile/profile_bloc.dart';

import '../../features/home/data/datasource/remote/product_remote_data_source.dart';
import '../../features/home/data/datasource/remote/product_remote_datasource.dart';
import '../../features/home/data/repositoies/product_repository_impl.dart';
import '../../features/home/domain/repositories/product_repo.dart';
import '../../features/home/domain/usecases/get_all_products.dart';
import '../../features/home/domain/usecases/get_single_products.dart';
import '../../features/home/domain/usecases/product_details_usecase.dart';
import '../../features/home/domain/usecases/product_usecase.dart';
import '../../features/home/domain/usecases/search_usecase.dart';


import '../../features/home/presentation/bloc/category/bloc.dart';
import '../../features/home/presentation/bloc/category/single_category_bloc.dart';
import '../../features/home/presentation/bloc/get_product/bloc.dart';
import '../../features/home/presentation/bloc/product_details/bloc.dart';
import '../../features/home/presentation/bloc/search_product/bloc.dart';

import '../network/dio_client.dart';

final sl = GetIt.instance;

Future<void> setup() async {

  await Hive.initFlutter();
  await GetStorage.init();

  if (!sl.isRegistered<Box>()) {
    final box = await Hive.openBox('myBox');
    sl.registerSingleton<Box>(box);
  }

  // Dio Client
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // Data Sources
  sl.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(box: sl<Box>()),
  );


  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(sl<DioClient>()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSourceImpl(
      dioClient: sl<DioClient>(),
      authLocalDataSource: sl<AuthLocalDataSource>(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      authRemoteDataSource: sl<AuthRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(
      remoteDataSource: sl<ProfileRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(remoteDataSource: sl<ProductRemoteDataSource>()),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl<ProfileRepository>()));
  sl.registerLazySingleton(() => GetProductsUseCase(sl<ProductRepository>()));
  sl.registerLazySingleton(() => SearchProductsUseCase(sl<ProductRepository>()));
  sl.registerLazySingleton(() => GetAllProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductsBySlugUseCase(sl()));
  sl.registerLazySingleton(() => GetSingleProductUseCase(sl()));
  // BLoCs
  sl.registerFactory(() => LogInUserBloc(sl<LoginUseCase>()));
  sl.registerFactory(() => ProfileBloc(sl<GetProfileUseCase>()));
  sl.registerFactory(() => ProductBloc(sl<GetProductsUseCase>()));
  sl.registerFactory(() => AllProductBloc(sl()));
  sl.registerFactory(() => CategoryProductBloc(sl()));
  sl.registerFactory(() => SingleProductBloc(sl()));
  sl.registerFactory(() => SearchBloc(sl<SearchProductsUseCase>()));
}
