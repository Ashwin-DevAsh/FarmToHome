import 'package:farmer_portal/Datas/UserData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ProductDetails.dart';
import 'cart.dart';

class SearchProduct extends StatefulWidget {
  var products;
  SearchProduct({this.products});
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  @override
  Widget build(BuildContext context) {
    return    Scaffold(
          body: Container(
              decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xff3bc25f),Color(0xff288a3a),
                        ])
                    ),
                child:  Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
                          
                          ),
                        
                          child: Padding(
                              padding: const EdgeInsets.only(left:0.0,right: 0),
                              child: Column(

                                children: <Widget>[

                                  Container(
                                    height: 85,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(top:20.0),
                                          child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
                                            Navigator.of(context).pop();
                                          },),
                                        ),
                                          Padding(
                                            padding: const EdgeInsets.only(top:28.0),
                                            child: Stack(
                                                   children: <Widget>[
                                                     IconButton(icon: Icon(CupertinoIcons.shopping_cart,color: Colors.white,),onPressed: (){
                                                        var route = CupertinoPageRoute(builder: (context)=>Cart());
                                                        Navigator.push(context, route);
                                                     },),
                     
                                                     (UserData.cart.length>0)? Padding(
                                                       padding: const EdgeInsets.only(left:28.0,top: 8.0,),
                                                       child: CircleAvatar(radius: 7,backgroundColor: Colors.red,child: Text("${UserData.cart.length}",style: TextStyle(fontSize: 7),),),
                                                     ):Center()
                                                   ],
                                                 ),
                                          )
                                      ],
                                    ),
                                   
                                  ),
                                    
                                  
                                  Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
                            color: Colors.white
                          ),
                                        child: Padding(
                                          padding: const  EdgeInsets.only(left:0.0,right:0.0,top:0),
                                          child: GridView.count(
                                            
                                            crossAxisCount: 2,
                                            physics:BouncingScrollPhysics(), // to disable GridView's scrolling
                                            shrinkWrap: true,
                                            children: List.generate(widget.products.length, (i){
                                              return Padding(
                                                padding: const EdgeInsets.only(left:12.0,right: 12,bottom: 24),
                                                child: GestureDetector(
                                                  onTap: (){
                                                    var route = CupertinoPageRoute(builder: (context)=>ProductDetails(product:widget.products[i]));
                                                    Navigator.of(context).push(route);

                                                  },
                                                  child: Material(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.white,
                                                  
                                                    elevation: 2,


                                                    child: Stack(

                                                      children: <Widget>[
                                                      ClipRRect(
                                                          borderRadius: BorderRadius.circular(10)
                                                        
                                                        ,child: Image(image: Image.asset(widget.products[i]["image"]).image,)),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: <Widget>[
                                                            Container(
                                                              

                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(widget.products[i]["name"],style: TextStyle(color: Colors.white),),
                                                              ),

                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
                                                                
                                                                color: Color(0xff288a3a),
                                                              ),
                                                            )
                                                          ],
                                                        )

                                                      ],
                                                    ),

                                                  ),
                                                ),
                                              );
                                            })
                                    ),
                                        ),
                                      ),
                                  ),
                                ],
                              ),
                            ),
                        )
                          
          ),
    );
  }
}