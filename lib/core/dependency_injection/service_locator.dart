import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:medical/core/api/api_service.dart';
import 'package:medical/core/api/api_services.dart';
import 'package:medical/core/api/dio_with_auth.dart';
import 'package:medical/core/api_constant.dart';
import 'package:medical/features/cart/data/api_services/cart_api_services.dart';
import 'package:medical/features/cart/data/repository/cart_repository.dart';
import 'package:medical/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:medical/features/checkout/data/api/address_api_services.dart';
import 'package:medical/features/checkout/data/repository/address_repository.dart';
import 'package:medical/features/checkout/presentation/cubit/address_cubit.dart';
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
  sl.registerLazySingleton(() => AddressRepository(sl()));
  sl.registerLazySingleton(() => AddressCubit(sl()));
  sl.registerLazySingleton(() => CartRepository(sl()));
  sl.registerLazySingleton(() => CartCubit(sl()));
  sl.registerLazySingleton(() => ProductRepository(sl()));
  sl.registerFactory(() => ProductDetailsCubit(sl()));
  sl.registerLazySingleton(() => PaymentRepository());
  sl.registerFactory(() => PaymentCubit(sl<PaymentRepository>()));
}
