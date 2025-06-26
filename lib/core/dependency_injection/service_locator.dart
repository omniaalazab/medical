import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:medical/core/api/product_api_services.dart';
import 'package:medical/core/api_constant.dart';
import 'package:medical/features/payment_sucess/data/repository/payment_repository.dart';
import 'package:medical/features/payment_sucess/presentation/cubit/payment_cubit.dart';
import 'package:medical/features/product_details/data/repositry/product_repository.dart';
import 'package:medical/features/product_details/presentation/cubit/product_cubit.dart';

final sl = GetIt.instance;
void setupLocator() {
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://api.stripe.com/v1/',
        headers: {
          'Authorization': 'Bearer ${APIKey.stripeSecretKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
    instanceName: 'stripeDio', // Named instance
  );

  // Default Dio for other APIs
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => ApiService(dio: sl()));
  sl.registerLazySingleton(() => ProductRepository(sl()));
  sl.registerFactory(() => ProductDetailsCubit(sl()));
  sl.registerLazySingleton(() => PaymentRepository());
  sl.registerFactory(() => PaymentCubit(sl<PaymentRepository>()));
}
