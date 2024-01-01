import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_portal/DataBase/AppDataBase.dart';
import 'package:farmer_portal/DataBase/DataBaseHelper.dart';
import 'package:farmer_portal/Datas/UserData.dart';
import 'package:farmer_portal/pages/Category.dart';
import 'package:farmer_portal/pages/Iot.dart';
import 'package:farmer_portal/pages/Login.dart';
import 'package:farmer_portal/pages/ManageProducts.dart';
import 'package:farmer_portal/pages/NearByShops.dart';
import 'package:farmer_portal/pages/Orders.dart';
import 'package:farmer_portal/pages/ProductDetails.dart';
import 'package:farmer_portal/pages/SearchProduct.dart';
import 'package:farmer_portal/pages/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var index = 0;
  var pageIndex = 0;
  var page = ["Home","Favourite"];

  var hidden = true;

  var language = 0;

  
  IconData  visibility = Icons.visibility_off;




  Future loadData()async{
    DataBaseHelper.db = await AppDatabase.instance.database;
    DataBaseHelper.store = StoreRef.main();

     var data = await DataBaseHelper.store.record("UserData").get(DataBaseHelper.db);
      if(data!=null){
         UserData.name = data[0];
         UserData.password = data[1];
         UserData.number = data[2];
         UserData.address = data[3];
         UserData.city = data[4];
         UserData.isFarmer = data[5];
      }
     var lang = await DataBaseHelper.store.record("lang").get(DataBaseHelper.db);
      if(lang!=null){
          language=lang;
      }  

    print("hello");  

    if(await DataBaseHelper.store.record("fav").exists(DataBaseHelper.db)){
    UserData.fav.addAll(await DataBaseHelper.store.record("fav").get(DataBaseHelper.db));
    UserData.favItem.addAll(await DataBaseHelper.store.record("favItem").get(DataBaseHelper.db));
    }

    print(UserData.fav);

    if(await DataBaseHelper.store.record("Cart").exists(DataBaseHelper.db))
    UserData.cart.addAll(await DataBaseHelper.store.record("Cart").get(DataBaseHelper.db));

  }

  Future favData()async{
    return  DataBaseHelper.store.record("favItem").get(DataBaseHelper.db);
  }

  @override
  void initState() {

    for(Map i in recommanded+root_vegetables+leaf_vegetables+green_vegetables+legume+fruits+others+spinach_vegetables+cereal +rice){
      allImages[i["name"]] = i["image"];
       allUses[i["name"]] = i["use"];
    }

       WidgetsBinding.instance.addPostFrameCallback((_){
    loadData().then((_){
      super.initState();
      setState(() {
        
      });

    });
          
          });

  }

  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController controller = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    List<Widget> pages = [
      Column(children: <Widget>[
        Container(


          child: Column(children: <Widget>[


            Padding(
                padding: const EdgeInsets.only(left:10.0,right:10.0,top:30),
                child: Container(
                  height: 48,
                  color: Colors.white,
                  child:
                  TextField(

                    controller: controller,

                    onSubmitted: (text){
                      var allProducts = [];
                      allProducts.addAll(recommanded+root_vegetables+leaf_vegetables+green_vegetables+legume+fruits+others+spinach_vegetables+cereal+rice);
                      allProducts = allProducts.where((item)=>item["name"].toString().toLowerCase().contains(text.toLowerCase().trim())).toList();
                      var route = CupertinoPageRoute(builder: (context)=>SearchProduct(products: allProducts,));

                      controller.text="";

                      Navigator.of(context).push(route);

                    },

                    onChanged: (text)async{
                       
                    },

                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                         suffixIcon: IconButton(icon: Icon(CupertinoIcons.clear_circled_solid),onPressed: (){
                                                 
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

            child:Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15))
              ),
              child: ListView(

                  physics: BouncingScrollPhysics(),
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.only(left:18.0,bottom: 5),
                      child: Text("Category",style: TextStyle(fontWeight: FontWeight.bold)),
                    ),

                    Container(

                      height: 150,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(10),
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                             Padding(
                            padding: const EdgeInsets.only(left:10.0,top: 10),
                            child: GestureDetector(
                              onTap: (){
                                var route = CupertinoPageRoute(builder: (context)=>Category(products: root_vegetables,category: "Root Vegetables",));
                                Navigator.of(context).push(route);
                              },
                                child: Material(


                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 80,
                                  width: 140,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child:   Image(image: Image.asset("lib/assets/root.png").image,height: 30,)
                                      ),
                                      Expanded(child: Center(),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Root Vegetables",style: TextStyle(fontSize: 12),),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.arrow_forward_ios,size: 12,),
                                          )
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                                        Padding(
                            padding: const EdgeInsets.only(left:18.0,top: 10),
                            child: GestureDetector(
                               onTap: (){
                                 var route = CupertinoPageRoute(builder: (context)=>Category(products: cereal,category: "Cereals",));
                                 Navigator.push(context, route);
                               },

                                    child: Material(


                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 80,
                                  width: 140,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child:   Image(image: Image.asset("lib/assets/cereals.png").image,height: 30,)
                                      ),
                                      Expanded(child: Center(),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Cereals",style: TextStyle(fontSize: 12),),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(right:8.0),
                                            child: Icon(Icons.arrow_forward_ios,size: 12,),
                                          )
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:18.0,top: 10),
                            child: GestureDetector(
                               onTap: (){
                                 var route = CupertinoPageRoute(builder: (context)=>Category(products: rice,category: "Rice",));
                                 Navigator.push(context, route);
                               },

                                    child: Material(


                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 80,
                                  width: 140,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child:   Image(image: Image.asset("lib/assets/cerials.png").image,height: 30,)
                                      ),
                                      Expanded(child: Center(),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Rice",style: TextStyle(fontSize: 12),),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(right:8.0),
                                            child: Icon(Icons.arrow_forward_ios,size: 12,),
                                          )
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                       
                          Padding(
                            padding: const EdgeInsets.only(left:16.0,top: 10),
                            child: GestureDetector(
                              onTap: (){

                                  var route = CupertinoPageRoute(builder: (context)=>Category(products: spinach_vegetables,category: "Spinach",));
                                  Navigator.of(context).push(route);

                              },
                                                          child: Material(


                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 80,
                                  width: 140,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child:   Image(image: Image.asset("lib/assets/spinach.png").image,height: 30,)
                                      ),
                                      Expanded(child: Center(),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Spinach",style: TextStyle(fontSize: 12),),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.arrow_forward_ios,size: 12,),
                                          )
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:18.0,top: 10),
                            child: GestureDetector(
                                onTap: (){
                                  var route = CupertinoPageRoute(builder: (context)=>Category(products: leaf_vegetables,category: "Leaf Vegetables"));
                                  Navigator.push(context, route);
                                },
                                                          child: Material(


                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 80,
                                  width: 140,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child:   Image(image: Image.asset("lib/assets/leaf.png").image,height: 30,)
                                      ),
                                      Expanded(child: Center(),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Leaf Vegetables",style: TextStyle(fontSize: 12),),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.arrow_forward_ios,size: 12,),
                                          )
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:18.0,top: 10),
                            child: GestureDetector(
                              onTap: (){
                                  var route = CupertinoPageRoute(builder: (context)=>Category(products: legume,category: "Legumes"));
                                  Navigator.push(context, route);
                                },

                                                          child: Material(


                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 80,
                                  width: 140,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child:   Image(image: Image.asset("lib/assets/tubers.png").image,height: 30,)
                                      ),
                                      Expanded(child: Center(),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Legumes",style: TextStyle(fontSize: 12),),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.arrow_forward_ios,size: 12,),
                                          )
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:18.0,top: 10),
                            child: GestureDetector(
                               onTap: (){
                                 var route = CupertinoPageRoute(builder: (context)=>Category(products: green_vegetables,category: "Green Vegetables",));
                                 Navigator.push(context, route);
                               },

                                    child: Material(


                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 80,
                                  width: 140,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child:   Image(image: Image.asset("lib/assets/flower.png").image,height: 30,)
                                      ),
                                      Expanded(child: Center(),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Green Vegetables",style: TextStyle(fontSize: 12),),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(right:8.0),
                                            child: Icon(Icons.arrow_forward_ios,size: 12,),
                                          )
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                            Padding(
                            padding: const EdgeInsets.only(left:18.0,top: 10),
                            child: GestureDetector(
                               onTap: (){
                                 var route = CupertinoPageRoute(builder: (context)=>Category(products: fruits,category: "Fruits",));
                                 Navigator.push(context, route);
                               },

                                    child: Material(


                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 80,
                                  width: 140,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child:   Image(image: Image.asset("lib/assets/fruits.png").image,height: 30,)
                                      ),
                                      Expanded(child: Center(),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Fruits",style: TextStyle(fontSize: 12),),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(right:8.0),
                                            child: Icon(Icons.arrow_forward_ios,size: 12,),
                                          )
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                           Padding(
                            padding: const EdgeInsets.only(left:18.0,top: 10),
                            child: GestureDetector(
                               onTap: (){
                                 var route = CupertinoPageRoute(builder: (context)=>Category(products: others,category: "Others",));
                                 Navigator.push(context, route);
                               },

                                    child: Material(


                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 80,
                                  width: 140,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child:   Image(image: Image.asset("lib/assets/Other.png").image,height: 30,)
                                      ),
                                      Expanded(child: Center(),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Others",style: TextStyle(fontSize: 12),),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(right:8.0),
                                            child: Icon(Icons.arrow_forward_ios,size: 12,),
                                          )
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:18.0,bottom: 10,top: 15),
                      child: Text("Recommended Stock",style: TextStyle(fontWeight: FontWeight.bold)),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.count(
                          crossAxisCount: 2,
                          physics: ScrollPhysics(), // to disable GridView's scrolling
                          shrinkWrap: true,
                          children: List.generate(recommanded.length, (i){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (){
                                  var route = CupertinoPageRoute(builder: (context)=>ProductDetails(product:recommanded[i]));
                                  Navigator.of(context).push(route);

                                },
                                child: Material(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 2,


                                  child: Stack(

                                    children: <Widget>[
                                      Image(image: Image.asset(recommanded[i]["image"]).image,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(

                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(recommanded[i]["name"],style: TextStyle(color: Colors.white),),
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
                    Padding(
                      padding: const EdgeInsets.only(left:18.0,top: 5),
                      child: Text("Top Deals",style: TextStyle(fontWeight: FontWeight.bold)),
                    ),

                    CarouselSlider.builder(
                        autoPlay: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                         
                        autoPlayInterval: Duration(seconds: 3),
                        
                       itemCount: images.length,
                       itemBuilder: (BuildContext context, int i) =>
                            Container(
                                child: GestureDetector(
                              onTap: (){

                                // var route = CupertinoPageRoute(builder: (context)=>ProductDetails(product:images[i]));
                                // Navigator.of(context).push(route);

                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left:.0,top: 20,bottom: 10),
                                child: Container(
                                
                                  child: Material(


                                    elevation: 2,

                                    child: Stack(
                                      children: <Widget>[
                                        Image.asset(images[i],fit: BoxFit.fill,),
                                        Container(
                                          width: 250,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(

                                                decoration: BoxDecoration(

                                                  color: Color(0xff288a3a),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("Buy now!",style: TextStyle(color: Colors.white),),

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
                            ),
                            ),
                       ),

                    // Container(

                    //     height: 230.4,
                    //     child: ListView(
                    //       physics: BouncingScrollPhysics(),
                    //       padding: EdgeInsets.all(10),
                    //       scrollDirection: Axis.horizontal,
                    //       children:List.generate(images.length, (i){
                    //         return  GestureDetector(
                    //           onTap: (){

                    //             // var route = CupertinoPageRoute(builder: (context)=>ProductDetails(product:images[i]));
                    //             // Navigator.of(context).push(route);

                    //           },
                    //           child: Padding(
                    //             padding: const EdgeInsets.only(left:10.0,top: 10),
                    //             child: Material(


                    //               elevation: 2,

                    //               child: Stack(
                    //                 children: <Widget>[
                    //                   Image.asset(images[i],fit: BoxFit.fill,),
                    //                   Container(
                    //                     width: 300,
                    //                     child: Column(
                    //                       crossAxisAlignment: CrossAxisAlignment.start,
                    //                       mainAxisAlignment: MainAxisAlignment.end,
                    //                       children: <Widget>[
                    //                         Container(

                    //                           decoration: BoxDecoration(

                    //                             color: Color(0xff288a3a),
                    //                           ),
                    //                           child: Padding(
                    //                             padding: const EdgeInsets.all(8.0),
                    //                             child: Text("Buy now!",style: TextStyle(color: Colors.white),),

                    //                           ),


                    //                         )


                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       }


                    //       ),
                    //     )),





                  ]
              ),
            )
        )
      ],),
      Container(

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

                    controller: controller,

                    onSubmitted: (text){
                      var allProducts = [];
                      allProducts.addAll(recommanded+root_vegetables+leaf_vegetables+green_vegetables+legume+fruits+others+spinach_vegetables+cereal+rice);
                      allProducts = allProducts.where((item)=>item["name"].toString().toLowerCase().contains(text.toLowerCase().trim())).toList();
                      var route = CupertinoPageRoute(builder: (context)=>SearchProduct(products: allProducts,));

                      controller.text="";

                      Navigator.of(context).push(route);

                    },

                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                         suffixIcon: IconButton(icon: Icon(CupertinoIcons.clear_circled_solid),onPressed: (){
                                                 
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

            ),
                  
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
                          borderRadius: BorderRadius.only(topRight: Radius.circular(15)),
                          color: Colors.white
                        ),
                                      child: Padding(
                                        padding: const  EdgeInsets.only(left:0.0,right:0.0,top:0),
                                        child: FutureBuilder(
                                          future: StoreRef.main().record("favItem").get(DataBaseHelper.db),
                                          initialData: [],
                                          builder: (context, snapshot) {
                                            

                                            if( snapshot.hasError ){
                                                     return Center(child: Text("No Favourite Found"),);
                                            }

                                            

                                            if(snapshot.data == null){
                                              return Center(child: Text("No Favourite Found"),);

                                            }

                                            if(UserData.fav.length==0){
                                              return Center(child: Text("No Favourite Found"),);

                                            }

                                            var data = snapshot.data;


                                            
                                            return GridView.count(
                                              
                                              crossAxisCount: 2,
                                              physics:BouncingScrollPhysics(), // to disable GridView's scrolling
                                              shrinkWrap: true,
                                              children: List.generate(data.length, (i){
                                                return Padding(
                                                  padding: const EdgeInsets.only(left:12.0,right: 12,bottom: 24),
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      var route = CupertinoPageRoute(builder: (context)=>ProductDetails(product:data[i]));
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
                                                          
                                                          ,child: Image(image: Image.asset(data[i]["image"]).image,)),
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: <Widget>[
                                                              Container(
                                                                

                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Text(data[i]["name"],style: TextStyle(color: Colors.white),),
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
                                  );
                                          }
                                        ),
                                      ),
                                    ),
                                ),
          ],
        ),
      ),
      

    ];
    return WillPopScope(
      onWillPop: ()async{
        if(index==0){
        return true;
        }else{
          index = 0;
          pageIndex=0;
          setState(() {

          });
          return false;
        }

      },
      child: Scaffold(

          drawer: Drawer(
            child: NestedScrollView(
              physics: BouncingScrollPhysics(),
               headerSliverBuilder: (context,_){
                 return [
                   SliverAppBar(
                     expandedHeight: 140.0,
                     floating: false,
                     pinned: true,

                     leading: Center(),
                     flexibleSpace: FlexibleSpaceBar(
                         centerTitle: true,
                         title: Text("Hello ${UserData.name}!",
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 16.0,
                             )),
                         background: Image.asset(
                           "lib/assets/bg.jpeg",
                           fit: BoxFit.cover,
                         )),

                   )
                 ];
               },
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[

                  ListTile(
                    title: Text("Today's Deals"),
                    trailing: Icon(Icons.arrow_forward_ios,size: 14,color: Colors.black,),
                    onTap: (){},
                  ),
                  Divider(),

                  ListTile(
                    title: Text("Your Orders"),
                    trailing: Icon(Icons.arrow_forward_ios,size: 14,color: Colors.black,),
                    onTap: (){
                      var route = CupertinoPageRoute(builder: (context)=>Orders());
                      Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    title: Text("Nearby shops"),
                    trailing: Icon(Icons.arrow_forward_ios,size: 14,color: Colors.black,),
                    onTap: (){
                      var route = CupertinoPageRoute(builder: (context)=>NearByShops());
                      Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    title: Text("History"),
                    trailing: Icon(Icons.arrow_forward_ios,size: 14,color: Colors.black,),
                    onTap: (){},
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Language"),
                    trailing: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                        value: language,
                        onChanged: (_){
                            setState(() {
                              language=_;
                            });
                        },
                        items: [
                          DropdownMenuItem(child: Text("English",style: TextStyle(fontSize: 12),),value: 0,),
                           DropdownMenuItem(child: Text("தமிழ்",style: TextStyle(fontSize: 12),),value: 1,),
                            DropdownMenuItem(child: Text("हिंदी",style: TextStyle(fontSize: 12),),value: 2,)
                        ],
                      ),
                    ),  // Icon(Icons.arrow_forward_ios,size: 14,color: Colors.black,),
                    onTap: (){},
                  ),
                  ListTile(
                    title: Text("Your Notifications"),
                    trailing: Icon(Icons.arrow_forward_ios,size: 14,color: Colors.black,),
                    onTap: (){},
                  ),
                  ListTile(
                    title: Text("Settings"),
                    trailing: Icon(Icons.arrow_forward_ios,size: 14,color: Colors.black,),
                    onTap: (){},
                  ),
                  Divider(),
                  
                   UserData.name==""? ListTile(
                    title: Text("Login"),
                    trailing: Icon(Icons.arrow_forward_ios,size: 14,color: Colors.black,),
                    onTap: (){
                       var route = CupertinoPageRoute(builder: (context)=>LogIn());
                       Navigator.push(context, route);
                    },
                  ):(!UserData.isFarmer? ListTile(
                  
                      title: Text("Activate Seller Account",),
                      
                      onTap: (){

                      },

                      trailing: Switch(
                        value: UserData.isFarmer,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (_){
                          showCupertinoDialog(context: context, builder: (context){
                            return CupertinoAlertDialog(
                              title: Text("Are You Sure"),
                              actions: <Widget>[
                                  CupertinoButton(
                                    child: Text("Yes Am Sure",style: TextStyle(color: Theme.of(context).primaryColor),),
                                    onPressed: (){
                                      UserData.isFarmer = true;
                                      Firestore.instance.collection("Users").where("number",isEqualTo:UserData.number).getDocuments().then((data){
                                        var user = data.documents[0].documentID;
                                        Firestore.instance.collection("Users").document(user).updateData({"isSeller":true});
                                        DataBaseHelper.store.record("UserData").update(DataBaseHelper.db, [UserData.name,UserData.password,UserData.number,UserData.address,UserData.city,true]);

                                      });
                                      setState(() {


                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                CupertinoButton(
                                  child: Text("No Am Not",style: TextStyle(color: Theme.of(context).primaryColor),),
                                  onPressed: (){
                                    UserData.isFarmer = false;
                                    setState(() {

                                    });
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          });

                        },
                      ),
                    ):Column(
                      children: <Widget>[
                        ListTile(
                       
                          title: Text("Manage IOT",style: TextStyle(fontWeight: FontWeight.w600),),
                          onTap: (){
                            var route = CupertinoPageRoute(builder: (context)=>Iot());
                            Navigator.of(context).push(route);
                          },

                          trailing: Icon(Icons.arrow_forward_ios,size: 15,color: Colors.black,),
                        ),

                        ListTile(
                       
                          title: Text("Manage Products",style: TextStyle(fontWeight: FontWeight.w600),),
                          onTap: (){
                            var route = CupertinoPageRoute(builder: (context)=>ManageProducts());
                            Navigator.of(context).push(route);
                          },

                          trailing: Icon(Icons.arrow_forward_ios,size: 15,color: Colors.black,),
                        ),

                      ],

                    )),
                  UserData.name!=""? ListTile(
                    title: Text("Logout"),
                    trailing: Icon(Icons.arrow_forward_ios,size: 14,color: Colors.black,),
                    onTap: (){

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
                                       onPressed: ()async{
                                           UserData.name = "";
                                          UserData.address = "";
                                          UserData.password = "";
                                          UserData.number = "";
                                          UserData.city = "";
                                          UserData. isFarmer = false;
                                          UserData.firebaseId=null;
                                          UserData. cart = [];
                                          UserData. fav = [];
                                          UserData. favItem = [];
                                          UserData.product = null;
                                          await DataBaseHelper.store.record("UserData").delete(DataBaseHelper.db);
                                          await DataBaseHelper.store.record("Cart").delete(DataBaseHelper.db);
                                          setState(() {
                                            
                                           });
                                        Navigator.of(context).pop();
                                    
                                     
                                    
                                   
                                    },
                                  ),
                                  
                                ],
                                
                              );
                            }
                          );

                    
                      
                    },
                  ):Center(),
                  ListTile(
                    title: Text("Help"),
                    trailing: Icon(Icons.arrow_forward_ios,size: 14,color: Colors.black,),
                    onTap: (){},
                  ),
                



                ],
              ),
            )
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (i){
               
                  index = i;
                  setState(() {
                    
                  });

            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  title: Text("Favourite")
              ),

            ],
          ),
          body: Builder(

            builder: (ctx) {
              return Container(
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
                          title: Text(page[index]),

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

                  body: pages[index]

                ),
              );
            }
          )

      ),
    );
  }

  List topDeals = List.generate(10, (i)=>{
    "name" : "product-${i+1}",
    "image" : "lib/assets/product-${i+1}.jpg"
  });



static var root_vegetables = [ 

 { "name" : "Beetroot" , "image" : "lib/assets/Root/1.jpg", "use" : " Used in the treatment of liver diseases and fatty liver. Also help lower levels of fats in the blood, lower blood pressure, improve athletic performance, and reduce muscle soreness.", "nutritional facts" : {"Carbohydrates" : "9.56g" , "Proteins" : "1.61g" , "Fats" : "0.17g" , "Energy" : "43kcal"  }} ,
 { "name" : "Carrot" , "image"  : "lib/assets/Root/2.jpg" , "use" : "Carrots are about 10% carbs, consisting of starch, fiber, and simple sugars. They are extremely low in fat and protein.", "nutritional facts" : {"Carbohydrates" : "9.6g" , "Proteins" : "0.9g" , "Fats" : "0.2g" , "Energy" : "41kcal"  }  } ,
 { "name" : "Turnip" , "image" : "lib/assets/Root/3.jpg" , "use" : "Turnips vitamin and antioxidant contents may provide anti-inflammatory, anticancer, and antibacterial effects, among other benefits." , "nutritional facts" : {"Carbohydrates" : "4.4g" , "Proteins" : "1.1g" , "Fats" : "0.2g" , "Energy" : "20kcal"  } } ,
 { "name" : "SweetPotato" , "image"  : "lib/assets/Root/4.jpg" , "use" : "Contains fiber and antioxidants that promote the growth of good gut bacteria and contribute to a healthy gut.  ", "nutritional facts" : {"Carbohydrates" : "20.7g" , "Proteins" : "2.0g" , "Fats" : "0.15g" , "Energy" : "90kcal"  } } ,
 { "name" : "Parsnips" , "image"  : "lib/assets/Root/6.jpg" , "use" : "High in antioxidants including vitamin C and polyacetylenes that may prevent oxidative stress and chronic conditions like cancer, diabetes, and heart disease. ", "nutritional facts" : {"Carbohydrates" : "18g" , "Proteins" : "1.2g" , "Fats" : "0.2g" , "Energy" : "75kcal"  }  } ,
 { "name" : "Onion" , "image" : "lib/assets/Root/7.jpg" , "use" : "Eating onions may help reduce heart disease risk factors, such as high blood pressure, elevated triglyceride levels and inflammation.", "nutritional facts" : {"Carbohydrates" : "9.34g" , "Proteins" : "1.1g" , "Fats" : "0.1g" , "Energy" : "40kcal"  } } ,
 { "name" : "Radish" , "image"  : "lib/assets/Root/8.jpg", "use" : "Low-calorie, high-fiber vegetable that contains plant compounds that may help protect against conditions like heart disease, diabetes, and certain cancers.", "nutritional facts" : {"Carbohydrates" : "3.4g" , "Proteins" : "0.68g" , "Fats" : "0.1g" , "Energy" : "16kcal"  }  } ,
 { "name" : "Ginger" , "image"  : "lib/assets/Root/9.jpg" , "use" : "Ginger appears to be effective at reducing the day-to-day progression of muscle pain, and may reduce exercise-induced muscle soreness.", "nutritional facts" : {"Carbohydrates" : "17.77g" , "Proteins" : "1.82g" , "Fats" : "0.75g" , "Energy" : "80kcal"  } } ,
 { "name" : "Turmeric" , "image"  : "lib/assets/Root/10.jpg" , "use" : "Have anti-tumor, antioxidant, anti-arthritic, anti-amyloid, anti-ischemic, and anti-inflammatory properties.", "nutritional facts" : {"Carbohydrates" : "64.9g" , "Proteins" : "7.83g" , "Fats" : "9.88g" , "Energy" : "354kcal"  }  }  ];
static var green_vegetables = [
{"name" : "Snakegourd" ,   "image" : "lib/assets/Green/1.jpeg", "use" : "Best remedy for arterial disorders like palpitation and other conditions like pain and stress on the heart. " , "nutritional facts" : {"Carbohydrates" : "4g" , "Proteins" : "1.1g" , "Fats" : "0.2g" , "Energy" : "20kcal"  }  },
{"name" : "Bottlegourd" ,   "image" : "lib/assets/Green/2.jpg", "use" : "Have cancer-fighting properties and could be effective against stomach, colon, lung, nasopharynx, and breast cancer cells." , "nutritional facts" : {"Carbohydrates" : "3.69g" , "Proteins" : "0.6g" , "Fats" : "0.02g" , "Energy" : "15kcal"  }       },
{"name" : "Cucumber" ,   "image" : "lib/assets/Green/3.png", "use" : "Cucumbers contain antioxidants, including flavonoids and tannins, which prevent the accumulation of harmful free radicals and may reduce the risk of chronic disease." , "nutritional facts" : {"Carbohydrates" : "3.63g" , "Proteins" : "0.65g" , "Fats" : "0.11g" , "Energy" : "16kcal"  }  },
{"name" : "Pumpkin" ,   "image" : "lib/assets/Green/4.jpg" , "use" : "Pumpkins high vitamin A, lutein and zeaxanthin contents may protect your eyes against sight loss, which becomes more common with age." , "nutritional facts" : {"Carbohydrates" : "6.5g" , "Proteins" : "1g" , "Fats" : "0.1g" , "Energy" : "26kcal"  } },
{"name" : "Beans" ,   "image" : "lib/assets/Green/6.jpg"  , "use" : "Beans may aid weight loss due to their high protein and fiber content, which can keep you feeling full for longer." , "nutritional facts" : {"Carbohydrates" : "22g" , "Proteins" : "6g" , "Fats" : "5g" , "Energy" : "20kcal"  } },
{"name" : "Lady's Finger" ,   "image": "lib/assets/Green/7.jpg", "use" : "Rich in antioxidants that may reduce your risk of serious diseases, prevent inflammation, and contribute to overall health.." , "nutritional facts" : {"Carbohydrates" : "7.46g" , "Proteins" : "1.9g" , "Fats" : "0.19g" , "Energy" : "33kcal"  } },
{"name" : "Avarakkai" ,   "image" : "lib/assets/Green/8.jpg" , "use" : "Incredibly nutritious and an excellent source of soluble fiber, protein, folate, manganese, copper and several other micronutrients." , "nutritional facts" : {"Carbohydrates" : "34g" , "Proteins" : "13g" , "Fats" : "0.9g" , "Energy" : "35kcal"  } },
{"name" : "Greenpeas" ,   "image" : "lib/assets/Green/11.jpg" , "use" : "Green peas are rich in fiber, which benefits digestion by maintaining the flow of waste through your digestive tract and keeping gut bacteria healthy." , "nutritional facts" : {"Carbohydrates" : "60g" , "Proteins" : "25g" , "Fats" : "0.2g" , "Energy" : "120kcal"  } } ];

static var  leaf_vegetables = [

{ "name" : "Spinach" , "image" : "lib/assets/Leaf/1.jpg", "use" : "Reduce oxidative stress, promote eye health, fight cancer, and regulate blood pressure." , "nutritional facts" : {"Carbohydrates" : "3.6g" , "Proteins" : "2.9g" , "Fats" : "0.4g" , "Energy" : "23kcal"  } } ,
{ "name" : "Cabbage" , "image" : "lib/assets/Leaf/2.jpg" , "use" : "Cabbage contains insoluble fiber, which keeps the digestive system healthy by providing fuel for friendly bacteria and promoting regular bowel movements." , "nutritional facts" : {"Carbohydrates" : "5.8g " , "Proteins" : "1.28g" , "Fats" : "0.1g" , "Energy" : "25kcal"  } } ,
{ "name" : "Lettuce" , "image" : "lib/assets/Leaf/3.jpg", "use" : "Potassium may help reduce high blood pressure levels. Eating potassium-rich foods like red leaf lettuce may stabilize your blood pressure." , "nutritional facts" : {"Carbohydrates" : "2.23g" , "Proteins" : "1.35g" , "Fats" : "0.22g" , "Energy" : "13kcal"  }   } ,
{ "name" : "Broccoli" , "image" : "lib/assets/Leaf/4.jpg" , "use" : "Broccolis isothiocyanates may improve many risk factors for disease and reduce your risk of cancer. Whats more, this vegetable may help lower cholesterol and boost eye health." , "nutritional facts" : {"Carbohydrates" : "6.64g" , "Proteins" : "2.82g" , "Fats" : "0.37g" , "Energy" : "34kcal"  } } ,
{ "name" : "Curryleaves" , "image" : "lib/assets/Leaf/5.jpg" , "use" : "used as a herb in Ayurvedic and Siddha medicine in which they are believed to possess anti-disease properties" , "nutritional facts" : {"Carbohydrates" : "31.6g" , "Proteins" : "15.9g" , "Fats" : "6.2g" , "Energy" : "50kcal"  } } , 
{ "name" : "Corianderleaves" ,"image" : "lib/assets/Leaf/6.jpg", "use" : "It is a good source of antioxidants. Using cilantro to flavor food may encourage people to use less salt and reduce their sodium intake." , "nutritional facts" : {"Carbohydrates" : "3.67g" , "Proteins" : "2.13g" , "Fats" : "0.52g" , "Energy" : "22kcal"  }  } ,
{ "name" : "Cauliflower" , "image" : "lib/assets/Leaf/7.jpg" , "use" : "Cauliflower contains a high amount of fiber, which is important for digestive health and may reduce the risk of several chronic diseases." , "nutritional facts" : {"Carbohydrates" : "5g" , "Proteins" : "1.9g" , "Fats" : "0.3g" , "Energy" : "25kcal"  }  }];

static List recommanded = [

{ "name" : "Capsicum" , "image" : "lib/assets/product-1.jpg" , "use" : "Have many health benefits. These include improved eye health and reduced risk of anemia. ", "nutritional facts" : {"Carbohydrates" : "4.64g" , "Proteins" : "0.87g" , "Fats" : "0.17g" , "Energy" : "20kcal"  } } ,
{ "name" : "Strawberry" , "image" : "lib/assets/product-2.jpg", "use" : "Strawberries may decrease your risk of heart disease and cancer, as well as help regulate blood sugar. ", "nutritional facts" : {"Carbohydrates" : "7.68g" , "Proteins" : "0.67g" , "Fats" : "0.3g" , "Energy" : "33kcal"  }  } ,
{ "name" : "Tomato" , "image" : "lib/assets/product-5.jpg" , "use" : "reduce your risk of heart disease and several cancers. This fruit is also beneficial for skin health, as it may protect against sunburns. ", "nutritional facts" : {"Carbohydrates" : "3.9g" , "Proteins" : "0.9g" , "Fats" : "0.2g" , "Energy" : "18kcal"  } } ,
{ "name" : "Carrot" , "image" : "lib/assets/product-7.jpg" , "use" : "Carrots are about 10% carbs, consisting of starch, fiber, and simple sugars. They are extremely low in fat and protein. ", "nutritional facts" : {"Carbohydrates" : "9.6g" , "Proteins" : "0.9g" , "Fats" : "0.2g" , "Energy" : "41kcal"  } } ,
{ "name" : "Broccoli" , "image" : "lib/assets/product-6.jpg", "use" : "Broccolis isothiocyanates may improve many risk factors for disease and reduce your risk of cancer. Whats more, this vegetable may help lower cholesterol and boost eye health.", "nutritional facts" : {"Carbohydrates" : "6.64g" , "Proteins" : "2.82g" , "Fats" : "0.37g" , "Energy" : "34kcal"  }  } , 
{ "name" : "Onion" ,"image" : "lib/assets/product-9.jpg", "use" : "Eating onions may help reduce heart disease risk factors, such as high blood pressure, elevated triglyceride levels and inflammation." , "nutritional facts" : {"Carbohydrates" : "9.34g" , "Proteins" : "1.1g" , "Fats" : "0.1g" , "Energy" : "40kcal"  } } ,
{ "name" : "Apple" , "image" : "lib/assets/product-10.jpg", "use" : "apples may help protect against diabetes, heart disease, and cancer.", "nutritional facts" : {"Carbohydrates" : "13.81g" , "Proteins" : "0.26g" , "Fats" : "0.17g" , "Energy" : "52kcal"  } } ,
{ "name" : "Garlic" , "image" : "lib/assets/product-11.jpg" , "use" : "Garlic supplements help prevent and reduce the severity of common illnesses like the flu and common cold. ","nutritional facts" : {"Carbohydrates" : "33.06g" , "Proteins" : "6.36g" , "Fats" : "0.5g" , "Energy" : "149kcal"  } } ,
{ "name" : "Chilli" , "image" : "lib/assets/product-12.jpg" , "use" : "They may promote weight loss when combined with other healthy lifestyle strategies and may help relieve pain caused by acid reflux. ", "nutritional facts" : {"Carbohydrates" : "8.8g" , "Proteins" : "1.9g" , "Fats" : "0.4g" , "Energy" : "40kcal"  } } ,
{ "name" : "Peas" , "image" : "lib/assets/product-3.jpg" , "use" : "peas are rich in fiber, which benefits digestion by maintaining the flow of waste through your digestive tract and keeping gut bacteria healthy." , "nutritional facts" : {"Carbohydrates" : "60g" , "Proteins" : "25g" , "Fats" : "2g" , "Energy" : "120kcal"  } } ,
{ "name" : "Red Cabbage" , "image" : "lib/assets/product-4.jpg" , "use" : "Cabbage contains insoluble fiber, which keeps the digestive system healthy by providing fuel for friendly bacteria and promoting regular bowel movements." , "nutritional facts" : {"Carbohydrates" : "5.8g" , "Proteins" : "1.28g" , "Fats" : "0.1g" , "Energy" : "25kcal"  } } 
];

static var  others = [ 
 
{ "name" : "Tomato" , "image" : "lib/assets/Other/1.jpg", "use" : "Tomatoes reduce your risk of heart disease and several cancers. This fruit is also beneficial for skin health, as it may protect against sunburns.", "nutritional facts" : {"Carbohydrates" : "3.9g" , "Proteins" : "0.9g" , "Fats" : "0.2g" , "Energy" : "18kcal"  }  } ,
{ "name" : "Brinjal" , "image" : "lib/assets/Other/2.jpg" , "use" : "Improve heart function and reduce LDL cholesterol and triglyceride levels, though human research is needed.", "nutritional facts" : {"Carbohydrates" : "5.88g" , "Proteins" : "0.98g" , "Fats" : "0.18g" , "Energy" : "25kcal"  } } ,
{ "name" : "Drumstick" ,"image" : "lib/assets/Other/3.jpg" , "use" : "Lead to reduced blood sugar levels, also has anti-inflammatory properties.", "nutritional facts" : {"Carbohydrates" : "8.28g" , "Proteins" : "9.40g" , "Fats" : "1.40g" , "Energy" : "64kcal"  } } ,
{ "name" : "Potato" , "image" : "lib/assets/Other/4.jpg" , "use" : "Potatoes are a good source of several vitamins and minerals, including potassium, folate, and vitamins C and B6.", "nutritional facts" : {"Carbohydrates" : "17g" , "Proteins" : "2g" , "Fats" : "0.09g" , "Energy" : "18kcal"  } } ,
{ "name" : "Coconut" , "image" : "lib/assets/Other/5.jpg" , "use" : "Eating coconut may improve cholesterol levels and help decrease belly fat, which is a risk factor for heart disease.", "nutritional facts" : {"Carbohydrates" : "15g" , "Proteins" : "2.3g" , "Fats" : "0.9g" , "Energy" : "32kcal"  } } ,
{ "name" : "Raw mango" , "image" : "lib/assets/Other/6.jpg" , "use" :  "Raw mangoes are often prescribed to people with morning sickness, constipation, diarrhoea, chronic dyspepsia and indigestion.", "nutritional facts" : {"Carbohydrates" : "15g" , "Proteins" : "0.8g" , "Fats" : "0.4g" , "Energy" : "50kcal"  } }  ];

static List spinach_vegetables = [
{ "name" : "Hummingbird Tree Leaves" , "image" : "lib/assets/Spinach/1.jpg" ,"use":"Bark, leaves, gums, and flowers are considered medicinal. The astringent bark was used in treating smallpox and other eruptive fevers. The juice from the flowers is used to treat headache, head congestion, or stuffy nose.", "nutritional facts" : {"Carbohydrates" : "12 g" , "Proteins" : "0 g" , "Fats" : "0 %" , "Energy" : "27 kcal"  }},
{ "name" : "Half Lettuce" , "image" : "lib/assets/Spinach/2.jpg","use":"A tea made from the leaves is believed to have antibiotic, anthelmintic, antitumour and contraceptive properties. The bark is considered as a tonic and an antipyretic, a remedy for gastric troubles, colic with diarrhoea and dysentery. A bark decoction is taken orally to treat fever and diabetes.","nutritional facts":{"Carbohydrates" : "6 g" , "Proteins" : "3.5 g" , "Fats" : "0 %" , "Energy" : "60 kcal"  }},
{ "name" : "Drumstick Leaves" , "image" : "lib/assets/Spinach/3.jpg","use":"Juice of drumstick leaves are useful in reducing body heat and thus used in treating heat related problems like hair loss, tiredness and eye sores. Take Drumstick leaves along with pure ghee to stimulate the blood circulation in the body to induce the re growth of hair follicles." , "nutritional facts" : {"Carbohydrates" : "11g" , "Proteins" : "5 g" , "Fats" : "1g" , "Energy" : "60kcal"  }},
{ "name" : "Purple Amarnath" , "image" : "lib/assets/Spinach/4.jpg","use":" This variety of spinach is called as the Queen  of all the spinach varieties.  The best quality of nutrition like lactose, fiber and 80% ofwater content are present in this variety. It makes the body strong and healthy. It promotes child growth.  The magnificentvalues present in this spinach cures many rare diseases.", "nutritional facts" : {"Carbohydrates" : "15g" , "Proteins" : "1.4g" , "Fats" : "0.4g" , "Energy" : "42 kcal"  }},
{ "name" : "Heart Seed" , "image" : "lib/assets/Spinach/5.jpg" ,"use":"The leaves, roots, seeds and the baby leaves of this plant are all used for kaleidoscopic medicinal purposes.  Mudakathan keerai or leaves has strong anti-inflammatory properties. It gives noticeable relief in patients of arthritis, joint pain and even gout patients. The oil made out of this herb can be used externally.", "nutritional facts" : {"Carbohydrates" : "9g" , "Proteins" : "5g" , "Fats" : "1g" , "Energy" : "61kcal"  }},
{ "name" : "Black Nightshade" , "image" : "lib/assets/Spinach/6.jpg" ,"use":"It reduces the body heat and prevents diseases that are caused by excessive heat. Manathakkali keerai acts as a medicine to treat dropsy. For acne, eczema and psoriasis solanum nigrum is the best medicine prescribed by grandmothers The small berries of the herb is used as a good cure for asthma and fever.", "nutritional facts" : {"Carbohydrates" : "9g" , "Proteins" : "6g" , "Fats" : "1g" , "Energy" : "68 kcal"  }},
{ "name" : "Dwarf Copper Leaves" ,"image" : "lib/assets/Spinach/7.jpg","use":"In Indian medicine ponnanganni keerai is used as a cholagogue, gastrointestinal agent, which stimulates the bile flow (bile is an emulsifying agent produced in the liver which aids digestion of fats).", "nutritional facts" : {"Carbohydrates" : "12g" , "Proteins" : "5g" , "Fats" : "1g" , "Energy" : "73kcal"  } },
{ "name" : "Brown Indian Hemp" ,"image" : "lib/assets/Spinach/8.jpg","use":"Nutritional Benifits of Gongura Leaves It is a low calorie food that is highly nutritious and has several medicinal benefits too. Vitamins: It is an excellent source of vitamin A, vitamin B1 (thiamin), vitamin B2 (riboflavin), vitamin B9 (folic acid) and vitamin C.", "nutritional facts" : {"Carbohydrates" : "10g" , "Proteins" : "2g" , "Fats" : "1g" , "Energy" : "56kcal"  }},
{ "name" : "Tropical Amarnath" , "image" : "lib/assets/Spinach/9.jpg","use":"It has a power of curing poisonous insect bites. Trash, gallbladder disease , phthisis, eye diseases , wounds, strangury and food poisoning are cured by adding Tropical amaranth. The laxative, diuretic and refrigerant properties are present in it. 100 grams of siru keerai contains the following nutritional values.", "nutritional facts" : {"Carbohydrates" : "3 g" , "Proteins" : "4 g" , "Fats" : "1 g" , "Energy" : "34 kcal"  }},
{ "name" : "Indian Pennywort" , "image" : "lib/assets/Spinach/10.jpg","use":"It helps to improve memory and concentration span. Vallarai has calming effect on brain during mental stress and anxiety and found to be useful in the treatment of Insomnia, depression and Alzheimer's disease. Vallarai a blood purifier, used for treating high blood pressure and said to promote longevity.", "nutritional facts" : {"Carbohydrates" : "15g" , "Proteins" : "0.8g" , "Fats" : "0.4g" , "Energy" : "50kcal"  }} ];

static List fruits = [
{"name" : "Apple" , "image" : "lib/assets/Fruits/1.jpg","use":"Apples have been linked to a lower risk of heart disease . One reason may be that apples contain soluble fiber  the kind that can help lower your blood cholesterol levels. ... Flavonoids can help prevent heart disease by lowering blood pressure, reducing bad LDL oxidation, and acting as antioxidants .", "nutritional facts" : {"Carbohydrates" : "14g" , "Proteins" : "0.3g" , "Fats" : "0 g" , "Energy" : "52 kcal"  }} ,
{ "name" : "Banana" ,"image" : "lib/assets/Fruits/2.jpg","use":"Bananas are respectable sources of vitamin C.Manganese in bananas is good for your skin.Potassium in bananas is good for your heart health and blood pressure.Bananas can aid digestion and help beat gastrointestinal issues.Bananas give you energy  minus the fats and cholesterol", "nutritional facts" : {"Carbohydrates" : "23g" , "Proteins" : "1.1 g" , "Fats" : "0.3 g" , "Energy" : "80 kcal"  }} ,
{ "name" : "Mango" , "image" : "lib/assets/Fruits/3.jpg","use":"Helps in digestion. Mangoes could help facilitate healthy digestion.Promotes Healthy Gut. Boosts Immunity. Promotes eye health. Lowers Cholesterol. Clears the Skin. Even Diabetics Could Enjoy it. Aids Weight Loss.", "nutritional facts" : {"Carbohydrates" : "15g" , "Proteins" : "0.8g" , "Fats" : "0 g" , "Energy" : "60kcal"  }} ,
{ "name" : "Orange" , "image" : "lib/assets/Fruits/4.jpg","use":"Sweet orange is a fruit. The peel and juice are used to make medicine. Sweet orange is most commonly used for high cholesterol, high blood pressure, and stroke prevention. Some people use it in aromatherapy to help with anxiety, depression, and sleep.", "nutritional facts" : {"Carbohydrates" : "12g" , "Proteins" : "0.9g" , "Fats" : "0.1g" , "Energy" : "47kcal"  }} ,
{ "name" : "Pomegranate" , "image" : "lib/assets/Fruits/5.jpg" ,"use":"Pomegranate contains more than 100 phytochemicals. The pomegranate fruit has been used for thousands of years as medicine.Antioxidants. Vitamin C. Cancer prevention. Alzheimer's disease protection. Digestion. Anti-inflammatory. Arthritis. Heart disease.", "nutritional facts" : {"Carbohydrates" : "19g" , "Proteins" : "1.7g" , "Fats" : "1.2g" , "Energy" : "83 kcal"  }} ,
{ "name" : "Watermelon" , "image" : "lib/assets/Fruits/6.jpg" ,"use":"benefits of the watermelon include promoting a healthy complexion and hair, increased energy, and overall lower weight.Asthma prevention. Blood pressure. Cancer. Digestion and regularity. Hydration. Inflammation. Muscle soreness. Skin.", "nutritional facts" : {"Carbohydrates" : "8g" , "Proteins" : "0.6g" , "Fats" : "0.2g" , "Energy" : "30kcal"  }} ,
{ "name" : "Sweetlime" , "image" : "lib/assets/Fruits/7.jpg" ,"use":"It helps in combating infections, treating ulcer and wounds, improves blood circulation and boost the immune system and fights cancer cell formation. The antiseptic and anti-bacterial properties of sweet lime make it an ideal choice of fruit for many beauty care therapies that improves the hair and skin health", "nutritional facts" : {"Carbohydrates" : "7g" , "Proteins" : "0.5g" , "Fats" : "0.1g" , "Energy" : "20kcal"  }} ,
{ "name" : "Chikoo" , "image": "lib/assets/Fruits/8.jpg","use":"According to the International Journal of Food Science and Nutrition, the high content of tannins makes sapota or chikoo an important anti-inflammatory agent, which helps in improving the condition of the digestive tract through prevention of diseases like esophagitis, enteritis, irritable bowel syndrome, and gastritis " , "nutritional facts" : {"Carbohydrates" : "20g" , "Proteins" : "0.4g" , "Fats" : "1.1g" , "Energy" : "83kcal"  }} ,
{ "name" : "Violetgrapes" , "image" : "lib/assets/Fruits/11.jpg","use":"A study done by the University of Michigan Cardiovascular Center suggests that the intake of black grapes may protect one against metabolic syndrome-related organ damage. Metabolic syndrome is a cluster of conditions that occur together - increased blood pressure, a high blood sugar level, excess body fat around the waist or low HDL (the good cholesterol) and increased blood triglycerides - significantly increasing the risk for heart disease, stroke and Type 2 diabetes.", "nutritional facts" : {"Carbohydrates" : "17g" , "Proteins" : "0.6g" , "Fats" : "0.4g" , "Energy" : "67kcal"  } }  ];

static List legume = [

{ "name" : "Split Gram"   , "image" : "lib/assets/Legume/1.jpg","use":"It is called thuvaram paruppu in Tamil Nadu, thuvara parippu in Kerala and is the main ingredient for the dish sambar. In Karnataka it is called togari bele and is an important ingredient in bisi bele bath. It is called kandi pappu in Telugu and is used in the preparation of a staple dish pappu charu. ", "nutritional facts" : {"Carbohydrates" : "93g" , "Proteins" : "15g" , "Fats" : "1g" , "Energy" : "400kcal"  }} ,
{ "name" : "Bengal Gram" , "image" : "lib/assets/Legume/2.jpg" ,"use":" Bengal gram has good amount of iron, sodium, selenium and small amount of copper zinc and manganese. They are a rich source of protein. 2. They are also a very good source of folic acid and fiber and contain phytochemicals called saponins, which can act as antioxidants.", "nutritional facts" : {"Carbohydrates" : "9g" , "Proteins" : "2g" , "Fats" : "9g" , "Energy" : "197kcal"  }} ,
{ "name" : "Urad Dal" , "image" : "lib/assets/Legume/3.png" ,"use":" Urad dal benefits the health as it has both soluble and insoluble fiber which is good for digestion and also prevents constipation. cardiovascular health through increasing blood circulation. Urad dal is considered as a natural aphrodisiac as it treats sexual dysfunction.", "nutritional facts" : {"Carbohydrates" : "58.99g" , "Proteins" : "25.21g" , "Fats" : "1.64g" , "Energy" : "314kcal"  } }  ,
{ "name" :"Missori Lentil" , "image" : "lib/assets/Legume/4.jpg" ,"use":"Helps Stabilise Blood Sugar Level.Keeps The Heart Healthy by Lowering Cholesterol.Effective Remedy Against Weight Loss.Anti-Ageing Properties. Nourishes Teeth and Bones.Helpful In Maintaining A Healthy Vision.Beneficial For A Glowing And Radiating Skin ", "nutritional facts" : {"Carbohydrates" : "63.35g" , "Proteins" : "24.63g" , "Fats" : "1.06g" , "Energy" : "352kcal"  } },
{ "name" : "White Chickpea" , "image" : "lib/assets/Legume/5.jpg" ,"use":" As a rich source of vitamins, minerals and fiber, chickpeas may offer a variety of health benefits, such as improving digestion, aiding weight management and reducing the risk of several diseases. Additionally, chickpeas are high in protein and make an excellent replacement for meat in vegetarian and vegan diets.", "nutritional facts" : {"Carbohydrates" : "24g" , "Proteins" : "10g" , "Fats" : "4g" , "Energy" : "165kcal"  } }, 
{ "name" : "Black Chickpea" ,"image" : "lib/assets/Legume/6.jpg" ,"use":"Black chickpea or kala chana is popularly known as a good source of protein. It can be added to your daily diet to control diabetes and blood sugar levels naturally. Most people consume boiled kala chana every morning as it offers numerous health benefits. ", "nutritional facts" : {"Carbohydrates" : "62.62g" , "Proteins" : "23.86g" , "Fats" : "1.15g" , "Energy" : "347kcal"  } },
{ "name" : "Greengram" , "image" : "lib/assets/Legume/9.jpg" ,"use":"Mung beans are high in nutrients and antioxidants, which may provide health benefits. In fact, they may protect against heat stroke, aid digestive health, promote weight loss and lower bad LDL cholesterol, blood pressure and blood sugar levels. ", "nutritional facts" : {"Carbohydrates" : "17g" , "Proteins" : "0.6g" , "Fats" : "0.4g" , "Energy" : "67kcal"  } },
{ "name" : "Roasted Gram" ,"image" : "lib/assets/Legume/7.jpg" ,"use":" Roasted gram / pottukadala is a very popular snack in India. Roasted gram is known by various names across India like pottukdalai,pottukadala,porikadala etc Like all the other varieties of legumes, roasted gram also rich in protein, fiber, minerals and fatty acids. Roasted gram is very low in calorie and rich.", "nutritional facts" : { "Carbohydrates" : "9g" , "Proteins" : "2g" , "Fats" : "9g" , "Energy" : "197kcal"   } } ];

static List cereal = [


{ "name" : "Wheat" , "image" : "lib/assets/Cereals/2.jpg" ,"use":" Wheat grain is a staple food used to make flour for leavened, flat and steamed breads, biscuits, cookies, cakes, breakfast cereal, pasta, noodles, couscous. It can also be fermented to make ethanol, for alcoholic drinks, or biofuel. ", "nutritional facts" : { "Carbohydrates" : "29g" , "Proteins" : "5g" , "Fats" : "0g" , "Energy" : "135kcal"   } } ,
{ "name" : "Maize" , "image" : "lib/assets/Cereals/3.jpg" ,"use":" Maize has become a staple food in many parts of the world, with the total production of maize surpassing that of wheat or rice. However, little of this maize is consumed directly by humans: most is used for corn ethanol, animal feed and other maize products, such as corn starch and corn syrup. ", "nutritional facts" : { "Carbohydrates" : "5g" , "Proteins" : "0g" , "Fats" : "0g" , "Energy" : "24 kcal"   } }  ,
{ "name" : "Oats" , "image" : "lib/assets/Cereals/4.jpg" ,"use":" Oats have many uses in food. Most of the time they are rolled or crushed into oatmeal, or ground into oat flour. Oatmeal is also eaten as porridge, but may also be used in many of baked goods, such as oat cakes, oatmeal cookies, and oat bread. ","nutritional facts" : { "Carbohydrates" : "33g" , "Proteins" : "8g" , "Fats" : "3g" , "Energy" : "194kcal"   } },
{ "name" : "Sorghum" , "image" : "lib/assets/Cereals/5.jpg" ,"use":" Sorghum is used for food, fodder, and the production of alcoholic beverages. It is drought-tolerant and heat-tolerant, and is especially important in arid regions. It is an important food crop in Africa, Central America, and South Asia, and is the fifth most important cereal crop grown in the world. ", "nutritional facts" : { "Carbohydrates" : "143g" , "Proteins" : "21g" , "Fats" : "6g" , "Energy" : "651kcal"   } }];


static List rice = [
{ "name" : "Raw Rice" , "image" : "lib/assets/Cereals/1.jpg" ,"use":" The health benefits of rice are such that it helps in providing energy, prevents obesity, controls blood pressure, prevents cancer, provides skin care, prevents Alzheimer's Disease, has Diuretic & Digestive Qualities, improves metabolism, boosts cardiovascular health, relieves the symptoms of Irritable Bowel Syndrome.", "nutritional facts" : { "Carbohydrates" : "148g" , "Proteins" : "12g" , "Fats" : "0g" , "Energy" : "640kcal"   } }  , 
{ "name" : "Steamed Rice" , "image" : "lib/assets/Cereals/1.jpg" ,"use":" Cooked rice is used as a base for various fried rice dishes , rice bowls/plates , rice porridges , rice balls/rolls, as well as rice cakes and desserts.", "nutritional facts" : { "Carbohydrates" : "34g" , "Proteins" : "3.2g" , "Fats" : "0.3g" , "Energy" : "151kcal"   } }  , 
{ "name" : "Brownrice" ,"image" : "lib/assets/Rice/3.jpg", "use":" Brown rice's health benefits are partially due to the way it is prepared, according to the George Mateljan Foundation for the Worlds Healthiest Foods, which promotes the benefits of healthy eating. Brown rice is a whole grain, meaning that it contains three parts of the grain kernel: the outer, fiber-filled layer called the bran, the nutrient-rich core called the germ, and the starchy middle layer called the endosperm, according to the Harvard T. H. Chan School of Public Health (HSPH). The outer, inedible hull is removed. " ,"nutritional facts": { "Carbohydrates" : "54g" , "Proteins" : "6g" , "Fats" : "2g" , "Energy" : "277kcal"   } } ,
{ "name" : "Palakadmattarice" , "image" : "lib/assets/Rice/4.jpg" ,"use":" Matta Rice, also known as Rosematta rice, Palakkadan Matta rice, Kerala Red rice or Red Parboiled rice, is locally sourced from the Palakkad region of Kerala, India. Used in a wide variety of foods, Matta rice can be had as plain rice, or be used to make idlis, appams and snacks like murukku and kondattam. ","nutritional facts" : { "Carbohydrates" : "77g" , "Proteins" : "8g" , "Fats" : "0g" , "Energy" : "349kcal"   } } ,
{ "name" : "Blackrice" ,"image" : "lib/assets/Rice/6.jpg", "use":" Is A Rich Source Of Antioxidants. When it comes to antioxidant content, no other ingredient comes close to black rice.Fights Cancer.Reduces Inflammation.Aids Weight Loss.Protects Heart Health.Helps In Liver Detoxification.Aids Healthy Brain Function.Helps Prevent Diabetes. ","nutritional facts" : { "Carbohydrates" : "72g" , "Proteins" : "9g" , "Fats" : "2g" , "Energy" : "366kcal"   } } ,
{ "name" : "Seeragasamba" , "image" : "lib/assets/Rice/7.jpg" ,"use":" Seeraga samba rice contains selenium which helps to prevent the cancer of colon and intestine. It has got more fiber and anti-oxidant which helps to remove free radicals from colon and intestine. It also has phytonutrients which help to fight breast cancer and strengthens the heart. ","nutritional facts" : { "Carbohydrates" : "80g" , "Proteins" : "6g" , "Fats" : "2g" , "Energy" : "360 kcal"   } } ,
{ "name" : "Ponnirice" , "image": "lib/assets/Rice/8.jpg" ,"use":"Ponni Rice is a rice variety developed by Tamil Nadu Agricultural University in 1986.Ponni rice has enormous health benefits especially for diabetics and high blood sugar patients:High fiber.Gluten free.Low glycemic index,thereby lowering the impact of raised blood sugar.Lowers cholesterol. ","nutritional facts" : { "Carbohydrates" : "34g" , "Proteins" : "3g" , "Fats" : "1g" , "Energy" : "160kcal"   } } ,
{ "name" : "Basmathirice" ,"image" : "lib/assets/Rice/5.jpg" ,"use":" These long and slender grains are known for their distinct aroma and are native to the Indian subcontinent. The word 'Basmati' has been actually derived from a Hindi word, which means 'fragrant'. It is commonly used for making royal biryanis but there's a lot more that you can do with Basmati rice. ", "nutritional facts" : { "Carbohydrates" : "148g" , "Proteins" : "0g" , "Fats" : "1g" , "Energy" : "675kcal"   } }];



// List root_vegetables = [

 

 

//  {"name": "பீட்ரூட்", "image": "lib/assets/Root/1.jpg", "use": "கல்லீரல் நோய்கள் மற்றும் கொழுப்பு கல்லீரல் சிகிச்சையில் பயன்படுத்தப்படுகிறது. மேலும் குறைந்த அளவிலான கொழுப்புகளுக்கு உதவுகிறது இரத்தம், இரத்த அழுத்தம் குறைதல், தடகள செயல்திறனை மேம்படுத்துதல் மற்றும் தசை வேதனையை குறைத்தல். "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 9.56 கிராம் "," புரதங்கள் ":" 1.61 கிராம் "," கொழுப்புகள் ":" 0.17 கிராம் " , "ஆற்றல்": "43 கிலோகலோரி"}}, 

// {"name": "கேரட்", "image": "lib/assets/Root/2.jpg", "use": "கேரட் சுமார் 10% கார்ப் ஆகும், இதில் ஸ்டார்ச், ஃபைபர் மற்றும் எளிய சர்க்கரைகள் உள்ளன. அவை. கொழுப்பு மற்றும் புரதத்தில் மிகக் குறைவு. "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 9.6 கிராம் "," புரதங்கள் ":" 0.9 கிராம் "," கொழுப்புகள் ":" 0.2 கிராம் "," ஆற்றல் ":" 41 கிலோகலோரி " }}, 

// {"name": "டர்னிப்", "image": "lib/assets/Root/3.jpg", "use": "டர்னிப்ஸின் வைட்டமின் மற்றும் ஆக்ஸிஜனேற்ற உள்ளடக்கங்கள் அழற்சி எதிர்ப்பு, ஆன்டிகான்சர் மற்றும் பாக்டீரியா எதிர்ப்பு விளைவுகளை வழங்கக்கூடும். பிற நன்மைகள். " , "ஊட்டச்சத்து உண்மைகள்": {"கார்போஹைட்ரேட்டுகள்": "4.4 கிராம்", "புரதங்கள்": "1.1 கிராம்", "கொழுப்புகள்": "0.2 கிராம்", "ஆற்றல்": "20 கிலோகலோரி"}}, 

// {"name": "ஸ்வீட் பொட்டாடோ", "image": "lib/assets/Root/4.jpg", "use": "நல்ல குடல் பாக்டீரியாக்களின் வளர்ச்சியை ஊக்குவிக்கும் மற்றும் ஆரோக்கியமான குடலுக்கு பங்களிக்கும் ஃபைபர் மற்றும் ஆக்ஸிஜனேற்றங்கள் உள்ளன. "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 20.7 கிராம் "," புரதங்கள் ":" 2.0 கிராம் "," கொழுப்புகள் ":" 0.15 கிராம் "," ஆற்றல் ":" 90 கிலோகலோரி "}}, 

// {"name": "பார்ஸ்னிப்ஸ்", "image": "lib/assets/Root/6.jpg", "use": "வைட்டமின் சி மற்றும் பாலிஅசைட்டிலின்கள் உள்ளிட்ட ஆக்ஸிஜனேற்றங்கள் அதிகம், அவை ஆக்ஸிஜனேற்ற அழுத்தத்தையும் புற்றுநோய் போன்ற நாட்பட்ட நிலைகளையும் தடுக்கக்கூடும். நீரிழிவு மற்றும் இதய நோய். "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 18 கிராம் "," புரதங்கள் ":" 1.2 கிராம் "," கொழுப்புகள் ":" 0.2 கிராம் "," ஆற்றல் ":" 75 கிலோகலோரி "}} , 

// {"name": "வெங்காயம்", "image": "lib/assets/Root/7.jpg", "use": "வெங்காயம் சாப்பிடுவது உயர் இரத்த அழுத்தம், உயர்த்தப்பட்ட ட்ரைகிளிசரைடு அளவு போன்ற இதய நோய் ஆபத்து காரணிகளைக் குறைக்க உதவும். மற்றும் வீக்கம். "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 9.34 கிராம் "," புரதங்கள் ":" 1.1 கிராம் "," கொழுப்புகள் ":" 0.1 கிராம் "," ஆற்றல் ":" 40 கிலோகலோரி "}}, 

// {"name": "முள்ளங்கி", "image": "lib/assets/Root/8.jpg", "use": "குறைந்த கலோரி, அதிக நார்ச்சத்துள்ள காய்கறி, இது தாவர கலவைகளைக் கொண்டுள்ளது, இது போன்ற நிலைமைகளுக்கு எதிராக பாதுகாக்க உதவும் இதய நோய், நீரிழிவு நோய் மற்றும் சில புற்றுநோய்கள். "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 3.4 கிராம் "," புரதங்கள் ":" 0.68 கிராம் "," கொழுப்புகள் ":" 0.1 கிராம் "," ஆற்றல் ":" 16 கிலோகலோரி "}}, 

// {"name": "இஞ்சி", "image": "lib/assets/Root/9.jpg", "use": "தசை வலியின் அன்றாட முன்னேற்றத்தைக் குறைப்பதில் இஞ்சி பயனுள்ளதாகத் தோன்றுகிறது, மற்றும் உடற்பயிற்சியால் தூண்டப்படும் தசை வேதனையை குறைக்கலாம். "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 17.77 கிராம் "," புரதங்கள் ":" 1.82 கிராம் "," கொழுப்புகள் ":" 0.75 கிராம் "," ஆற்றல் ":" 80 கிலோகலோரி "}}, 

// {"name": "மஞ்சள்", "image": "lib/assets/Root/10.jpg", "use": "கட்டி எதிர்ப்பு, ஆக்ஸிஜனேற்ற, ஆர்த்ரைடிக் எதிர்ப்பு, அமிலாய்டு எதிர்ப்பு, இஸ்கிமிக் எதிர்ப்பு, மற்றும் அழற்சி எதிர்ப்பு பண்புகள். "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 64.9 கிராம் "," புரதங்கள் ":" 7.83 கிராம் "," கொழுப்புகள் ":" 9.88 கிராம் "," ஆற்றல் ":" 354 கிலோகலோரி "} }];

 

// List v=[

// {"name": "புடலங்காய்", "image": "lib/assets/Green/1.jpeg", "use": "படபடப்பு போன்ற தமனி கோளாறுகள் மற்றும் இதயத்தில் வலி மற்றும் மன அழுத்தம் போன்ற பிற நிலைமைகளுக்கு சிறந்த தீர்வு." , "ஊட்டச்சத்து உண்மைகள்": {"கார்போஹைட்ரேட்டுகள்": "4 கிராம்", "புரதங்கள்": "1.1 கிராம்", "கொழுப்புகள்": "0.2 கிராம்", "ஆற்றல்": "20 கிலோகலோரி"}},

// {"name": "பாட்டில்கோர்ட்", "image": "lib/assets/Green/2.jpg", "use": "புற்றுநோயை எதிர்க்கும் பண்புகளைக் கொண்டிருங்கள் மற்றும் வயிறு, பெருங்குடல், நுரையீரல், நாசோபார்னக்ஸ் மற்றும் மார்பக புற்றுநோய் செல்கள். " , "ஊட்டச்சத்து உண்மைகள்":  {"கார்போஹைட்ரேட்டுகள்": "3.69 கிராம்", "புரதங்கள்": "0.6 கிராம்", "கொழுப்புகள்": "0.02 கிராம்", "ஆற்றல்": "15 கிலோகலோரி"}},

// {"name": "வெள்ளரி", "image": "lib/assets/Green/3.png", "use": "வெள்ளரிகளில் ஃபிளாவனாய்டுகள் மற்றும் டானின்கள் உள்ளிட்ட ஆக்ஸிஜனேற்றங்கள் உள்ளன, அவை தீங்கு விளைவிக்கும் இலவச தீவிரவாதிகள் குவிவதைத் தடுக்கின்றன மற்றும் இருக்கலாம் நாள்பட்ட நோயின் அபாயத்தைக் குறைக்கவும். " , "ஊட்டச்சத்து உண்மைகள்":  {"கார்போஹைட்ரேட்டுகள்": "3.63 கிராம்", "புரதங்கள்": "0.65 கிராம்", "கொழுப்புகள்": "0.11 கிராம்", "ஆற்றல்": "16 கிலோகலோரி"}},

// {"name": "பூசணி", "image": "lib/assets/Green/4.jpg", "use": "பூசணிக்காயின் உயர் வைட்டமின் ஏ, லுடீன் மற்றும் ஜீயாக்சாண்டின் உள்ளடக்கங்கள் பார்வை இழப்பிலிருந்து உங்கள் கண்களைப் பாதுகாக்கக்கூடும், இது வயதில் மிகவும் பொதுவானதாகிறது. " , "ஊட்டச்சத்து உண்மைகள்":  {"கார்போஹைட்ரேட்டுகள்": "6.5 கிராம்", "புரதங்கள்": "1 கிராம்", "கொழுப்புகள்": "0.1 கிராம்", "ஆற்றல்": "26 கிலோகலோரி"}},

// {"name": "பூசானிகாய்", "image": "lib/assets/Green/5.jpg", "use": "பூசணிக்காயின் உயர் வைட்டமின் ஏ, லுடீன் மற்றும் ஜீயாக்சாண்டின் உள்ளடக்கங்கள் பார்வை இழப்புக்கு எதிராக உங்கள் கண்களைப் பாதுகாக்கக்கூடும், இது வயதில் மிகவும் பொதுவானதாகிறது. " , "ஊட்டச்சத்து உண்மைகள்":  {"கார்போஹைட்ரேட்டுகள்": "6.5 கிராம்", "புரதங்கள்": "1 கிராம்", "கொழுப்புகள்": "0.1 கிராம்", "ஆற்றல்": "26 கிலோகலோரி"}},

// {"name": "பீன்ஸ்", "image": "lib/assets/green/6.jpg", "use": "பீன்ஸ் அதிக புரதம் மற்றும் ஃபைபர் உள்ளடக்கம் காரணமாக எடை இழப்புக்கு உதவக்கூடும், இது உங்களை உணர வைக்கும் நீண்ட நேரம் நிரம்பியுள்ளது. " , "ஊட்டச்சத்து உண்மைகள்": {"கார்போஹைட்ரேட்டுகள்": "22 கிராம்", "புரதங்கள்": "6 கிராம்", "கொழுப்புகள்": "5 கிராம்", "ஆற்றல்": "20 கிலோகலோரி"}},

// {"name": "லேடிஸ் ஃபிங்கர்", "image": "lib/assets/Green/7.jpg", "use": "ஆக்ஸிஜனேற்றிகளில் பணக்காரர், இது உங்கள் கடுமையான நோய்களின் அபாயத்தைக் குறைக்கும், வீக்கத்தைத் தடுக்கலாம், மேலும் பங்களிக்கலாம் ஒட்டுமொத்த ஆரோக்கியம் .. "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 7.46 கிராம் "," புரதங்கள் ":" 1.9 கிராம் "," கொழுப்புகள் ":" 0.19 கிராம் "," ஆற்றல் ":" 33 கிலோகலோரி "}},

// {"name": "அவாரக்காய்", "image": "lib/assets/Green/8.jpg", "use": "நம்பமுடியாத அளவிற்கு சத்தான மற்றும் கரையக்கூடிய நார், புரதம், ஃபோலேட், மாங்கனீசு, தாமிரம் மற்றும் பலவற்றின் சிறந்த ஆதாரம் பிற நுண்ணூட்டச்சத்துக்கள். " , "ஊட்டச்சத்து உண்மைகள்":  {"கார்போஹைட்ரேட்டுகள்": "34 கிராம்", "புரதங்கள்": "13 கிராம்", "கொழுப்புகள்": "0.9 கிராம்", "ஆற்றல்": "35 கிலோகலோரி"}},

// {"name": "க்ரீன்பீஸ்", "image": "lib/assets/Green/11.jpg", "use": "பச்சை பட்டாணி நார்ச்சத்து நிறைந்ததாக இருக்கிறது, இது உங்கள் செரிமானத்தின் மூலம் கழிவுகளின் ஓட்டத்தை பராமரிப்பதன் மூலம் செரிமானத்திற்கு பயனளிக்கிறது பாதை மற்றும் குடல் பாக்டீரியாவை ஆரோக்கியமாக வைத்திருத்தல். " , "ஊட்டச்சத்து உண்மைகள்":  {"கார்போஹைட்ரேட்டுகள்": "60 கிராம்", "புரதங்கள்": "25 கிராம்", "கொழுப்புகள்": "0.2 கிராம்", "ஆற்றல்": "120 கிலோகலோரி"}},

// {"name": "முட்டைக்கோஸ்", "image": "lib/assets/Green/12.jpg", "use": "முட்டைக்கோசில் கரையாத நார்ச்சத்து உள்ளது, இது நட்பு பாக்டீரியாக்களுக்கு எரிபொருளை வழங்குவதன் மூலமும், ஊக்குவிப்பதன் மூலமும் செரிமான அமைப்பை ஆரோக்கியமாக வைத்திருக்கிறது. வழக்கமான குடல் இயக்கங்கள். " , "ஊட்டச்சத்து உண்மைகள்":  {"கார்போஹைட்ரேட்டுகள்": "5.8 கிராம்", "புரதங்கள்": "1.28 கிராம்", "கொழுப்புகள்": "0.1 கிராம்", "ஆற்றல்": "25 கிலோகலோரி"}}, 

// ];

// List leaf_vegetables = [

 

// {"name": "கீரை", "image": "lib/assets/Leaf/1.jpg", "use": "ஆக்ஸிஜனேற்ற அழுத்தத்தைக் குறைத்தல், கண் ஆரோக்கியத்தை மேம்படுத்துதல், புற்றுநோயை எதிர்த்துப் போராடுவது மற்றும் இரத்த அழுத்தத்தைக் கட்டுப்படுத்துதல்." , "ஊட்டச்சத்து உண்மைகள்": {"கார்போஹைட்ரேட்டுகள்": "3.6 கிராம்", "புரதங்கள்": "2.9 கிராம்", "கொழுப்புகள்": "0.4 கிராம்", "ஆற்றல்": "23 கிலோகலோரி"}},

// {"name": "முட்டைக்கோஸ்", "image": "lib/assets/Leaf/2.jpg", "use": "முட்டைக்கோசில் கரையாத நார்ச்சத்து உள்ளது, இது நட்பு பாக்டீரியாக்களுக்கு எரிபொருளை வழங்குவதன் மூலமும் செரிமான அமைப்பை ஆரோக்கியமாக வைத்திருக்கிறது வழக்கமான குடல் இயக்கங்கள். " , "ஊட்டச்சத்து உண்மைகள்": {"கார்போஹைட்ரேட்டுகள்": "5.8 கிராம்", "புரதங்கள்": "1.28 கிராம்", "கொழுப்புகள்": "0.1 கிராம்", "ஆற்றல்": "25 கிலோகலோரி"}},

// {"name": "கீரை", "image": "lib/assets/Leaf/3.jpg", "use": "பொட்டாசியம் உயர் இரத்த அழுத்த அளவைக் குறைக்க உதவும். சிவப்பு இலை கீரை போன்ற பொட்டாசியம் நிறைந்த உணவுகளை சாப்பிடலாம் உங்கள் இரத்த அழுத்தத்தை உறுதிப்படுத்தவும். " , "ஊட்டச்சத்து உண்மைகள்": {"கார்போஹைட்ரேட்டுகள்": "2.23 கிராம்", "புரதங்கள்": "1.35 கிராம்", "கொழுப்புகள்": "0.22 கிராம்", "ஆற்றல்": "13 கிலோகலோரி"}},

// {"name": "ப்ரோக்கோலி", "image": "lib/assets/Leaf/4.jpg", "use": "ப்ரோக்கோலியின் ஐசோதியோசயனேட்டுகள் நோய்க்கான பல ஆபத்து காரணிகளை மேம்படுத்தலாம் மற்றும் உங்கள் புற்றுநோய் அபாயத்தை குறைக்கலாம். மேலும் என்ன, இந்த காய்கறி கொழுப்பைக் குறைக்கவும், கண் ஆரோக்கியத்தை அதிகரிக்கவும் உதவும். " , "ஊட்டச்சத்து உண்மைகள்": {"கார்போஹைட்ரேட்டுகள்": "6.64 கிராம்", "புரதங்கள்": "2.82 கிராம்", "கொழுப்புகள்": "0.37 கிராம்", "ஆற்றல்": "34 கிலோகலோரி"}},

// {"name": "கறிவேப்பிலைகள்", "image": "lib/assets/Leaf/5.jpg", "use": "ஆயுர்வேத மற்றும் சித்தா மருத்துவத்தில் ஒரு மூலிகையாகப் பயன்படுத்தப்படுகிறது, அதில் அவர்கள் நோய்க்கு எதிரானவர்கள் என்று நம்பப்படுகிறது பண்புகள் "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 31.6 கிராம் "," புரதங்கள் ":" 15.9 கிராம் "," கொழுப்புகள் ":" 6.2 கிராம் "," ஆற்றல் ":" 50 கிலோகலோரி "}},

// {"name": "கொத்தமல்லி", "image": "lib/assets/Leaf/6.jpg", "use": "இது ஆக்ஸிஜனேற்றிகளின் ஒரு நல்ல மூலமாகும். கொத்தமல்லியை சுவை உணவாகப் பயன்படுத்துவது மக்களை குறைவாகப் பயன்படுத்த ஊக்குவிக்கும் உப்பு மற்றும் அவற்றின் சோடியம் உட்கொள்ளலைக் குறைக்கவும். " , "ஊட்டச்சத்து உண்மைகள்": {"கார்போஹைட்ரேட்டுகள்": "3.67 கிராம்", "புரதங்கள்": "2.13 கிராம்", "கொழுப்புகள்": "0.52 கிராம்", "ஆற்றல்": "22 கிலோகலோரி"}},

// {"name": "காலிஃபிளவர்", "image": "lib/assets/Leaf/7.jpg", "use": "காலிஃபிளவர் அதிக அளவு நார்ச்சத்துகளைக் கொண்டுள்ளது, இது செரிமான ஆரோக்கியத்திற்கு முக்கியமானது மற்றும் ஆபத்தை குறைக்கலாம் பல நாட்பட்ட நோய்களின். " , "ஊட்டச்சத்து உண்மைகள்": {"கார்போஹைட்ரேட்டுகள்": "5 கிராம்", "புரதங்கள்": "1.9 கிராம்", "கொழுப்புகள்": "0.3 கிராம்", "ஆற்றல்": "25 கிலோகலோரி"}}];

// List m = [
// _{"name": "கேப்சிகம்", "image": "lib/assets/product-1.jpg", "use": "பல ஆரோக்கிய நன்மைகள் உள்ளன. இவற்றில் மேம்பட்ட கண் ஆரோக்கியம் மற்றும் இரத்த சோகை ஏற்படும் ஆபத்து ஆகியவை அடங்கும்.", " ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 4.64 கிராம் "," புரதங்கள் ":" 0.87 கிராம் "," கொழுப்புகள் ":" 0.17 கிராம் "," ஆற்றல் ":" 20 கிலோகலோரி "}},

// _{"name": "ஸ்ட்ராபெரி", "image": "lib/assets/product-2.jpg", "use": "ஸ்ட்ராபெர்ரி உங்கள் இதய நோய் மற்றும் புற்றுநோய் அபாயத்தைக் குறைக்கலாம், அத்துடன் இரத்த சர்க்கரையை சீராக்க உதவும். "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 7.68 கிராம் "," புரதங்கள் ":" 0.67 கிராம் "," கொழுப்புகள் ":" 0.3 கிராம் "," ஆற்றல் ":" 33 கிலோகலோரி "}},

// _{"name": "தக்காளி", "image": "lib/assets/product-5.jpg", "use": "உங்கள் இதய நோய் மற்றும் பல புற்றுநோய்களின் அபாயத்தைக் குறைக்கவும். இந்த பழம் தோல் ஆரோக்கியத்திற்கும் நன்மை பயக்கும், இது சூரிய ஒளியில் இருந்து பாதுகாக்கக்கூடும். "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 3.9 கிராம் "," புரதங்கள் ":" 0.9 கிராம் "," கொழுப்புகள் ":" 0.2 கிராம் "," ஆற்றல் ":" 18 கிலோகலோரி " }},

// {"name": "கேரட்", "image": "lib/assets/product-7.jpg", "use": "கேரட் சுமார் 10% கார்ப் ஆகும், அவை ஸ்டார்ச், ஃபைபர் மற்றும் எளிய சர்க்கரைகளைக் கொண்டவை. அவை. கொழுப்பு மற்றும் புரதத்தில் மிகக் குறைவு. "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 9.6 கிராம் "," புரதங்கள் ":" 0.9 கிராம் "," கொழுப்புகள் ":" 0.2 கிராம் "," ஆற்றல் ":" 41 கிலோகலோரி " }},

// {"name": "ப்ரோக்கோலி", "image": "lib/assets/product-6.jpg", "use": "ப்ரோக்கோலியின் ஐசோதியோசயனேட்டுகள் நோய்க்கான பல ஆபத்து காரணிகளை மேம்படுத்தலாம் மற்றும் உங்கள் புற்றுநோய் அபாயத்தை குறைக்கலாம். மேலும் என்ன, இந்த காய்கறி கொழுப்பைக் குறைக்கவும், கண் ஆரோக்கியத்தை அதிகரிக்கவும் உதவும். "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 6.64 கிராம் "," புரதங்கள் ":" 2.82 கிராம் "," கொழுப்புகள் ":" 0.37 கிராம் "," ஆற்றல் " : "34 கிலோகலோரி"}},

// {"name": "வெங்காயம்", "image": "lib/assets/product-9.jpg", "use": "வெங்காயம் சாப்பிடுவது உயர் இரத்த அழுத்தம், உயர்ந்த ட்ரைகிளிசரைடு அளவு போன்ற இதய நோய் ஆபத்து காரணிகளைக் குறைக்க உதவும். மற்றும் வீக்கம். " , "ஊட்டச்சத்து உண்மைகள்": {"கார்போஹைட்ரேட்டுகள்": "9.34 கிராம்", "புரதங்கள்": "1.1 கிராம்", "கொழுப்புகள்": "0.1 கிராம்", "ஆற்றல்": "40 கிலோகலோரி"}},

// {"name": "ஆப்பிள்", "image": "lib/assets/product-10.jpg", "use": "நீரிழிவு, இதய நோய் மற்றும் புற்றுநோயிலிருந்து பாதுகாக்க ஆப்பிள்கள் உதவக்கூடும்.", "ஊட்டச்சத்து உண்மைகள்" : {"கார்போஹைட்ரேட்டுகள்": "13.81 கிராம்", "புரதங்கள்": "0.26 கிராம்", "கொழுப்புகள்": "0.17 கிராம்", "ஆற்றல்": "52 கிலோகலோரி"}},

// {"name": "பூண்டு", "image": "lib/assets/product-11.jpg", "use": "காய்ச்சல் மற்றும் சளி போன்ற பொதுவான நோய்களின் தீவிரத்தைத் தடுக்கவும் குறைக்கவும் பூண்டு சப்ளிமெண்ட்ஸ் உதவுகிறது." , "ஊட்டச்சத்து உண்மைகள்": {"கார்போஹைட்ரேட்டுகள்": "33.06 கிராம்", "புரதங்கள்": "6.36 கிராம்", "கொழுப்புகள்": "0.5 கிராம்", "ஆற்றல்": "149 கிலோகலோரி"}},

// {"name": "மிளகாய்", "image": "lib/assets/product-12.jpg", "use": "மற்ற ஆரோக்கியமான வாழ்க்கை முறை உத்திகளுடன் இணைந்தால் அவை எடை இழப்பை ஊக்குவிக்கக்கூடும், மேலும் ஏற்படும் வலியைக் குறைக்க உதவும். அமில ரிஃப்ளக்ஸ். "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 8.8 கிராம் "," புரதங்கள் ":" 1.9 கிராம் "," கொழுப்புகள் ":" 0.4 கிராம் "," ஆற்றல் ":" 40 கிலோகலோரி "}},

// {"name": "பட்டாணி", "image": "lib/assets/product-3.jpg", "use": "பட்டாணி நார்ச்சத்து நிறைந்தவை, இது உங்கள் செரிமானப் பாதை வழியாக கழிவுகளின் ஓட்டத்தை பராமரிப்பதன் மூலம் செரிமானத்திற்கு பயனளிக்கிறது மற்றும் குடல் பாக்டீரியாவை ஆரோக்கியமாக வைத்திருத்தல். " , "ஊட்டச்சத்து உண்மைகள்": {"கார்போஹைட்ரேட்டுகள்": "60 கிராம்", "புரதங்கள்": "25 கிராம்", "கொழுப்புகள்": "2 கிராம்", "ஆற்றல்": "120 கிலோகலோரி"}},

// {"name": "சிவப்பு முட்டைக்கோஸ்", "image": "lib/assets/product-4.jpg", "use": "முட்டைக்கோசில் கரையாத நார்ச்சத்து உள்ளது, இது நட்பு பாக்டீரியாக்களுக்கு எரிபொருளை வழங்குவதன் மூலம் செரிமான அமைப்பை ஆரோக்கியமாக வைத்திருக்கிறது மற்றும் வழக்கமான குடல் இயக்கங்களை ஊக்குவிக்கிறது. " , "ஊட்டச்சத்து உண்மைகள்": {"கார்போஹைட்ரேட்டுகள்": "5.8 கிராம்", "புரதங்கள்": "1.28 கிராம்", "கொழுப்புகள்": "0.1 கிராம்", "ஆற்றல்": "25 கிலோகலோரி"}}

// ];

 

// List cc = [ 

 

// {"name": "தக்காளி", "image": "lib/assets/Other/1.jpg", "use": "தக்காளி உங்கள் இதய நோய் மற்றும் பல புற்றுநோய்களின் அபாயத்தைக் குறைக்கிறது. இந்த பழம் தோல் ஆரோக்கியத்திற்கும் நன்மை பயக்கும் , இது வெயிலிலிருந்து பாதுகாக்கக்கூடும். "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 3.9 கிராம் "," புரதங்கள் ":" 0.9 கிராம் "," கொழுப்புகள் ":" 0.2 கிராம் "," ஆற்றல் ":" 18 கிலோகலோரி "}},

// {"name": "கத்திரிக்காய்", "image": "lib/assets/other/2.jpg", "use": "இதய செயல்பாட்டை மேம்படுத்தி எல்.டி.எல் கொழுப்பு மற்றும் ட்ரைகிளிசரைடு அளவைக் குறைக்கவும், மனித ஆராய்ச்சி தேவைப்பட்டாலும்.", "ஊட்டச்சத்து உண்மைகள்": {"கார்போஹைட்ரேட்டுகள்": "5.88 கிராம்", "புரதங்கள்": "0.98 கிராம்", "கொழுப்புகள்": "0.18 கிராம்", "ஆற்றல்": "25 கிலோகலோரி"}},

// {"name": "முருங்கைக்காய்", "image": "lib/assets/other / 3.jpg", "use": "இரத்த சர்க்கரை அளவைக் குறைக்க வழிவகுக்கும், மேலும் அழற்சி எதிர்ப்பு பண்புகள் உள்ளன.", "ஊட்டச்சத்து உண்மைகள். ": {" கார்போஹைட்ரேட்டுகள் ":" 8.28 கிராம் "," புரதங்கள் ":" 9.40 கிராம் "," கொழுப்புகள் ":" 1.40 கிராம் "," ஆற்றல் ":" 64 கிலோகலோரி "}},

// {"name": "உருளைக்கிழங்கு", "image": "lib/propertys/Other/4.jpg", "use": "உருளைக்கிழங்கு பொட்டாசியம், ஃபோலேட் மற்றும் வைட்டமின்கள் சி உள்ளிட்ட பல வைட்டமின்கள் மற்றும் தாதுக்களின் நல்ல மூலமாகும். மற்றும் பி 6. "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 17 கிராம் "," புரதங்கள் ":" 2 கிராம் "," கொழுப்புகள் ":" 0.09 கிராம் "," ஆற்றல் ":" 18 கிலோகலோரி "}},

// {"name": "தேங்காய்", "image": "lib/assets/Other/5.jpg", "use": "தேங்காய் சாப்பிடுவது கொழுப்பின் அளவை மேம்படுத்தலாம் மற்றும் தொப்பை கொழுப்பைக் குறைக்க உதவும், இது இதயத்திற்கு ஆபத்தான காரணியாகும் நோய். "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 15 கிராம் "," புரதங்கள் ":" 2.3 கிராம் "," கொழுப்புகள் ":" 0.9 கிராம் "," ஆற்றல் ":" 32 கிலோகலோரி "}},

// {"name": "மூல மா", "image": "lib/assets/other/6.jpg", "use": "மூல மாம்பழங்கள் பெரும்பாலும் காலை நோய், மலச்சிக்கல், வயிற்றுப்போக்கு, நாள்பட்ட டிஸ்ஸ்பெசியா மற்றும் அஜீரணம். "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 15 கிராம் "," புரதங்கள் ":" 0.8 கிராம் "," கொழுப்புகள் ":" 0.4 கிராம் "," ஆற்றல் ":" 50 கிலோகலோரி "}}];

 

// List spinach_vegetables = [

// {"name": "அகதிகீராய்", "image": "lib/assets/spinach/1.jpg", "use": "பட்டை, இலைகள், ஈறுகள் மற்றும் பூக்கள் மருத்துவமாகக் கருதப்படுகின்றன. சிகிச்சையில் அஸ்ட்ரிஜென்ட் பட்டை பயன்படுத்தப்பட்டது பெரியம்மை மற்றும் பிற வெடிக்கும் காய்ச்சல்கள். தலைவலி, தலை நெரிசல் அல்லது மூக்கு மூக்குக்கு சிகிச்சையளிக்க பூக்களிலிருந்து சாறு பயன்படுத்தப்படுகிறது. "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 12 கிராம் "," புரதங்கள் ":" 0 கிராம் " , "கொழுப்புகள்": "0%", "ஆற்றல்": "27 கிலோகலோரி"}},

// {"name": "அரைகீராய்", "image": "lib/assets/spinach/2.jpg", "use": "இலைகளிலிருந்து தயாரிக்கப்படும் ஒரு தேநீரில் ஆண்டிபயாடிக், ஆன்டெல்மிண்டிக், ஆன்டிடுமோர் மற்றும் கருத்தடை பண்புகள் இருப்பதாக நம்பப்படுகிறது. பட்டை ஒரு டானிக் மற்றும் ஆண்டிபிரைடிக், இரைப்பை பிரச்சனைகளுக்கு ஒரு தீர்வு, வயிற்றுப்போக்கு மற்றும் வயிற்றுப்போக்குடன் கூடிய பெருங்குடல் எனக் கருதப்படுகிறது. காய்ச்சல் மற்றும் நீரிழிவு நோய்க்கு சிகிச்சையளிக்க ஒரு பட்டை காபி தண்ணீர் வாய்வழியாக எடுக்கப்படுகிறது. "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 6 g "," புரதங்கள் ":" 3.5 கிராம் "," கொழுப்புகள் ":" 0% "," ஆற்றல் ":" 60 கிலோகலோரி "}},

// {"name": "முருங்கை கீரை", "image": "lib/assets/spinach/3.jpg", "use": "முருங்கை இலைகளின் சாறு உடல் வெப்பத்தைக் குறைக்க பயனுள்ளதாக இருக்கும், இதனால் வெப்பம் தொடர்பான பிரச்சினைகளுக்கு சிகிச்சையளிக்கப் பயன்படுகிறது. முடி உதிர்தல், சோர்வு மற்றும் கண் புண்கள். மயிர்க்கால்களின் மறு வளர்ச்சியைத் தூண்டுவதற்காக உடலில் இரத்த ஓட்டத்தைத் தூண்டுவதற்கு தூய்மையான நெய்யுடன் முருங்கைக்காய் இலைகளையும் எடுத்துக் கொள்ளுங்கள். " , "ஊட்டச்சத்து உண்மைகள்": {"கார்போஹைட்ரேட்டுகள்": "11 கிராம்", "புரதங்கள்": "5 கிராம்", "கொழுப்புகள்": "1 கிராம்", "ஆற்றல்": "60 கிலோகலோரி"}},

// {"name": "முளைக்கீரை", "image": "lib/assets/Spinach/4.jpg", "use": "இந்த வகை கீரையை அனைத்து கீரை வகைகளின் ராணி என்று அழைக்கப்படுகிறது. சிறந்த தரம் லாக்டோஸ், ஃபைபர் மற்றும் 80% நீர் உள்ளடக்கம் போன்ற ஊட்டச்சத்து இந்த வகைகளில் உள்ளது. இது உடலை வலிமையாகவும் ஆரோக்கியமாகவும் ஆக்குகிறது. இது குழந்தைகளின் வளர்ச்சியை ஊக்குவிக்கிறது. இந்த கீரையில் உள்ள அற்புதமான மதிப்புகள் பல அரிய நோய்களை குணப்படுத்துகின்றன. "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 15 கிராம் "," புரதங்கள் ":" 1.4 கிராம் "," கொழுப்புகள் ":" 0.4 கிராம் "," ஆற்றல் ":" 42 கிலோகலோரி "}},

// {"name": "முடகட்டன்கீராய்", "image": "lib/assets/spinach/5.jpg","use": "இந்த தாவரத்தின் இலைகள், வேர்கள், விதைகள் மற்றும் குழந்தை இலைகள் அனைத்தும் கெலிடோஸ்கோபிக் மருத்துவத்திற்கு பயன்படுத்தப்படுகின்றன நோக்கங்கள். முடகாதன் கீரை அல்லது இலைகள் வலுவான அழற்சி எதிர்ப்பு பண்புகளைக் கொண்டுள்ளன. இது கீல்வாதம், மூட்டு வலி மற்றும் கீல்வாத நோயாளிகளுக்கு கூட குறிப்பிடத்தக்க நிவாரணத்தை அளிக்கிறது. இந்த மூலிகையிலிருந்து தயாரிக்கப்படும் எண்ணெயை வெளிப்புறமாகப் பயன்படுத்தலாம். "," ஊட்டச்சத்து உண்மைகள் ": { "கார்போஹைட்ரேட்டுகள்": "9 கிராம்", "புரதங்கள்": "5 கிராம்", "கொழுப்புகள்": "1 கிராம்", "ஆற்றல்": "61 கிலோகலோரி"}},

// {"name": "மனதக்கலிகீராய்", "image": "lib/assets/spinach/6.jpg", "use": "இது உடல் வெப்பத்தை குறைக்கிறது மற்றும் அதிக வெப்பத்தால் ஏற்படும் நோய்களைத் தடுக்கிறது. மனதக்களி கீராய் செயல்படுகிறது மயக்கத்திற்கு சிகிச்சையளிப்பதற்கான ஒரு மருந்து. முகப்பரு, அரிக்கும் தோலழற்சி மற்றும் சொரியாஸிஸ் சோலனம் நிக்ரம் என்பது பாட்டிகளால் பரிந்துரைக்கப்பட்ட சிறந்த மருந்து. மூலிகையின் சிறிய பெர்ரி ஆஸ்துமா மற்றும் காய்ச்சலுக்கு ஒரு நல்ல சிகிச்சையாக பயன்படுத்தப்படுகிறது. "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் " : "9 கிராம்", "புரதங்கள்": "6 கிராம்", "கொழுப்புகள்": "1 கிராம்", "ஆற்றல்": "68 கிலோகலோரி"}},

// {"name": "பொன்னங்கனிகிராய்", "image": "lib/assets/spinach/7.jpg", "use": "இந்திய மருத்துவத்தில் பொன்னங்கண்ணி கீரை ஒரு சோலாகோக், இரைப்பை குடல் முகவராகப் பயன்படுத்தப்படுகிறது, இது பித்த ஓட்டத்தைத் தூண்டுகிறது (பித்தம் என்பது கல்லீரலில் உற்பத்தி செய்யப்படும் ஒரு குழம்பாக்குதல் முகவர், இது கொழுப்புகளை ஜீரணிக்க உதவுகிறது). "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 12 கிராம் "," புரதங்கள் ":" 5 கிராம் "," கொழுப்புகள் ":" 1 கிராம் ", "ஆற்றல்": "73 கிலோகலோரி"}},

// {"name": "புலிச்சைகிராய்",  "image": "lib/assets/spinach/8.jpg", "use": "கோங்குரா இலைகளின் ஊட்டச்சத்து பெனிஃபிட்கள் இது குறைந்த கலோரி உணவாகும், இது அதிக சத்தான மற்றும் பல மருத்துவங்களைக் கொண்டுள்ளது வைட்டமின்கள்: இது வைட்டமின் ஏ, வைட்டமின் பி 1 (தியாமின்), வைட்டமின் பி 2 (ரைபோஃப்ளேவின்), வைட்டமின் பி 9 (ஃபோலிக் அமிலம்) மற்றும் வைட்டமின் சி ஆகியவற்றின் சிறந்த மூலமாகும். "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 10 கிராம் "," புரதங்கள் ":" 2 கிராம் "," கொழுப்புகள் ":" 1 கிராம் "," ஆற்றல் ":" 56 கிலோகலோரி "}},

// {"name": "சிறு கீரை", "image": "lib/assets/spinach/9.jpg", "use": "இது விஷ பூச்சி கடியைக் குணப்படுத்தும் சக்தியைக் கொண்டுள்ளது. குப்பை, பித்தப்பை நோய், பித்தீசிஸ், கண் நோய்கள் , வெப்பமண்டல அமரத்தை சேர்ப்பதன் மூலம் காயங்கள், ஸ்ட்ராங்கூரி மற்றும் உணவு விஷம் ஆகியவை குணமாகும். மலமிளக்கிய, டையூரிடிக் மற்றும் குளிர்பதன பண்புகள் இதில் உள்ளன. 100 கிராம் சிரு கீரையில் பின்வரும் ஊட்டச்சத்து மதிப்புகள் உள்ளன. "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ": "3 கிராம்", "புரதங்கள்": "4 கிராம்", "கொழுப்புகள்": "1 கிராம்", "ஆற்றல்": "34 கிலோகலோரி"}},

// {"name": "வல்லரைகீராய்", "image": "lib/assets/spinach/10.jpg", "use": "இது நினைவகம் மற்றும் செறிவு இடைவெளியை மேம்படுத்த உதவுகிறது. வலராய் மன அழுத்தத்தின் போது மூளையில் அடக்கும் விளைவைக் கொண்டிருக்கிறது மற்றும் பதட்டம் மற்றும் தூக்கமின்மை, மனச்சோர்வு மற்றும் அல்சைமர் நோய்க்கு சிகிச்சையளிப்பதில் பயனுள்ளதாகக் காணப்படுகிறது. வல்லராய் ஒரு இரத்த சுத்திகரிப்பு, உயர் இரத்த அழுத்தத்திற்கு சிகிச்சையளிக்கப் பயன்படுகிறது மற்றும் நீண்ட ஆயுளை ஊக்குவிப்பதாகக் கூறப்படுகிறது. "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 15 கிராம் " , "புரதங்கள்": "0.8 கிராம்", "கொழுப்புகள்": "0.4 கிராம்", "ஆற்றல்": "50 கிலோகலோரி"}}];

 

// List ll= [

// {"name": "ஆப்பிள்", "image": "lib/assets/fruit/1.jpg", "use": "ஆப்பிள்கள் இதய நோய்க்கான குறைந்த ஆபத்துடன் இணைக்கப்பட்டுள்ளன. ஒரு காரணம் ஆப்பிள்களில் இருக்கலாம் உங்கள் இரத்தத்தில் உள்ள கொழுப்பின் அளவைக் குறைக்க உதவும் கரையக்கூடிய நார். ... ஃபிளாவனாய்டுகள் இரத்த அழுத்தத்தைக் குறைப்பதன் மூலமும், “கெட்ட” எல்.டி.எல் ஆக்சிஜனேற்றத்தைக் குறைப்பதன் மூலமும், ஆக்ஸிஜனேற்றிகளாக செயல்படுவதன் மூலமும் இதய நோய்களைத் தடுக்க உதவும். "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 14 கிராம் "," புரதங்கள் ":" 0.3 கிராம் "," கொழுப்புகள் ":" 0 கிராம் "," ஆற்றல் ":" 52 கிலோகலோரி "}},

// {"name": "வாழைப்பழம்", "image": "lib/assets/Fruit/2.jpg", "use": "வாழைப்பழங்கள் வைட்டமின் சி இன் மரியாதைக்குரிய ஆதாரங்கள் வாழைப்பழங்களில் உள்ள மாங்கனீசு உங்கள் சருமத்திற்கு நல்லது. பொட்டாசியம் வாழைப்பழங்கள் உங்கள் இதய ஆரோக்கியத்திற்கும் இரத்த அழுத்தத்திற்கும் நல்லது.பனனாஸ் செரிமானத்திற்கு உதவுவதோடு, இரைப்பை குடல் பிரச்சினைகளை வெல்ல உதவும். பனானாஸ் உங்களுக்கு ஆற்றலை அளிக்கிறது - கொழுப்புகள் மற்றும் கொழுப்பைக் கழித்தல் "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 23 கிராம் "," புரதங்கள் ":" 1.1 கிராம் "," கொழுப்புகள் ":" 0.3 கிராம் "," ஆற்றல் ":" 80 கிலோகலோரி "}},

// {"name": "மா", "image": "lib/assets/Fruit/3.jpg", "use": "செரிமானத்திற்கு உதவுகிறது. ஆரோக்கியமான செரிமானத்தை எளிதாக்க மாம்பழங்கள் உதவக்கூடும். ஆரோக்கியமான குடலை ஊக்குவிக்கிறது. நோய் எதிர்ப்பு சக்தியை அதிகரிக்கிறது. கண் ஆரோக்கியம். கொழுப்பைக் குறைக்கிறது. சருமத்தை அழிக்கிறது. நீரிழிவு நோயாளிகள் கூட அதை அனுபவிக்க முடியும். எடை இழப்புக்கு உதவுகிறது. "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 15 கிராம் "," புரதங்கள் ":" 0.8 கிராம் "," கொழுப்புகள் ": "0 கிராம்", "ஆற்றல்": "60 கிலோகலோரி"}},

// {"name": "ஆரஞ்சு", "image": "lib/assets/Fruit/4.jpg", "use": "இனிப்பு ஆரஞ்சு ஒரு பழம். தலாம் மற்றும் சாறு மருந்து தயாரிக்கப் பயன்படுகிறது. இனிப்பு ஆரஞ்சு உயர் கொழுப்பு, உயர் இரத்த அழுத்தம் மற்றும் பக்கவாதம் தடுப்புக்கு பொதுவாகப் பயன்படுத்தப்படுகிறது. சிலர் கவலை, மனச்சோர்வு மற்றும் தூக்கத்திற்கு உதவ நறுமண சிகிச்சையில் பயன்படுத்துகின்றனர். "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 12 கிராம் "," புரதங்கள் ":" 0.9 கிராம் "," கொழுப்புகள் ":" 0.1 கிராம் "," ஆற்றல் ":" 47 கிலோகலோரி "}},

// {"name": "மாதுளை", "image": "lib/assets/Fruit/5.jpg", "use": "மாதுளை 100 க்கும் மேற்பட்ட பைட்டோ கெமிக்கல்களைக் கொண்டுள்ளது. மாதுளை பழம் ஆயிரக்கணக்கான ஆண்டுகளாக மருந்தாக பயன்படுத்தப்படுகிறது ஆன்டிஆக்ஸிடன்ட்கள். வைட்டமின் சி. புற்றுநோய் தடுப்பு. அல்சைமர் நோய் பாதுகாப்பு. செரிமானம், அழற்சி எதிர்ப்பு, கீல்வாதம், இதய நோய். "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 19 கிராம் "," புரதங்கள் ":" 1.7 கிராம் ", "கொழுப்புகள்": "1.2 கிராம்", "ஆற்றல்": "83 கிலோகலோரி"}},

// {"name": "தர்பூசணி", "image": "lib/assets/Fruit/6.jpg", "use": "தர்பூசணியின் நன்மைகள் ஆரோக்கியமான நிறம் மற்றும் கூந்தலை ஊக்குவித்தல், அதிகரித்த ஆற்றல் மற்றும் ஒட்டுமொத்த குறைந்த எடை ஆஸ்துமா தடுப்பு. இரத்த அழுத்தம். புற்றுநோய். செரிமானம் மற்றும் ஒழுங்குமுறை. நீரேற்றம், அழற்சி, தசை புண். தோல். "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 8 கிராம் "," புரதங்கள் ":" 0.6 கிராம் "," கொழுப்புகள் ":" 0.2 கிராம் "," ஆற்றல் ":" 30 கிலோகலோரி "}},

// {"name": "ஸ்வீட்லைம்", "image": "lib/assets/Fruit/7.jpg", "use": "இது தொற்றுநோய்களை எதிர்த்துப் போராட உதவுகிறது, புண் மற்றும் காயங்களுக்கு சிகிச்சையளிக்கிறது, இரத்த ஓட்டத்தை மேம்படுத்துகிறது மற்றும் நோய் எதிர்ப்பு சக்தியை அதிகரிக்கும் மற்றும் புற்றுநோய் உயிரணு உருவாக்கத்தை எதிர்த்துப் போராடுகிறது. இனிப்பு சுண்ணாம்பின் கிருமி நாசினிகள் மற்றும் பாக்டீரியா எதிர்ப்பு பண்புகள் முடி மற்றும் தோல் ஆரோக்கியத்தை மேம்படுத்தும் பல அழகு சிகிச்சை சிகிச்சைகளுக்கு இது பழத்தின் சிறந்த தேர்வாக அமைகிறது "," ஊட்டச்சத்து உண்மைகள் ": _ {" கார்போஹைட்ரேட்டுகள் ":" 7 கிராம் "," புரதங்கள் ":" 0.5 கிராம் "," கொழுப்புகள் ":" 0.1 கிராம் "," ஆற்றல் ":" 20 கிலோகலோரி "}},

// {"name": "சிகூ", "image": "lib/assets/Fruit/8.jpg", "use": "சர்வதேச உணவு அறிவியல் மற்றும் ஊட்டச்சத்து இதழின் படி, டானின்களின் உயர் உள்ளடக்கம் சப்போட்டாவை உருவாக்குகிறது சிக்கு ஒரு முக்கியமான அழற்சி எதிர்ப்பு முகவர், இது உணவுக்குழாய் அழற்சி, குடல் அழற்சி, எரிச்சலூட்டும் குடல் நோய்க்குறி மற்றும் இரைப்பை அழற்சி "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 20 கிராம் ", "புரதங்கள்": "0.4 கிராம்", "கொழுப்புகள்": "1.1 கிராம்", "ஆற்றல்": "83 கிலோகலோரி"}},

// {"name": "வயலட் கிராப்ஸ்", "image": "lib/assets/Fruit/11.jpg", "use": "மிச்சிகன் பல்கலைக்கழக இருதய மையம் மேற்கொண்ட ஆய்வில், கருப்பு திராட்சை உட்கொள்வது பாதுகாக்கப்படலாம் என்று கூறுகிறது வளர்சிதை மாற்ற நோய்க்குறி தொடர்பான உறுப்பு சேதத்திற்கு எதிரானது. வளர்சிதை மாற்ற நோய்க்குறி என்பது ஒன்றாக ஏற்படும் நிலைமைகளின் ஒரு கூட்டமாகும் - அதிகரித்த இரத்த அழுத்தம், உயர் இரத்த சர்க்கரை அளவு, இடுப்பைச் சுற்றியுள்ள அதிகப்படியான உடல் கொழுப்பு அல்லது குறைந்த எச்.டி.எல் (நல்ல கொழுப்பு) மற்றும் அதிகரித்த இரத்த ட்ரைகிளிசரைடுகள் - கணிசமாக இதய நோய், பக்கவாதம் மற்றும் வகை 2 நீரிழிவு நோய்க்கான ஆபத்தை அதிகரிக்கும். "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 17 கிராம் "," புரதங்கள் ":" 0.6 கிராம் "," கொழுப்புகள் ":" 0.4 கிராம் "," ஆற்றல் ":" 67 கிலோகலோரி "}}];

 

// List p = [

 

// {"name": "துவரம்பருப்பு", "image": "lib/assets/Legume/1.jpg", "use": "இது தமிழ்நாட்டில் துவாரம் பருப்பு என்றும், கேரளாவில் துவாரா பரிப்பு என்றும் அழைக்கப்படுகிறது, மேலும் இது முக்கிய மூலப்பொருள் டிஷ் சாம்பார். கர்நாடகாவில் இது டோகரி பீல் என்றும் பிசி பீல் குளியல் ஒரு முக்கிய மூலப்பொருள் என்றும் அழைக்கப்படுகிறது. இது தெலுங்கில் காந்தி பப்பு என்று அழைக்கப்படுகிறது மற்றும் இது ஒரு பிரதான டிஷ் பப்பு சாரு தயாரிப்பில் பயன்படுத்தப்படுகிறது. "," ஊட்டச்சத்து உண்மைகள் ":  { "கார்போஹைட்ரேட்டுகள்": "93 கிராம்", "புரதங்கள்": "15 கிராம்", "கொழுப்புகள்": "1 கிராம்", "ஆற்றல்": "400 கிலோகலோரி"}},

// {"name": "கடலைபருப்பு","image": "lib/assets/Legume/2.jpg", "use": "வங்காள கிராமில் நல்ல அளவு இரும்பு, சோடியம், செலினியம் மற்றும் சிறிய அளவு செப்பு துத்தநாகம் மற்றும் மாங்கனீசு உள்ளன அவை புரதத்தின் வளமான மூலமாகும். 2. அவை ஃபோலிக் அமிலம் மற்றும் நார்ச்சத்துக்களின் மிகச் சிறந்த மூலமாகும், மேலும் அவை ஆக்ஸிஜனேற்றியாக செயல்படக்கூடிய சபோனின்கள் எனப்படும் பைட்டோ கெமிக்கல்களைக் கொண்டுள்ளன. "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 9 கிராம் "," புரதங்கள் ":" 2 கிராம் "," கொழுப்புகள் ":" 9 கிராம் "," ஆற்றல் ":" 197 கிலோகலோரி "}},

// {"name": "உலுதம்பருப்பு","image": "lib/assets/Legume/3.png", "use": "உராட் பருப்பு கரையக்கூடிய மற்றும் கரையாத நார் இரண்டையும் கொண்டிருப்பதால் ஆரோக்கியத்திற்கு பயனளிக்கிறது, இது செரிமானத்திற்கும் நல்லது மலச்சிக்கலைத் தடுக்கிறது. இரத்த ஓட்டம் அதிகரிப்பதன் மூலம் இருதய ஆரோக்கியம். பாலியல் செயலிழப்புக்கு சிகிச்சையளிப்பதால் உரத் பருப்பு இயற்கையான பாலுணர்வாக கருதப்படுகிறது. "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 58.99 கிராம் "," புரதங்கள் ":" 25.21 கிராம் "," கொழுப்புகள் ":" 1.64 கிராம் "," ஆற்றல் ":" 314 கிலோகலோரி "}},

// {"name": "மைசொர்பருப்பு","image": "lib/assets/Legume/4.jpg", "use": "இரத்த சர்க்கரை அளவை உறுதிப்படுத்த உதவுகிறது. கொழுப்பைக் குறைப்பதன் மூலம் இதயத்தை ஆரோக்கியமாக வைத்திருக்கிறது. எடை இழப்புக்கு எதிரான பயனுள்ள தீர்வு .ஆண்டி-வயதான பண்புகள். பற்கள் மற்றும் எலும்புகளை வளர்க்கின்றன. ஆரோக்கியமான பார்வையை பராமரிப்பதில் உதவியாக இருக்கும். ஒளிரும் மற்றும் கதிர்வீச்சு செய்யும் சருமத்திற்கு பயனுள்ளது "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 63.35 கிராம் "," புரதங்கள் ":" 24.63 கிராம் "," கொழுப்புகள் ":" 1.06 கிராம் "," ஆற்றல் ":" 352 கிலோகலோரி "}},

// {"name": "வைட்டச்சன்னா","image": "lib/assets/Legume/5.jpg", "use": "வைட்டமின்கள், தாதுக்கள் மற்றும் நார்ச்சத்துக்களின் வளமான ஆதாரமாக, கொண்டைக்கடலை பலவிதமான சுகாதார நன்மைகளை வழங்கக்கூடும் செரிமானத்தை மேம்படுத்துதல், எடை நிர்வாகத்திற்கு உதவுதல் மற்றும் பல நோய்களின் அபாயத்தைக் குறைத்தல் போன்றவை. கூடுதலாக, கொண்டைக்கடலை அதிக அளவு புரதச்சத்து கொண்டது மற்றும் சைவ மற்றும் சைவ உணவுகளில் இறைச்சிக்கு ஒரு சிறந்த மாற்றாக அமைகிறது. "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ": "24 கிராம்", "புரதங்கள்": "10 கிராம்", "கொழுப்புகள்": "4 கிராம்", "ஆற்றல்": "165 கிலோகலோரி"}},

// {"name": "பிளாக்சன்னா", "image": "lib/assets/Legume/6.jpg", "use": "கருப்பு கொண்டைக்கடலை அல்லது கலா சானா ஒரு நல்ல புரத மூலமாக பிரபலமாக அறியப்படுகிறது. இதை சேர்க்கலாம் இயற்கையாகவே நீரிழிவு மற்றும் இரத்த சர்க்கரை அளவைக் கட்டுப்படுத்த உங்கள் தினசரி உணவில். பல மக்கள் தினமும் காலையில் வேகவைத்த கலா சனாவை உட்கொள்கிறார்கள், ஏனெனில் இது ஏராளமான ஆரோக்கிய நன்மைகளை வழங்குகிறது. "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 62.62 கிராம் "," புரதங்கள் ": "23.86 கிராம்", "கொழுப்புகள்": "1.15 கிராம்", "ஆற்றல்": "347 கிலோகலோரி"}},

// {"name": "பாசிபாயிரு", "image": "lib/assets/Legume/7.jpg", "use": "முங் பீன்ஸ் ஊட்டச்சத்துக்கள் மற்றும் ஆக்ஸிஜனேற்றங்கள் அதிகம் இருப்பதால் அவை ஆரோக்கிய நன்மைகளை அளிக்கக்கூடும். உண்மையில், அவை வெப்ப பக்கவாதம், செரிமான ஆரோக்கியத்திற்கு உதவுதல், எடை இழப்பு மற்றும் குறைந்த “கெட்ட” எல்.டி.எல் கொழுப்பு, இரத்த அழுத்தம் மற்றும் இரத்த சர்க்கரை அளவை ஊக்குவிக்கலாம். "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 17 கிராம் "," புரதங்கள் ":" 0.6 கிராம் "," கொழுப்புகள் ":" 0.4 கிராம் "," ஆற்றல் ":" 67 கிலோகலோரி "}},

// {"name": "பொட்டுகடலை", "image": "lib/assets/Legume/9.jpg", "use": "வறுத்த கிராம் / பொட்டுகடாலா இந்தியாவில் மிகவும் பிரபலமான சிற்றுண்டாகும். வறுத்த கிராம் பல்வேறு பெயர்களால் அறியப்படுகிறது இந்தியா முழுவதும் பொட்டுக்டலை, பொட்டுகடாலா, போரிக்கடலா போன்றவை… மற்ற அனைத்து வகை பயறு வகைகளைப் போலவே, வறுத்த கிராம் புரதமும், நார்ச்சத்து, தாதுக்கள் மற்றும் கொழுப்பு அமிலங்களும் நிறைந்தவை. வறுத்த கிராம் கலோரி மற்றும் பணக்காரத்தில் மிகக் குறைவு. "," ஊட்டச்சத்து உண்மைகள் ": { "கார்போஹைட்ரேட்டுகள்": "9 கிராம்", "புரதங்கள்": "2 கிராம்", "கொழுப்புகள்": "9 கிராம்", "ஆற்றல்": "197 கிலோகலோரி"}}];

 

// List c = [

 

// {"name": "அரிசி", "image": "lib/assets/Cereals/1.jpg", "use": "அரிசியின் ஆரோக்கிய நன்மைகள் இது ஆற்றலை வழங்க உதவுகிறது, உடல் பருமனைத் தடுக்கிறது, இரத்தத்தைக் கட்டுப்படுத்துகிறது அழுத்தம், புற்றுநோயைத் தடுக்கிறது, தோல் பராமரிப்பு அளிக்கிறது, அல்சைமர் நோயைத் தடுக்கிறது, டையூரிடிக் மற்றும் செரிமான குணங்களைக் கொண்டுள்ளது, வளர்சிதை மாற்றத்தை மேம்படுத்துகிறது, இருதய ஆரோக்கியத்தை மேம்படுத்துகிறது, எரிச்சலூட்டும் குடல் நோய்க்குறியின் அறிகுறிகளை நீக்குகிறது. "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 148 கிராம் " , "புரதங்கள்": "12 கிராம்", "கொழுப்புகள்": "0 கிராம்", "ஆற்றல்": "640 கிலோகலோரி"}},

// {"name": "கோதுமை", "image": "lib/assets/Cereals/ 2.jpg", "use": "கோதுமை தானியமானது புளிப்பு, தட்டையான மற்றும் வேகவைத்த ரொட்டிகள், பிஸ்கட் ஆகியவற்றிற்கு மாவு தயாரிக்கப் பயன்படும் பிரதான உணவு. , குக்கீகள், கேக்குகள், காலை உணவு தானியங்கள், பாஸ்தா, நூடுல்ஸ், கூஸ்கஸ். இது எத்தனால் தயாரிக்கவும், மது பானங்கள் அல்லது உயிரி எரிபொருளுக்காகவும் புளிக்கலாம். "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 29 கிராம் "," புரதங்கள் " : "5 கிராம்", "கொழுப்புகள்": "0 கிராம்", "ஆற்றல்": "135 கிலோகலோரி"}},

// {"name": "மக்காச்சோளம்", "image": "lib/assets/Cereals/3.jpg", "use": "மக்காச்சோளம் உலகின் பல பகுதிகளிலும் பிரதான உணவாக மாறியுள்ளது, மக்காச்சோளத்தின் மொத்த உற்பத்தியுடன் இருப்பினும், கோதுமை அல்லது அரிசியை விட அதிகமாக உள்ளது. இருப்பினும், இந்த மக்காச்சோளம் சிறிதளவு நேரடியாக மனிதர்களால் நுகரப்படுகிறது: பெரும்பாலானவை சோள எத்தனால், விலங்கு தீவனம் மற்றும் சோள மாவுச்சத்து மற்றும் சோளம் சிரப் போன்ற பிற மக்காச்சோள பொருட்களுக்கு பயன்படுத்தப்படுகின்றன. "," ஊட்டச்சத்து உண்மைகள் ": { "கார்போஹைட்ரேட்டுகள்": "5 கிராம்", "புரதங்கள்": "0 கிராம்", "கொழுப்புகள்": "0 கிராம்", "ஆற்றல்": "24 கிலோகலோரி"}},

// {"name": "ஓட்ஸ்", "image": "lib/assets/Cereals/4.jpg", "use": "ஓட்ஸ் உணவில் பல பயன்பாடுகளைக் கொண்டுள்ளது. பெரும்பாலான நேரங்களில் அவை உருட்டப்படுகின்றன அல்லது ஓட்மீலில் நசுக்கப்படுகின்றன, ஓட் மாவு கஞ்சியாகவும் உண்ணப்படுகிறது, ஆனால் ஓட் கேக்குகள், ஓட்மீல் குக்கீகள் மற்றும் ஓட் ரொட்டி போன்ற பல சுடப்பட்ட பொருட்களிலும் பயன்படுத்தப்படலாம். "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 33 கிராம் "," புரதங்கள் ":" 8 கிராம் "," கொழுப்புகள் ":" 3 கிராம் "," ஆற்றல் ":" 194 கிலோகலோரி "}},

// {"name": "சோளம்", "image": "lib/assets/Cereals/5.jpg", "use": "சோளம் உணவு, தீவனம் மற்றும் மது பானங்கள் உற்பத்திக்கு பயன்படுத்தப்படுகிறது. இது வறட்சி- சகிப்புத்தன்மை மற்றும் வெப்ப-சகிப்புத்தன்மை, மற்றும் வறண்ட பகுதிகளில் இது மிகவும் முக்கியமானது. இது ஆப்பிரிக்கா, மத்திய அமெரிக்கா மற்றும் தெற்காசியாவில் ஒரு முக்கியமான உணவுப் பயிர் ஆகும், மேலும் இது உலகில் வளர்க்கப்படும் ஐந்தாவது மிக முக்கியமான தானிய பயிர் ஆகும். "," ஊட்டச்சத்து உண்மைகள் ": {"கார்போஹைட்ரேட்டுகள்": "143 கிராம்", "புரதங்கள்": "21 கிராம்", "கொழுப்புகள்": "6 கிராம்", "ஆற்றல்": "651 கிலோகலோரி"}}];

 

// List b = [

 

// {"name": "பிரவுன்ரைஸ்", "image": "lib/assets/Rice/3.jpg" ,"use": "பிரவுன் அரிசியின் ஆரோக்கிய நன்மைகள் ஓரளவு தயாரிக்கப்படுவதால் ஏற்படுகின்றன என்று ஜார்ஜ் மேட்டல்ஜன் அறக்கட்டளை தெரிவித்துள்ளது ஆரோக்கியமான உணவின் நன்மைகளை ஊக்குவிக்கும் உலகின் ஆரோக்கியமான உணவுகளுக்கு. பிரவுன் அரிசி ஒரு முழு தானியமாகும், அதாவது தானிய கர்னலின் மூன்று பகுதிகளைக் கொண்டுள்ளது: இதன் பொருள், தவிடு எனப்படும் வெளிப்புற, நார் நிரப்பப்பட்ட அடுக்கு, ஊட்டச்சத்து நிறைந்த கோர் ஹார்வர்ட் டி.எச். சான் ஸ்கூல் ஆஃப் பப்ளிக் ஹெல்த் (எச்.எஸ்.பி.எச்) படி, கிருமி, மற்றும் எண்டோஸ்பெர்ம் எனப்படும் மாவுச்சத்து நடுத்தர அடுக்கு. வெளிப்புற, சாப்பிட முடியாத ஹல் அகற்றப்படுகிறது. "," ஊட்டச்சத்து உண்மைகள் ": {" கார்போஹைட்ரேட்டுகள் ":" 54 கிராம் "," புரதங்கள் ":" 6 கிராம் "," கொழுப்புகள் ":" 2 கிராம் "," ஆற்றல் ":" 277 கிலோகலோரி "}},

// {"name": "பாலகாத்மட்டாரிஸ்", "image": "lib/assets/Rice/4.jpg", "use": "மேட்டா ரைஸ், ரோஸ்மட்டா அரிசி, பாலக்கடன் மட்டா அரிசி, கேரளா சிவப்பு அரிசி அல்லது சிவப்பு பர்போயில் அரிசி , இந்தியாவின் கேரளாவின் பாலக்காடு பகுதியிலிருந்து உள்நாட்டிலிருந்து தயாரிக்கப்படுகிறது. பலவகையான உணவுகளில் பயன்படுத்தப்படுகிறது, மட்டா அரிசியை வெற்று அரிசியாகக் கொண்டிருக்கலாம், அல்லது இட்லிஸ், ஆப்பங்கள் மற்றும் முருகு மற்றும் கோண்டட்டம் போன்ற சிற்றுண்டிகளை தயாரிக்க பயன்படுத்தலாம். "," ஊட்டச்சத்து உண்மைகள் ":  {" கார்போஹைட்ரேட்டுகள் ":" 77 கிராம் "," புரதங்கள் ":" 8 கிராம் "," கொழுப்புகள் ":" 0 கிராம் "," ஆற்றல் ":" 349 கிலோகலோரி "}},

// {"name": "பிளாக்ரைஸ்", "image": "lib/assets/Rice/6.jpg" ,"use": "ஆக்ஸிஜனேற்றிகளின் வளமான மூலமாகும். ஆக்ஸிஜனேற்ற உள்ளடக்கத்திற்கு வரும்போது, ​​வேறு எந்த மூலப்பொருளும் நெருங்காது கருப்பு அரிசி. சண்டை புற்றுநோய். வீக்கத்தைக் குறைக்கிறது. எடை இழப்பு , "," ஊட்டச்சத்து உண்மைகள் " : {" கார்போஹைட்ரேட்டுகள் ":" 80 கிராம் "," புரதங்கள் ":" 6 கிராம் " , "கொழுப்புகள்": "2 கிராம்", "ஆற்றல்": "360 கிலோகலோரி"}},

// {"name": "சீராகசம்பா", "image": "lib/assets/Rice/7.jpg", "use": "சீராகா சம்பா அரிசியில் செலினியம் உள்ளது, இது பெருங்குடல் மற்றும் குடல் புற்றுநோயைத் தடுக்க உதவுகிறது. ஃபைபர் மற்றும் ஆன்டி-ஆக்ஸிடன்ட் பெருங்குடல் மற்றும் குடலில் இருந்து ஃப்ரீ ரேடிக்கல்களை அகற்ற உதவுகிறது. இது மார்பக புற்றுநோயை எதிர்த்துப் போராட உதவும் இதயத்தை வலுப்படுத்தும் பைட்டோநியூட்ரியன்களையும் கொண்டுள்ளது. "," ஊட்டச்சத்து உண்மைகள் " : {" கார்போஹைட்ரேட்டுகள் ":" 80 கிராம் "," புரதங்கள் ":" 6 கிராம் " , "கொழுப்புகள்": "2 கிராம்", "ஆற்றல்": "360 கிலோகலோரி"}},

// {"name": "பொன்னிரிஸ்", "image": "lib/propertys/Rice/8.jpg" ,"use": "பொன்னி அரிசி என்பது 1986 ஆம் ஆண்டில் தமிழ்நாடு வேளாண் பல்கலைக்கழகத்தால் உருவாக்கப்பட்ட ஒரு அரிசி வகை. பொன்னி அரிசி மகத்தான ஆரோக்கியத்தைக் கொண்டுள்ளது குறிப்பாக நீரிழிவு நோயாளிகள் மற்றும் உயர் இரத்த சர்க்கரை நோயாளிகளுக்கு நன்மைகள்: உயர் ஃபைபர்.குளுட்டன் இலவசம். குறைந்த கிளைசெமிக் குறியீடு, இதனால் உயர்த்தப்பட்ட இரத்த சர்க்கரையின் தாக்கத்தை குறைக்கிறது. கொழுப்பைக் குறைக்கிறது."," ஊட்டச்சத்து உண்மைகள்": {" கார்போஹைட்ரேட்டுகள் ":" 34 கிராம் "," புரதங்கள் ":" 3 கிராம் "," கொழுப்புகள் ":" 1 கிராம் "," ஆற்றல் ":" 160 கிலோகலோரி "}},

// {"name": "பாஸ்மாதிரிஸ்", "image": "lib/assets/Rice/5.jpg", "use": "இந்த நீண்ட மற்றும் மெல்லிய தானியங்கள் அவற்றின் தனித்துவமான நறுமணத்திற்காக அறியப்படுகின்றன மற்றும் அவை இந்திய துணைக் கண்டத்திற்கு சொந்தமானவை. 'பாஸ்மதி' என்ற சொல் உண்மையில் இந்தி வார்த்தையிலிருந்து உருவானது, அதாவது 'மணம்'. இது பொதுவாக அரச பிரியாணிகளை தயாரிக்கப் பயன்படுகிறது, ஆனால் பாஸ்மதி அரிசியுடன் நீங்கள் செய்யக்கூடியவை இன்னும் நிறைய உள்ளன. "," ஊட்டச்சத்து உண்மைகள் ": { "கார்போஹைட்ரேட்டுகள்": "148 கிராம்", "புரதங்கள்": "0 கிராம்", "கொழுப்புகள்": "1 கிராம்", "ஆற்றல்": "675 கிலோகலோரி"}}];

 

 



static Map allImages = {

};

static Map allUses = {

};






static List images = [ "lib/assets/image_6.jpg", "lib/assets/image_5.jpg", "lib/assets/image_4.jpg","lib/assets/category-2.jpg","lib/assets/category-3.jpg","lib/assets/category-4.jpg"];

}