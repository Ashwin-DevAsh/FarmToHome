import 'package:flutter/material.dart';
import 'package:flutter_google_pay/flutter_google_pay.dart';

class Buy extends StatefulWidget {
  var data;
  Buy({this.data});
  @override
  _BuyState createState() => _BuyState(data: data);
}

class _BuyState extends State<Buy> {

  var data;

  _BuyState({this.data});

  String getPrice(){
    return "";
  }

  _makeCustomPayment() async {
    var environment = 'rest'; // or 'production'

    if (!(await FlutterGooglePay.isAvailable(environment))) {
    //  _showToast(scaffoldContext, 'Google pay not available');
    } else {
      ///docs https://developers.google.com/pay/api/android/guides/tutorial
      PaymentBuilder pb = PaymentBuilder()
        ..addGateway("example")
        ..addTransactionInfo("1.0", "USD")
        ..addAllowedCardAuthMethods(["PAN_ONLY", "CRYPTOGRAM_3DS"])
        ..addAllowedCardNetworks(
            ["AMEX", "DISCOVER", "JCB", "MASTERCARD", "VISA"])
        ..addBillingAddressRequired(true)
        ..addPhoneNumberRequired(true)
        ..addShippingAddressRequired(true)
        ..addShippingSupportedCountries(["US", "GB"])
        ..addMerchantInfo("Example");

      FlutterGooglePay.makeCustomPayment(pb.build()).then((Result result) {
        if (result.status == ResultStatus.SUCCESS) {
     //     _showToast(scaffoldContext, 'Success');
        } else if (result.error != null) {
     //     _showToast(context, result.error);
        }
      }).catchError((error) {
        //TODO
      });
    }
  }

  _makeStripePayment() async {
    var environment = 'rest'; // or 'production'

    if (!(await FlutterGooglePay.isAvailable(environment))) {

    } else {
      PaymentItem pm = PaymentItem(
          stripeToken: 'pk_test_1IV5H8NyhgGYOeK6vYV3Qw8f',
          stripeVersion: "2018-11-08",
          currencyCode: "usd",
          amount: "0.0",
          gateway: 'stripe');

      FlutterGooglePay.makePayment(pm).then((Result result) {
        if (result.status == ResultStatus.SUCCESS) {

        }
      }).catchError((dynamic error) {

      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),

      body: Column(children: <Widget>[
                     Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(5),
                            elevation: 2,
                                                      child: Container(
                               
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                     border: Border.all(color: Colors.grey,style: BorderStyle.solid)
                                  ),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,

                                          children: <Widget>[

                                            // Padding(
                                            //   padding: const EdgeInsets.all(8.0),
                                            //   child: Row(
                                            //     children: <Widget>[

                                            //      Text("Contact No : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                            //      Text(data["number"]),


                                            //   ],),
                                            // ),
                                             Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(children: <Widget>[

                                                 Text("Name : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                 Text(data["name"]),


                                              ],),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[

                                                 Text("Location : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                 Container(width: MediaQuery.of(context).size.width-120,child: Text(data["location"])),


                                              ],),
                                            ),
                                             Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(children: <Widget>[

                                                 Text("Item Weight : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                 Text(data["weight"].toString()+"kg"),


                                              ],),
                                            ),
                                             Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[

                                                 Text("Price : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                 Text(data["rate"].toString()+"₹"),


                                              ],),
                                            ),
                                           Padding(
                                             padding: const EdgeInsets.only(top:8.0,bottom: 8),
                                             child: Container(height: 1,width: MediaQuery.of(context).size.width-35,color: Colors.grey,),
                                           ),

                                            GestureDetector(
                                              onTap: (){
                                               _makeStripePayment();
                                                 //launch('tel:${data[i]["number"].toString()}');
                                              },
                                                                                          child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width-52,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                              
                                                    children: <Widget>[
                                                     // Icon(Icons.call,color: Colors.lightBlue,size: 20,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left:0.0),
                                                        child: Text("Make Payment",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                                                      )
                                                  ],),
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                      ),
                                     
                                    ],
                                  ),
                                

                              ),
                          ),
                        ),
      ],),
    
    );
  }
}