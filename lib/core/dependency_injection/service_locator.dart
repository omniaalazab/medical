import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:medical/core/api/api_services.dart';
import 'package:medical/core/api/dio_with_auth.dart';
import 'package:medical/core/api_constant.dart';
import 'package:medical/features/cart/data/api_services/cart_api_services.dart';
import 'package:medical/features/cart/data/repository/cart_repository.dart';
import 'package:medical/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:medical/features/category_listing/data/api/all_product_service_api.dart';
import 'package:medical/features/category_listing/data/repository/all_product_repository.dart';
import 'package:medical/features/category_listing/presentation/cubit/all_product_cubit.dart';
import 'package:medical/features/checkout/data/api/address_api_services.dart';
import 'package:medical/features/checkout/data/repository/address_repository.dart';
import 'package:medical/features/checkout/presentation/cubit/address_cubit.dart';
import 'package:medical/features/home/data/repos/search_repo.dart';
import 'package:medical/features/home/data/search_api_service/search_api_services.dart';
import 'package:medical/features/home/presentation/cubit/search_cubit.dart';
import 'package:medical/features/notification/data/api/api_services_notification.dart';
import 'package:medical/features/notification/data/repository/notification_repository.dart';
import 'package:medical/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:medical/features/payment_sucess/data/repository/payment_repository.dart';
import 'package:medical/features/payment_sucess/presentation/cubit/payment_cubit.dart';
import 'package:medical/features/product_details/data/repositry/product_repository.dart';
import 'package:medical/features/product_details/presentation/cubit/product_cubit.dart';

final sl = GetIt.instance;

void setupLocator() {
  // ✅ Stripe Dio with a name
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://api.stripe.com/v1/',
        headers: {
          'Authorization': 'Bearer ${APIKey.stripeSecretKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
    instanceName: 'stripeDio',
  );

  // ✅ Default Dio with auth token (used in most of the app)
  sl.registerLazySingleton<Dio>(() => createDioWithAuth());

  sl.registerLazySingleton(() => ApiService(dio: sl()));
  sl.registerLazySingleton(() => CartAPIServices(dio: sl()));
  sl.registerLazySingleton(() => AddressServiceApi(sl()));
  sl.registerLazySingleton(() => AllProductService(sl()));
  sl.registerLazySingleton(() => AllProductRepository(sl()));
  sl.registerLazySingleton(() => AllProductCubit(sl()));
  sl.registerLazySingleton(() => AddressRepository(sl()));
  sl.registerLazySingleton(() => AddressCubit(sl()));
  sl.registerLazySingleton(() => CartRepository(sl()));
  sl.registerLazySingleton(() => CartCubit(sl()));
  sl.registerLazySingleton(() => ProductRepository(sl()));
  sl.registerLazySingleton(() => NotificationRepository(sl()));
  sl.registerFactory(() => ProductDetailsCubit(sl()));
  sl.registerLazySingleton(() => PaymentRepository());
  sl.registerFactory(() => PaymentCubit(sl<PaymentRepository>()));
  sl.registerLazySingleton(() => NotificationService(sl()));

  sl.registerLazySingleton(() => NotificationCubit(sl()));
  sl.registerLazySingleton(() => SearchService(sl()));
  sl.registerLazySingleton(() => SearchRepository(sl()));
  sl.registerLazySingleton(() => SearchCubit(sl()));
}
