import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Sellers extends StatefulWidget {
  String name;
  Sellers({this.name});
  @override
  _SellersState createState() => _SellersState();
}

class _SellersState extends State<Sellers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text("Our Sellers"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance.collection("Products").where("product.name",isEqualTo: widget.name).orderBy("rate").snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return Center();
                }
                if(!snapshot.hasData){
                  return Center();
                }
                List data = snapshot.data.documents;
                return ListView.builder(physics: BouncingScrollPhysics(),itemCount: data.length,itemBuilder: (context,i){
                   

                    return Column(
                      children: <Widget>[
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

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: <Widget>[

                                                 Text("Contact No : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                 Text(data[i]["number"]),


                                              ],),
                                            ),
                                             Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(children: <Widget>[

                                                 Text("Name : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                 Text(data[i]["name"]),


                                              ],),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(children: <Widget>[

                                                 Text("Location : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                 Text(data[i]["location"]),


                                              ],),
                                            ),
                                             Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(children: <Widget>[

                                                 Text("Item Weight : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                 Text(data[i]["weight"].toString()+"kg"),


                                              ],),
                                            ),
                                             Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(children: <Widget>[

                                                 Text("Price : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                 Text(data[i]["rate"].toString()+"₹"),


                                              ],),
                                            ),
                                           Padding(
                                             padding: const EdgeInsets.only(top:8.0,bottom: 8),
                                             child: Container(height: 1,width: MediaQuery.of(context).size.width-35,color: Colors.grey,),
                                           ),

                                            GestureDetector(
                                              onTap: (){
                                                 launch('tel:${data[i]["number"].toString()}');
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
                                                        child: Text("CALL NOW",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
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
                      
                      ],
                    );
                },);
              }
            ),
          ),
          // Material(
          //   elevation: 10,
          //   child: Container(

          //     width: MediaQuery.of(context).size.width,
          //     height: 55,
          //     child: Row(
          //       children: <Widget>[
          //         Container(
          //           width: MediaQuery.of(context).size.width/2,
          //           child: Center(
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: <Widget>[
          //                 Padding(
          //                   padding: const EdgeInsets.only(right:8.0,bottom: 3),
          //                   child: Icon(CupertinoIcons.shopping_cart,color: Theme.of(context).primaryColor,),
          //                 ),
          //                 GestureDetector(
          //                   onTap: (){
          //                     Navigator.of(context).pop();
          //                   },
          //                                             child: Text(

          //                     "Shopping",
          //                     style: TextStyle(
          //                       fontSize: 15,
          //                       color: Theme.of(context).primaryColor,

          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),

          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Container(
          //             decoration: BoxDecoration(
          //                 color: Theme.of(context).primaryColor,

          //                 borderRadius: BorderRadius.circular(20)
          //             ),
          //             width: (MediaQuery.of(context).size.width/2)-30,
          //             child: Center(
          //               child: Text(
          //                 "Buy Now",
          //                 style: TextStyle(

          //                   fontSize: 15,
          //                   color:Colors.white,

          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}