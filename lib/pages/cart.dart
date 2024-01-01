import 'package:farmer_portal/DataBase/DataBaseHelper.dart';
import 'package:farmer_portal/Datas/UserData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';

import 'BuyAll.dart';
import 'Login.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  var lastvalue;
  var lastIndex;
  static var proWeight;
  static var totalWeight = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text("My Cart"),
      ),
      body: Builder(

        builder: (context) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(physics: BouncingScrollPhysics(),itemCount: UserData.cart.length,itemBuilder: (context,i){

                    proWeight = UserData.cart[i]["amount"];
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                              Row(
                                children: <Widget>[
                                 ClipRRect(
                                    borderRadius: BorderRadius.circular(10),child: Image(image:Image.asset(UserData.cart[i]["image"]).image,height: 80,)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        Row(
                                          children: <Widget>[

                                               Padding(
                                               padding: const EdgeInsets.only(left:8.0,bottom: 8),
                                               child: Text(UserData.cart[i]["name"],style: TextStyle(fontWeight: FontWeight.bold),),
                                                  ),
                                          Padding(
                                            padding: const EdgeInsets.only(left:8.0,bottom: 8),
                                            child: CircleAvatar(radius: 10,backgroundColor: Colors.pink.withOpacity(0.2),child: Text("${proWeight}kg",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 9,color: Colors.black),),),
                                          ),

                                          ],
                                        ),



                                        Padding(
                                          padding: const EdgeInsets.only(left:8.0),
                                          child: SafeArea(child: Container(width: MediaQuery.of(context).size.width-180, child: Text(UserData.cart[i]["use"],maxLines: 4,))),
                                        ),

                                      ],
                                    ),
                                  )

                                ],
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                     Padding(
                                          padding: const EdgeInsets.only(left:3.0,top: 10),
                                          child: Text(UserData.cart[i]["rate"],style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),),
                                        ),

                                    ],
                                  ),
                                ),

                                IconButton(icon: Icon(CupertinoIcons.clear_circled_solid,color: Colors.red,),onPressed: (){
                                  lastvalue = UserData.cart[i];
                                  UserData.cart.removeAt(i);
                                  lastIndex = i;
                                  DataBaseHelper.store.record("Cart").update(DataBaseHelper.db, UserData.cart);
                                  setState(() {

                                  });
                                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("Successfully deleted"),duration: Duration(milliseconds: 3000),action: SnackBarAction(label: "UNDO",onPressed: (){
                                    if(lastvalue!=null){
                                    UserData.cart.insert(lastIndex,lastvalue);
                                    DataBaseHelper.store.record("Cart").update(DataBaseHelper.db, UserData.cart);
                                    setState(() {
                                      lastIndex = null;
                                      lastvalue = null;
                                      Scaffold.of(context).hideCurrentSnackBar();


                                    });
                                    }
                                  },),));



                                },)
                              ],
                            ),

                            Divider()
                          ],
                        ),
                      ),
                    );
                },),
              ),
              Material(
                elevation: 10,
                child: Container(

                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right:8.0,bottom: 3),
                                child: Icon(CupertinoIcons.shopping_cart,color: Theme.of(context).primaryColor,),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                                          child: Text(

                                  "Shopping",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor,

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            if(UserData.number==""){
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Login Needed"),action: SnackBarAction(label:"LOGIN",onPressed: (){
                                var route = CupertinoPageRoute(builder: (context)=>LogIn());
                                Navigator.of(context).push(route);
                                

                              },),));

                              return;
                            }
                             if(UserData.cart.isEmpty){
                               Scaffold.of(context).showSnackBar(SnackBar(content: Text("Cart Empty"),));
                               return;
                             }
                            var route = CupertinoPageRoute(builder: (context)=>BuyAll(data:List.generate(UserData.cart.length, (index){
                               return  {
                                 "name": UserData.cart[index]["name"],
                                 "location":UserData.address,
                                 "weight":UserData.cart[index]["amount"],
                                 "rate":(double.parse(UserData.cart[index]["rate"].replaceAll("₹", "").split("-")[0])+double.parse(UserData.cart[index]["rate"].replaceAll("₹", "").split("-")[UserData.cart[index]["rate"].replaceAll("₹", "").split("-").length-1]))/2
                               };
                            })
                           ));
                            Navigator.of(context).push(route);

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,

                                borderRadius: BorderRadius.circular(20)
                            ),
                            width: (MediaQuery.of(context).size.width/2)-30,
                            child: Center(
                              child: Text(
                                "Buy Now",
                                style: TextStyle(
                                  fontSize: 15,
                                  color:Colors.white,

                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
