import 'package:apple_shop/data/model/card_model.dart';
import 'package:apple_shop/data/repository/card_repository.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/utils/extensions/string_extension.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final ICardLocalRepository _localRepository = serviceLocator.get();
  final PaymentRequest _paymentRequest = PaymentRequest();

  CardBloc() : super(CardInitialState()) {
    on<CardFetchedDataFromHiveEvent>((event, emit) async {
      final cardList = await _localRepository.getAllCardProducts();
      final finalPrice = await _localRepository.getShoppingCardFinalPrice();

      emit(CardFetchDataFromHiveState(cardList, finalPrice));
    });

    on<CardPaymentInitialEvent>((event, emit) async {
      _paymentRequest.setIsSandBox(true);
      _paymentRequest.setAmount(1000);
      _paymentRequest.setDescription('it is my first payment request!');
      _paymentRequest.setMerchantID('d645fba8-1b29-11ea-be59-000c295eb8fc');
      _paymentRequest.setCallbackURL('expertflutter://shop');

      linkStream.listen((deeplink) {
        if (deeplink!.toLowerCase().contains('authority')) {
          String? authority = deeplink.extractValueFromQuery('Authority');
          String? status = deeplink.extractValueFromQuery('Status');

          ZarinPal().verificationPayment(status!, authority!, _paymentRequest,
              (isPaymentSuccess, refID, paymentRequest) {
            if (isPaymentSuccess) {
              print(refID);
            } else {
              print('Error!');
            }
          });
        }
      });
    });

    on<CardPaymentRequestEvent>((event, emit) async {
      ZarinPal().startPayment(_paymentRequest, (status, paymentGatewayUri) {
        if (status == 100) {
          launchUrl(Uri.parse(paymentGatewayUri!),
              mode: LaunchMode.externalApplication);
        }
      });
    });
  }
}
