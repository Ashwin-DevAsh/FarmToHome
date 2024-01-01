import 'package:flutter/material.dart';
import 'package:flutter_google_pay/flutter_google_pay.dart';

class BuyAll extends StatefulWidget {
  var data;
  BuyAll({this.data});
  @override
  _BuyState createState() => _BuyState(data: data);
}

class _BuyState extends State<BuyAll> {

  var data;

  _BuyState({this.data});

  String getPrice(){
    return "";
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

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        child: Text("₹ Pay"),
        onPressed: (){
          _makeStripePayment();
        },
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children:List.generate(data.length, (index){
          return      Padding(
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

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: <Widget>[

                              Text("Name : ",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(data[index]["name"]),


                            ],),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Text("Location : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                Container(width: MediaQuery.of(context).size.width-120,child: Text(data[index]["location"])),


                              ],),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: <Widget>[

                              Text("Item Weight : ",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(data[index]["weight"].toString()+"kg"),


                            ],),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Text("Price : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(data[index]["rate"].toString()+"₹"),


                              ],),
                          ),




                        ],
                      ),
                    ),

                  ],
                ),


              ),
            ),
          );
        })



    ),
      )
    );
  }
}