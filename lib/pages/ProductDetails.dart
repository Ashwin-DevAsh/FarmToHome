
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_portal/DataBase/DataBaseHelper.dart';
import 'package:farmer_portal/Datas/UserData.dart';
import 'package:farmer_portal/pages/BuyPage.dart';
import 'package:farmer_portal/pages/Login.dart';
import 'package:farmer_portal/pages/Sellers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';

class ProductDetails extends StatefulWidget {
  var product;
  ProductDetails({this.product});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var weight = 1;
  var rate = "Not Available";
  TextEditingController weightContorller = TextEditingController();
  @override
  void initState() {
    weightContorller.text = "1kg";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{

          if(await DataBaseHelper.store.record("fav").exists(DataBaseHelper.db)){
                                             DataBaseHelper.store.record("fav").update(DataBaseHelper.db,UserData.fav);
                                            DataBaseHelper.store.record("favItem").update(DataBaseHelper.db, UserData.favItem);
                                    }else{
                                      DataBaseHelper.store.record("fav").add(DataBaseHelper.db,UserData.fav);
                                      DataBaseHelper.store.record("favItem").add(DataBaseHelper.db, UserData.favItem);
                                    }
   
         return true;
       },
          child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title:Text(widget.product["name"]),
        ),
        body: Builder(

          builder: (context) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      
                      children: <Widget>[
                        Container(
                         
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[

                              IconButton(icon:(UserData.fav.contains(widget.product["name"]))?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border,color: Colors.grey,),iconSize: 30,onPressed: ()async{
                                   if(UserData.fav.contains(widget.product["name"])){
                                        UserData.fav.remove(widget.product["name"].toString());
                                         UserData.favItem = UserData.favItem.where((item)=>item["name"].toString()!=widget.product["name"].toString()).toList();
                                   }else{
                                         UserData.fav.add(widget.product["name"]);
                                         UserData.favItem.add(widget.product);

                                   }
                                   setState(() {

                                   });

                              },)

                          ],),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:15.0,bottom: 8),
                          child: Container(
                              child: Image.asset(widget.product["image"]),
                            height: 200,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:18.0,top: 8,bottom: 8,right: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FutureBuilder<Object>(
                                key: UniqueKey(),
                                future: Firestore.instance.collection("Products").where("product.name",isEqualTo:widget.product["name"].toString().trim()).getDocuments(),
                                builder: (context,AsyncSnapshot snapshot) {

                                  print(widget.product["name"]);

                                 

                                  if( snapshot.hasError){

                                     return Text(
                                       
                                    "Not Avaliable",
                                      key: UniqueKey(),
                                    style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.red
                                    ),
                                   );



                                  }

                                  if( !snapshot.hasData){

                                     return Text(
                                       
                                    "Loading...",
                                      key: UniqueKey(),
                                    style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Theme.of(context).primaryColor.withOpacity(0.9)
                                    ),
                                   );



                                  }
                                  List data = snapshot.data.documents;

                                

                                  if(data.length==0){

                                     return Text(
                                       
                                    "Not Available",
                                      key: UniqueKey(),
                                    style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.red
                                    ),
                                   );

                                  }

                                  var hPrice = 0.0;
                                  var lPrice = data[0]["rate"]+0.0;

                                  for(var i in data){
                                    if(i["rate"]>hPrice){
                                      hPrice = i["rate"].toDouble();
                                    }
                                    if(i["rate"]<lPrice){
                                      lPrice = i["rate"].toDouble();
                                    }
                                  }

                                  rate = "₹"+(lPrice*weight).toString() +(((lPrice*weight)!=(hPrice*weight))?(" - "+ "₹"+(hPrice*weight).toString()):"");

