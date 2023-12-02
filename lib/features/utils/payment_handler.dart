import 'package:apple_shop/features/utils/url_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequest(int finalPrice);

  Future<void> sendPaymentRequest();

  Future<void> verifyPaymentRequest();
}

class ZarinPalPaymentHandler extends PaymentHandler {
  final PaymentRequest _paymentRequest = PaymentRequest();
  final UrlLaunchHandler urlLauncher;
  String? status;
  String? authority;

  ZarinPalPaymentHandler(this.urlLauncher);

  @override
  Future<void> initPaymentRequest(int finalPrice) async {
    _paymentRequest.setIsSandBox(false);
    _paymentRequest.setAmount(finalPrice);
    _paymentRequest.setDescription('it is my first payment request!');
    _paymentRequest.setMerchantID('d645fba8-1b29-11ea-be59-000c295eb8fc');
    _paymentRequest.setCallbackURL('expertflutter://shop');

    /* linkStream.listen(
      (deeplink) {
        if (deeplink!.toLowerCase().contains('authority')) {
          authority = deeplink.extractValueFromQuery('Authority');
          status = deeplink.extractValueFromQuery('Status');
          verifyPaymentRequest();
        }
      },
    );*/
  }

  @override
  Future<void> sendPaymentRequest() async {
    ZarinPal().startPayment(_paymentRequest, (status, paymentGatewayUri) {
      if (status == 100) {
        urlLauncher.openUrl(paymentGatewayUri!);
      }
    });
  }

  @override
  Future<void> verifyPaymentRequest() async {
    ZarinPal().verificationPayment(status!, authority!, _paymentRequest,
        (isPaymentSuccess, refID, paymentRequest) {
      if (isPaymentSuccess) {
        debugPrint(refID);
      } else {
        debugPrint('Error!');
      }
    });
  }
}
