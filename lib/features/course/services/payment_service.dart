import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  late Razorpay _razorpay;

  PaymentService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    debugPrint('Payment successful: ${response.paymentId}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    debugPrint('Payment error: ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
    debugPrint('External wallet selected: ${response.walletName}');
  }

  void startPayment({
    required String key,
    required int amount,
    required String name,
    required String description,
    String? contactNumber,
    String? email,
  }) {
    var options = {
      'key': key,
      'amount': amount, // amount in paise
      'name': name,
      'description': description,
      'prefill': {'contact': contactNumber ?? '', 'email': email ?? ''},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void dispose() {
    _razorpay.clear();
  }
}