                                  return Text(
                                    "₹"+(lPrice*weight).toString() +(((lPrice*weight)!=(hPrice*weight))?(" - "+ "₹"+(hPrice*weight).toString()):""),
                                      key: UniqueKey(),
                                    style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                      fontSize: 23
                                    ),
                                  );
                                }
                              ),
                              Row(
                                children: <Widget>[
                                  GestureDetector(

                                    child: Padding(
                                      padding: const EdgeInsets.only(right:5.0),
                                      child: CircleAvatar(radius: 12,backgroundColor: Colors.green.withOpacity(0.2),child: Text("+",style: TextStyle(fontSize: 15,color: Colors.black),),),
                                    ),
                                    onTap: (){
                                      setState(() {
                                        weight=weight+1;
                                      });
                                    },
                                  ),

                                 Container(
                                           
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.pink.withOpacity(0.2)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:Text("${weight}kg",style: TextStyle(fontSize: 9,color: Colors.black),),
                                          ),
                                        ),
                                      //   

                                //  CircleAvatar(radius: 15,backgroundColor: Colors.pink.withOpacity(0.2),child: Text("${weight}kg",style: TextStyle(fontSize: 9,color: Colors.black),),),

                                  GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:5.0),
                                      child: CircleAvatar(radius: 12,backgroundColor: Colors.red.withOpacity(0.2),child: Text("-",style: TextStyle(fontSize: 15,color: Colors.black),),),
                                    ),

                                    onTap: (){
                                      setState(() {
                                        if(weight>1)
                                        weight=weight-1;
                                      });
                                    },
                                  ),

                                ],
                              )
                            ],
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:18.0,bottom: 8,right: 5),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                          
                            
                             
                             child:    Text(widget.product["use"],style: TextStyle(),maxLines: 10,)
                            
                          ),
                        ),
                        Divider(),
                      
                        ListTile(
                          onTap: (){
                            var route = CupertinoPageRoute(builder: (context)=>Sellers(name:widget.product["name"] ,));
                            Navigator.push(context, route);
                          },
                          leading:Icon(Icons.person,),
                          title: Text("Direct Buy",style: TextStyle(fontWeight: FontWeight.w600),),
                          trailing: Icon(Icons.arrow_forward_ios,size: 18,),
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Nutrition facts",style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top:10.0,bottom: 20),
                            child: Table(
                              border: TableBorder.all(width: 1,color: Colors.grey),
                              children: List.generate(widget.product["nutritional facts"].length, (i){
                                return  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(widget.product["nutritional facts"].keys.toList()[i].toString().trim()),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(widget.product["nutritional facts"].values.toList()[i].toString().trim()),
                                      )
                                    ]
                                );
                              })
                              
                              
                            ),
                          ),
                        )





                      ],
                    ),
                  ),),
                   Material(
                     elevation: 10,
                     child: GestureDetector(
                       onTap: (){
                         if(rate=="Not Available"){
                           Scaffold.of(context).showSnackBar(SnackBar(
                             content: Text("Stock not Available"),
                           ));
                           return;
                         }
                         DataBaseHelper.store.record("Cart").exists(DataBaseHelper.db).then((isexist){
                           widget.product.addAll({"amount":"$weight","rate":rate});
                           if(isexist){
                             DataBaseHelper.store.record("Cart").get(DataBaseHelper.db).then((data){
                               DataBaseHelper.store.record("Cart").update(DataBaseHelper.db, data+[widget.product]);
                               UserData.cart =  data+[widget.product];
                             });
                           }else{
                             DataBaseHelper.store.record("Cart").add(DataBaseHelper.db, [widget.product]);
                             UserData.cart =  [widget.product];
                           }
                         });

                         Scaffold.of(context).showSnackBar(SnackBar(content: Text("Added Successfully"),));
                       
                       },
                       child: Container(
                         width: MediaQuery.of(context).size.width,
                         height: 55,
                         child: Center(
                           child: Row(
                             children: <Widget>[
                               Container(
                                 width: MediaQuery.of(context).size.width/2,
                                 child: Center(
                                   child: Text(
                                     "Add to Cart",
                                     style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,

                                     ),
                                   ),
                                 ),
                               ),

                               GestureDetector(
                                 onTap: (){
                                   if(UserData.number==""){
                                     Scaffold.of(context).showSnackBar(SnackBar(content: Text("Login Needed"),action: SnackBarAction(label:"LOGIN",onPressed: (){
                                       var route = CupertinoPageRoute(builder: (context)=>LogIn());
                                       Navigator.of(context).push(route);

                                     },),));

                                     return;
                                   }

                                   if(rate=="Not Available"){
                                     Scaffold.of(context).showSnackBar(SnackBar(
                                       content: Text("Stock not Available"),
                                     ));
                                     return;
                                   }

                                   var route = CupertinoPageRoute(builder: (context)=>Buy(data:{
                                     "name": widget.product["name"],
                                     "location":UserData.address,
                                     "weight":weight,
                                     "rate":(double.parse(rate.replaceAll("₹", "").split("-")[0])+double.parse(rate.replaceAll("₹", "").split("-")[rate.replaceAll("₹", "").split("-").length-1]))/2
                                   }));

                                   Navigator.of(context).push(route);
                                 },
                                                                child: Padding(
                                   padding: const EdgeInsets.all(8.0),
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

                       ),
                     ),
                   )
                ],
              ),
            );
          }
        ) ,
      ),
    );
  }
}
