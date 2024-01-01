import 'package:farmer_portal/Datas/UserData.dart';
import 'package:farmer_portal/pages/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ProductDetails.dart';

class Category extends StatefulWidget {
  List products;
  String category = "";
  Category({this.products,this.category});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  TextEditingController searchbar = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:  
        Container(
            decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xff3bc25f),Color(0xff288a3a),
                      ])
                  ),
              child: NestedScrollView(
            

                      headerSliverBuilder: (context,_){
                        return [
                          Container(
                          
                            child: SliverAppBar(
                              expandedHeight: 50,
                              title: Text(widget.category),
                        

                              actions: <Widget>[
                                Stack(
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
                                )
                              ],

                              backgroundColor: Colors.transparent,

                            ),
                          )
                        ];
                      },

                      body:  Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
                        
                        ),
                      
                        child: Padding(
                            padding: const EdgeInsets.only(left:0.0,right: 0),
                            child: Column(

                              children: <Widget>[
                                  Container(
                                    


                                  child: Column(children: <Widget>[


                                      Padding(
                                          padding: const EdgeInsets.only(left:10.0,right:10.0,top:30),
                                          child: Container(
                                            height: 48,
                                            color: Colors.white,
                                            child:
                                            TextField(
                                              controller: searchbar,

                                              onChanged: (text){
                                                setState(() {
                                                  
                                                });
                                              },
                          
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.search),
                                                  suffixIcon: IconButton(icon: Icon(CupertinoIcons.clear_circled_solid),onPressed: (){
                                                    searchbar.text = "";
                                                    setState(() {
                                                      
                                                    });
                                                  },),
                                                  contentPadding: EdgeInsets.all( 10),
                                                  hintText: "What are you looking for ?",
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(0)
                                                  )
                                              ),
                          
                                            ),
                                          )
                          
                                      )
                                    ],),
                                    height: 85,
                                    decoration: BoxDecoration(
                          
                                        gradient: LinearGradient(colors: [
                                                          Color(0xff3bc25f) ,Color(0xff288a3a),
                                ])
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
                                          children: searchbar.text.isEmpty? List.generate(widget.products.length, (i){
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
                                          }):List.generate(widget.products.where((item)=>item["name"].toString().toLowerCase().contains(searchbar.text.toLowerCase())).toList().length,(i){
                                              var temp = widget.products.where((item)=>item["name"].toString().toLowerCase().contains(searchbar.text.toLowerCase())).toList();

                                              return Padding(

                                              padding: const EdgeInsets.all(12.0),
                                              child: GestureDetector(
                                                onTap: (){
                                                  var route = CupertinoPageRoute(builder: (context)=>ProductDetails(product:temp[i]));
                                                  Navigator.of(context).push(route);

                                                },
                                                child: Material(
                                                  key: UniqueKey(),
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.white,
                                                
                                                  elevation: 2,


                                                  child: Stack(

                                                    children: <Widget>[
                                                    ClipRRect(
                                                        borderRadius: BorderRadius.circular(10)
                                                      
                                                      ,child: Image(image: Image.asset(temp[i]["image"]).image,)),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: <Widget>[
                                                          Container(
                                                            

                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text(temp[i]["name"],style: TextStyle(color: Colors.white),),
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

                                          } )
                                  ),
                                      ),
                                    ),
                                ),
                              ],
                            ),
                          ),
                      )
                        ),
        ),
    );
  }
}