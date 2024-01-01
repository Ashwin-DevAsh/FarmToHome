import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_portal/DataBase/DataBaseHelper.dart';
import 'package:farmer_portal/Datas/UserData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Register.dart';
import 'cart.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
   TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  var hidden = true;
  IconData  visibility = Icons.visibility_off;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
           decoration: BoxDecoration(

                            gradient: LinearGradient(colors: [
                              Color(0xff3bc25f) ,Color(0xff288a3a),
                            ])
                        ),
          child: NestedScrollView(

                      headerSliverBuilder: (context,_){
                        return [
                          Container(
                           

                            child: SliverAppBar(
                              expandedHeight: 50,
                              title: Text("Login"),

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

                      body:Scaffold(
            
            body: Builder(


              builder: (context) {
                return Container(
                   decoration: BoxDecoration(

                            gradient: LinearGradient(colors: [
                              Color(0xff3bc25f) ,Color(0xff288a3a),
                            ])
                        ),


                  child: Column(
                    children: <Widget>[
                      Container(

                        height: 80,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xff3bc25f) ,Color(0xff288a3a),
                            ])
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(15))
                          ),
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: <Widget>[

                              Padding(
                                padding: const EdgeInsets.only(left:18.0,right: 18.0,top: 28),
                                child: Material(

                                  borderRadius: BorderRadius.circular(20),
                                   elevation: 2,
                                   child: Container(
                                     height: 48,
                                     child: TextField(
                                       controller: number,
                                       keyboardType: TextInputType.number,


                                       decoration: InputDecoration(
                                         hintText: "Phone number",
                                         prefixIcon: Icon(Icons.call),
                                         contentPadding: EdgeInsets.all(8),
                                         border: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(20)
                                         )
                                       ),
                                     ),
                                   ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:18.0,right: 18.0,top: 20),
                                child: Material(

                                  borderRadius: BorderRadius.circular(20),
                                  elevation: 2,
                                  child: Container(
                                    height: 48,
                                    child: TextField(


                                      controller: password,
                                        obscureText:hidden,



                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          prefixIcon: Icon(Icons.lock),
                                          suffixIcon: IconButton(icon: Icon(visibility),onPressed: (){
                                            if(hidden){
                                              hidden=false;
                                              visibility = Icons.visibility;
                                            }else{
                                              hidden = true;
                                              visibility = Icons.visibility_off;
                                            }
                                            setState(() {

                                            });
                                          },),
                                          contentPadding: EdgeInsets.all(8),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20)
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left:18.0,right: 18.0,top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                  Text("Forgot Password ?")
                                ],)
                              ),




                              Padding(
                                padding: const EdgeInsets.only(left:18.0,right: 18.0,top: 80),
                                child: Material(


                                  borderRadius: BorderRadius.circular(20),
                                  elevation: 2,
                                  child: Container(

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(colors: [
                                          Color(0xff3bc25f) ,Color(0xff288a3a),
                                        ])
                                    ),

                                    height: 48,
                                    child: ClipOval(

                                      child: MaterialButton(
                                        child: Center(
                                          child: Text(
                                            "LOGIN",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18
                                            ),
                                          ),
                                        ),
                                        onPressed: (){

                                          if(number.text.isEmpty || password.text.isEmpty){
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text("Invalid credentials"),
                                            ));
                                          }else if(number.text.replaceAll(",", "").replaceAll(".", "").replaceAll("-", "").replaceAll(" ", "").trim().length<10){
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text("Invalid Phone Number"),
                                            ));
                                          }else{
                                           
                                            Firestore.instance.collection("Users").where("number",isEqualTo: number.text).getDocuments().then((data){
                                              var users = data.documents;
                                              if(users.length>0){

                                                var ourUser = users[0];
                                                if(ourUser["password"]==password.text){

                                                DataBaseHelper.store.record("UserData").add(DataBaseHelper.db, [ourUser["name"],ourUser["password"],ourUser["number"],ourUser["address"],ourUser["city"],ourUser["isSeller"]]);
                                                UserData.name = ourUser["name"];UserData.password = ourUser["password"]; UserData.address = ourUser["address"];UserData.city =ourUser["city"];
                                                UserData.isFarmer = ourUser["isSeller"];UserData.number = ourUser["number"];
                                         
                                                  Navigator.of(context).pop();
                                                }else{

                                               Scaffold.of(context).showSnackBar(SnackBar(
                                                    content: Text("Invalid Password"),
                                                  ));

                                                }


                                              }else{

                                                Scaffold.of(context).showSnackBar(SnackBar(
                                                  content: Text("Invalid Users"),
                                                ));

                                              }
                                            });
                                          }

                                        },
                                      ),
                                    )
                                  ),
                                ),
                              ),

                              Padding(
                                  padding: const EdgeInsets.only(left:18.0,right: 18.0,top: 50),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Dont have an account ?"),
                                      GestureDetector(child: Text(" Register",style: TextStyle(color: Colors.orange),),onTap: (){
                                        
                                          var route = CupertinoPageRoute(builder: (context)=>Register());
                                          Navigator.push(context, route);
                                      },)
                                    ],)
                              ),







                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            ),
          )

                    ),
        ),
    );
  }
}