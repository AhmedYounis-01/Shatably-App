class PaymentIntentInputModel {
  final String amount;
  final String currency;
  final String cusomerId;

  PaymentIntentInputModel({
    required this.cusomerId,
    required this.amount,
    required this.currency,
  });

  toJson() {
    return {
      'amount': (double.parse(amount) * 100).toInt().toString(),
      'currency': currency,
      'customer': cusomerId,
    };
  }
}
