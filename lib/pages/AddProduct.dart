import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_portal/Datas/UserData.dart';
import 'package:farmer_portal/pages/SelectProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController rate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text("Add Products"),
      ),
      body: Builder(
        builder: (context){
          return Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom:18.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          height: 1,
                        ),
                    ),   

               

              UserData.product==null? Padding(
                 padding: const EdgeInsets.only(bottom:12.0),
                 child: ListTile(
                   leading:Icon(Icons.category,color: Theme.of(context).primaryColor,),
                   title: Text("Select Product"),
                   trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,),
                   onTap: (){
                     var route = CupertinoPageRoute(builder: (context)=>SelectProduct(
                       products: HomePageState.legume+ HomePageState.fruits+HomePageState.green_vegetables+HomePageState.leaf_vegetables+HomePageState.others+
                                 HomePageState.spinach_vegetables+HomePageState.root_vegetables+HomePageState.recommanded+HomePageState.spinach_vegetables+HomePageState.cereal
                                 +HomePageState.rice,

                       ));
                     Navigator.push(context, route);
                   },
                 ),
               ):Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(image:Image.asset(UserData.product["image"]).image,height: 80,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0,bottom: 8),
                                      child: Text(UserData.product["name"],style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: SafeArea(child: Container(width: MediaQuery.of(context).size.width-180, child: Text(UserData.product["use"],maxLines: 3,))),
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
                               

                                 // CircleAvatar(radius: 12,backgroundColor: Colors.pink.withOpacity(0.2),child: Text("${UserData.cart[i]["amount"]}kg",style: TextStyle(fontSize: 9,color: Colors.black),),),

                               

                                ],
                              ),
                            ),

                            IconButton(icon: Icon(CupertinoIcons.clear_circled_solid,color: Colors.red,),onPressed: (){
                              UserData.product = null;
                              setState(() {

                              });
                             



                            },)
                          ],
                        ),

                       
                      ],
                    ),
                  ),
                ),
               Divider(),

                Padding(
                 padding: const EdgeInsets.only(bottom:12.0),
                 child: ListTile(
                   leading:Icon(Icons.line_weight,color: Theme.of(context).primaryColor,),
                   title: TextField(
                     
                     keyboardType: TextInputType.number,
                     controller: weight,
                 
                     decoration:InputDecoration(
                       
                       hintText: "Weight in kg",

                      //  suffixIcon: IconButton(icon:Icon(I),onPressed: (){},)
                     ),
                   ),
                 ),
               ),


               Padding(
                 padding: const EdgeInsets.only(bottom:12.0),
                 child: ListTile(
                   leading:Icon(Icons.monetization_on,color: Theme.of(context).primaryColor,),
                   title: TextField(
                     
                     keyboardType: TextInputType.number,
                     controller: rate,
                     
                 
                     decoration:InputDecoration(
                      
                       hintText: "Rate per kg",

                      //  suffixIcon: IconButton(icon:Icon(I),onPressed: (){},)
                     ),
                   ),
                 ),
               ),

                   Padding(
                            padding: const EdgeInsets.only(left:18.0,right: 18.0,top: 80),
                            child: Material(


                              borderRadius: BorderRadius.circular(20),
                              elevation: 2,
                              child: Container(

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                    Color(0xff288a3a),
                                
                                ),

                                height: 48,
                                child: ClipRRect(

                                  borderRadius: BorderRadius.circular(20),
                                  
                                  child: MaterialButton(
                                    child: Center(
                                      child: Text(
                                        "SUBMIT",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18
                                        ),
                                      ),
                                    ),
                                    onPressed: (){

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

                                                try{
                                                   if(!(int.parse(rate.text)>0 || int.parse(weight.text)>0)){
                                                      throw 1;

                                                   }
                                                    
                                                    if(UserData.product==null){
                                                      throw 1;
                                                    }
                                            
                                                    Firestore.instance.collection("Products").add({
                                                         "product":UserData.product,
                                                         "rate":int.parse(rate.text),
                                                         "weight":  int.parse(weight.text),
                                                         "number":UserData.number,
                                                         "location":UserData.city,
                                                         "name":UserData.name
                                                    });
                                                   Scaffold.of(context).showSnackBar(SnackBar(content: Text("Added Successfully"),));      
                                                   name.clear();
                                                   rate.clear();
                                                   weight.clear();
                                                }catch(e){
                                                   Scaffold.of(context).showSnackBar(SnackBar(content: Text("Invalid Credientials"),));      
                                                }

                                                Navigator.of(context).pop();
                                                
                                               
                                              
                                               },
                                             ),
                                             
                                           ],
                                           
                                         );
                                       }
                                     );

                                   

                                    },
                                  ),
                                )
                              ),
                            ),
                          ),

                  ])
                  )
                  )
                  )
                  ]
                  );
        },
      ),
    );
  }
}


