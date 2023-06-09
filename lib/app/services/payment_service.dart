import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentService {
  bool isPaymentSuccessful = false;

  final dio = Dio(BaseOptions(headers: {
    "Authorization":
        'Bearer sk_test_51MhanZKvzgS8ZV7wHlCESt9HSkAnQVAiYi3NSwGS1D8XsreEM58h44fAULCDkFHt85gBIYi8fBULmgEq4JTd5zmB009B43jDFf',
    "Content-Type": "application/json"
  }));

  Future<bool> makePayment({
    required String amount,
    required String currency,
    required String cardNumber,
    required String expirationMonth,
    required String expirationYear,
    required String cvc,
  }) async {
    try {
      final invoiceId = await createInvoice(amount, currency);
      if (invoiceId != null) {
        isPaymentSuccessful = await payInvoice(
          invoiceId,
          cardNumber,
          expirationMonth,
          expirationYear,
          cvc,
        );
        showSnackbar(isPaymentSuccessful);
        return isPaymentSuccessful;
      }
    } catch (e, s) {
      print('exception: $e$s');
    }
    return false;
  }

  void showSnackbar(bool success) {
    Get.snackbar(
      'Payment',
      success ? 'Payment Successful' : 'Payment Failed',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: success ? Colors.green : Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
    );
  }

  Future<String?> createInvoice(String amount, String currency) async {
    try {
      final body = {
        'amount_due': calculateAmount(amount),
        'currency': currency,
        'collection_method': 'send_invoice',
      };

      final responseData = await sendRequest('https://api.stripe.com/v1/invoices', body);
      return responseData['id'];
    } catch (err) {
      print('err creating invoice: ${err.toString()}');
    }
    return null;
  }

  Future<bool> payInvoice(
    String invoiceId,
    String cardNumber,
    String expirationMonth,
    String expirationYear,
    String cvc,
  ) async {
    try {
      final body = {
        'source': {
          'object': 'card',
          'number': cardNumber,
          'exp_month': expirationMonth,
          'exp_year': expirationYear,
          'cvc': cvc,
        }
      };

      final responseData = await sendRequest('https://api.stripe.com/v1/invoices/$invoiceId/pay', body);
      return responseData['paid'];
    } catch (err) {
      print('err paying invoice: ${err.toString()}');
    }
    return false;
  }

  Future<dynamic> sendRequest(String url, dynamic body) async {
    final response = await dio.post(url, data: jsonEncode(body));
    return jsonDecode(response.data);
  }

  String calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}

void main() {
  final service = PaymentService();

  const amount = '10.99';
  const currency = 'USD';
  const cardNumber = '4242424242424242';
  const expirationMonth = '12';
  const expirationYear = '2024';
  const cvc = '123';

  service
      .makePayment(
    amount: amount,
    currency: currency,
    cardNumber: cardNumber,
    expirationMonth: expirationMonth,
    expirationYear: expirationYear,
    cvc: cvc,
  )
      .then((isPaymentSuccessful) {
    print('Payment result: ${isPaymentSuccessful ? 'Successful' : 'Failed'}');
  });
}
