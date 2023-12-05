import 'package:flutter_project_online_shop/util/deeplink_data_catcher.dart';
import 'package:flutter_project_online_shop/util/url_handler.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequest();
  Future<void> sendPaymentRequest({required int paymentAmount});
  Future<void> verifyPaymentRequest();
}

class ZarinPalPaymentHandler extends PaymentHandler {
  final PaymentRequest _paymentRequest;
  String? _authority;
  String? _status;

  ZarinPalPaymentHandler(this._paymentRequest);

  @override
  Future<void> initPaymentRequest() async {
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setDescription('خرید از شاپ');
    // TODO : import your paypal mechantID:
    _paymentRequest.setMerchantID('set your merchant id');
    _paymentRequest.setCallbackURL('expertflutter://shop');

    linkStream.listen(
      (event) {
        if (event!.toLowerCase().contains('authority')) {
          _authority = getAuthorityFromDeepLink(event);
          _status = getStatusFromDeepLink(event);
          verifyPaymentRequest();
        }
      },
    );
  }

  @override
  Future<void> sendPaymentRequest({required int paymentAmount}) async {
    _paymentRequest.setAmount(paymentAmount);

    ZarinPal().startPayment(
      _paymentRequest,
      (status, paymentGatewayUri) {
        if (status == 100) {
          UrlLauncher.openUrl(paymentGatewayUri!);
        }
      },
    );
  }

  @override
  Future<void> verifyPaymentRequest() async {
    ZarinPal().verificationPayment(
      _status!,
      _authority!,
      _paymentRequest,
      (isPaymentSuccess, refID, paymentRequest) {
        if (isPaymentSuccess) {
          //TODO: what should happen if the payment request was successful?
          //   print('success');
          //   print(refID);
          // } else {
          //   print('failed');
        }
      },
    );
  }
}
