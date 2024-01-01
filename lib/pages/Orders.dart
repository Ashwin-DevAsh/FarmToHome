import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
      ),
      body: Column
        (
        children: <Widget>[
          Expanded(
            child: ListView.builder(physics: BouncingScrollPhysics(),itemBuilder: (context,i){

              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image(image:Image.asset("lib/assets/product-${i+1}.jpg").image,height: 80,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.only(left:8.0,bottom: 8),
                                  child: Text("Product-${i+1}",style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: SafeArea(child: Container(width: MediaQuery.of(context).size.width-180, child: Text("About this  3dj3b poduch nknddk kjde3b bejk hob",maxLines: 3,))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0,top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text("₹200",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_forward_ios,size: 15,),
                          )

                        ],
                      ),


                      Divider()
                    ],
                  ),
                ),
              );
            },itemCount: 0,),
          ),

        ],
      ),
    );

  }
}
