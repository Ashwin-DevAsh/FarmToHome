import 'package:farmer_portal/Datas/UserData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectProduct extends StatefulWidget {
  var products;
  SelectProduct({this.products});
  @override
  _SelectProductState createState() => _SelectProductState();
}

class _SelectProductState extends State<SelectProduct> {
  TextEditingController searchbar = new TextEditingController();
  var show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:  
        Builder(
         
          builder: (context) {
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
                                  title: Text("Select Product"),


                                

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

                                                      UserData.product = widget.products[i];
                                                      setState(() {
                                                        
                                                      });
                                                     

                                                    },
                                                    child: Material(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.white,
                                                    
                                                      elevation: 2,


                                                      child: Stack(
                                                        children: <Widget>[
                                                          Stack(

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
                                                       
                                                        UserData.product==widget.products[i]?Center(child:    CircleAvatar(child: Icon(Icons.done,color: Colors.white,),backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),)):Center()
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

                                                      UserData.product = temp[i];
                                                      setState(() {
                                                        
                                                      });
                                                    
                                                    },
                                                    child: Material(
                                                      key: UniqueKey(),
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.white,
                                                    
                                                      elevation: 2,


                                                      child: Stack(
                                                        children: <Widget>[
                                                          Stack(

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
                                                         UserData.product==temp[i]?Center(child:    CircleAvatar(child: Icon(Icons.done,color: Colors.white,),backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),)):Center()

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
                                child: Icon(Icons.clear,color: Theme.of(context).primaryColor,size: 18,),
                              ),
                              GestureDetector(
                                onTap: (){
                                    UserData.product=null;
                                    setState(() {
                                      
                                    });
                                },
                                                          child: Text(

                                  "Clear",
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

                      GestureDetector(
                        onTap: (){
                          if(UserData.product==null){
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text("No Product Selected"),));
                          }else
                          Navigator.of(context).pop();
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
                                "Done",
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
                                ),
                              ),
                          )
                            ),
            );
          }
        ),
    );
  }
}