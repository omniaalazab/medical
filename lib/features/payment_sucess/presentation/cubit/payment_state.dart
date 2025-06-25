class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSucess extends PaymentState {}

class PaymentFailure extends PaymentState {
  final String error;

  PaymentFailure(this.error);
}
