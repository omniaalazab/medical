import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/features/payment_sucess/data/repository/payment_repository.dart';
import 'package:medical/features/payment_sucess/presentation/cubit/payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository paymentRepository;
  PaymentCubit(this.paymentRepository) : super(PaymentInitial());

  Future<void> makePayment({
    required String courseId,
    required int amount,
    required String currency,
  }) async {
    emit(PaymentLoading());

    final result = await paymentRepository.processPayment(
      amount: amount,
      currency: currency,
    );

    result.fold((failure) => emit(PaymentFailure(failure)), (_) async {
      emit(PaymentSucess());
    });
  }
}
