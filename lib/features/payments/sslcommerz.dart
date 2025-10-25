import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

void paymentGatewayIntegration() async {
  double totalPrice = 1.0;
  Sslcommerz sslcommerz = Sslcommerz(
    initializer: SSLCommerzInitialization(
      multi_card_name: "visa,master,bkash",
      currency: SSLCurrencyType.BDT,
      product_category: "Food",
      sdkType: SSLCSdkType.TESTBOX,
      store_id: "wpdev68f341da99e2e",
      store_passwd: "wpdev68f341da99e2e@ssl",
      total_amount: totalPrice,
      tran_id: "Test-001655nH4",
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




