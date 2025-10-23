import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

void paymentGatewayIntegration() async {
  var totalPrice = 1.0;
  Sslcommerz sslcommerz = Sslcommerz(
    initializer: SSLCommerzInitialization(
      multi_card_name: "visa,master,bkash",
      currency: SSLCurrencyType.BDT,
      product_category: "Food",
      sdkType: SSLCSdkType.TESTBOX,
      store_id: "ostad6824b3be647db",
      store_passwd: "ostad6824b3be647db@ssl",
      total_amount: totalPrice,
      tran_id: "custom_transaction_id-001655ndggjhgftywe5454",
    ),
  );

  final response = await sslcommerz.payNow();

  if(response.status == 'VALID'){
    print('Payement success');
    print('TxID: ${response.tranId}');
    print('TxID: ${response.tranDate}');
  }

  if(response.status == 'Closed'){
    print('Payement closed');
  }
  if(response.status == 'FAILED'){
    print('Payement failed');
  }

}




