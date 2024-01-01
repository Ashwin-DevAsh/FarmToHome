import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_portal/Datas/UserData.dart';
import 'package:farmer_portal/pages/AddProduct.dart';
import 'package:farmer_portal/pages/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageProducts extends StatefulWidget {
  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text("My Products"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: (){
          var route = CupertinoPageRoute(builder: (context)=>AddProduct());
          Navigator.push(context, route);
        },
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("Products").where("number",isEqualTo: UserData.number).snapshots(),
        builder: (context,snap){
            if(snap.hasError){
              return Center();
            }

            if(!snap.hasData){
              return Center();

            }

            List data = snap.data.documents;

            return ListView.builder(itemCount: data.length ,physics: BouncingScrollPhysics(),itemBuilder: (context,i){
              return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(image:Image.asset(HomePageState.allImages[data[i]["product"]["name"]]).image,height: 80,)
                                ),
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
                                          child: Text(data[i]["product"]["name"],style: TextStyle(fontWeight: FontWeight.bold),),
                                        ),
                                         Padding(
                                        padding: const EdgeInsets.only(left:8.0,bottom: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.pink.withOpacity(0.2)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("${data[i]["weight"].toString()}kg",style: TextStyle(fontSize: 9,color: Colors.black),),
                                          ),
                                        )
                                        
                                        // CircleAvatar(radius: 12,backgroundColor: Colors.pink.withOpacity(0.2),child: Padding(
                                        //   padding: const EdgeInsets.all(2.0),
                                        //   child: Text("${data[i]["weight"].toString()}kg",style: TextStyle(fontSize: 9,color: Colors.black),),
                                        // ),),
                                      ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: SafeArea(child: Container(width: MediaQuery.of(context).size.width-180, child: Text(HomePageState.allUses[data[i]["product"]["name"]],maxLines: 4,overflow: TextOverflow.ellipsis,))),
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
                              padding: const EdgeInsets.only(top:8.0,bottom: 8),
                              child: Row(
                                children: <Widget>[

                                   Padding(
                                      padding: const EdgeInsets.only(left:3.0,top: 10),
                                      child: Row(
                                        children: <Widget>[
                                          Text("Price : "+data[i]["rate"].toString()+"₹",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),),
                                          Text("    ( 1kg )",style: TextStyle(fontSize: 12,color: Colors.grey),)
                                         

                                        ],
                                      ),
                                    ),
                                  

                                ],
                              ),
                            ),

                            IconButton(icon: Icon(CupertinoIcons.clear_circled_solid,color: Colors.red,),onPressed: (){
                              showCupertinoDialog(
                                       context: context,
                                       builder: (cnt){
                                         return CupertinoAlertDialog(
                                           
                                           title: Text("Are You Sure?"),
                                           actions: <Widget>[
                                             CupertinoDialogAction(
                                               child: Text("No",style: TextStyle(color: Theme.of(context).primaryColor),),
                                               onPressed: (){
                                                 Navigator.pop(cnt);
                                               },
                                             ),
                       
                                             CupertinoDialogAction(
                                               child: Text("Yes",style: TextStyle(color: Theme.of(context).primaryColor)),
                                                onPressed: (){

                                                   Firestore.instance.collection("Products").document(data[i].documentID).delete();
                                                       setState(() {
                         
                                                          
                                                       });
                                                   Navigator.of(context).pop(); 

                                                   Scaffold.of(context).showSnackBar(SnackBar(content: Text("Deleted Successfully"),));   
                                               
                                              
                                               },
                                             ),
                                             
                                           ],
                                           
                                         );
                                       }
                                     );
                             
                          



                            },)
                          ],
                        ),

                        Divider()
                      ],
                    ),
                  ),
                );
            },);
        },
      )
    );
  }
}
