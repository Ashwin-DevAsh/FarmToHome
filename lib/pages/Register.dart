import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_portal/DataBase/DataBaseHelper.dart';
import 'package:farmer_portal/Datas/UserData.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController address = new TextEditingController();
  TextEditingController number = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController city = new TextEditingController();

  var hidden = true;
  IconData  visibility = Icons.visibility_off;

  var seller = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:   Builder(
      builder:(context)=> Container(
          decoration: BoxDecoration(

              gradient: LinearGradient(colors: [
                Color(0xff3bc25f) ,Color(0xff288a3a),
              ])
          ),

          child: Column(
            children: <Widget>[
              Container(

                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:22.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back,color: Colors.white,),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                    ),

                   
                    
                  ],
                ),

                height: 90,
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
                              controller: name,

                              decoration: InputDecoration(
                                  hintText: "Name",
                                  prefixIcon: Icon(Icons.person),
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
                              obscureText: hidden,
                              controller: password,
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
                        child: ListTile(
                          leading: Icon(Icons.monetization_on,color: Colors.black,),
                          title: Text("Activate Seller Account",style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: Switch(

                            activeColor: Theme.of(context).primaryColor,
                            value: seller,
                            onChanged: (value){

                              setState(() {
                                seller = value;
                              });

                            },
                          ),
                        )
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 18.0,top: 8),
                        child: Column(
                          children: <Widget>[

                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Material(

                                borderRadius: BorderRadius.circular(20),
                                elevation: 2,
                                child: Container(
                                  height: 48,
                                  child: TextField(

                                    controller: address,

                                    decoration: InputDecoration(
                                        hintText: "Address",
                                        prefixIcon: Icon(Icons.add_circle),
                                        suffixIcon: IconButton(icon: Icon(Icons.location_on),onPressed: ()async{

                                          LocationData currentLocation ;

                                          var location = new Location();


                                          try {
                                            currentLocation = await location.getLocation();
                                            List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(currentLocation.latitude,currentLocation.longitude);
                                            Placemark place = placemark[0];
                                            address.text =  "${place.subLocality} , ${place.locality}-${place.postalCode}, ${place.administrativeArea} , ${place.country}";

                                             city.text = "${place.locality}";

                                          }catch (e) {
                                            if (e.code == 'PERMISSION_DENIED') {

                                            }
                                            currentLocation = null;
                                          }

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

                          ],
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
                              controller: city,
                              decoration: InputDecoration(
                                  hintText: "City",
                                  prefixIcon: Icon(Icons.add_circle),

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
                          padding: const EdgeInsets.only(left:18.0,right: 18.0,top: 80),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Checkbox(
                                activeColor: Colors.orange,
                                value: true,
                                onChanged: (_){},
                              ),
                              Text(" Accept Terms & Conditions",)
                            ],)
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left:18.0,right: 18.0,top: 20),
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
                                      "SIGNUP",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18
                                      ),
                                    ),
                                  ),
                                  onPressed: (){
                                    if(name.text.isEmpty || number.text.isEmpty || password.text.isEmpty || address.text.isEmpty || city.text.isEmpty ){
                                           Scaffold.of(context).showSnackBar(SnackBar(
                                             content: Text("Invalid Crediantials"),
                                           ));
                                    }else if(password.text.length<8){
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text("Invalid Password"),
                                      ));
                                    }else if(number.text.replaceAll(",", "").replaceAll(".", "").replaceAll("-", "").replaceAll(" ", "").trim().length<10){
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text("Invalid Phone Number"),
                                      ));
                                    }
                                    else{

                                      Firestore.instance.collection("Users").where("number",isEqualTo:number.text ).getDocuments().then((data){
                                         var users = data.documents;
                                         if(users.length==0){
                                           UserData.name = name.text;UserData.password = password.text; UserData.address = address.text;UserData.city = city.text;
                                           UserData.isFarmer = seller;UserData.number = number.text;
                                           DataBaseHelper.store.record("UserData").add(DataBaseHelper.db, [name.text,password.text,number.text.replaceAll(",", "").replaceAll(".", "").replaceAll("-", "").replaceAll(" ", "").trim(),address.text,city.text,seller]);

                                           Scaffold.of(context).showSnackBar(SnackBar(
                                             content: Text("Register Successfully"),
                                           ));

                                           Firestore.instance.collection("Users").add({
                                             "name":name.text,
                                             "password":password.text,
                                             "number":number.text.replaceAll(",", "").replaceAll(".", "").replaceAll("-", "").replaceAll(" ", "").trim(),
                                             "address":address.text,
                                             "city":city.text,
                                             "isSeller":seller
                                           });

                                           Future.delayed(Duration(milliseconds: 1500),(){
                                             Navigator.of(context).pop();
                                             Navigator.of(context).pop();

                                           });

                                         }else{

                                           Scaffold.of(context).showSnackBar(SnackBar(
                                             content: Text("User already exist"),
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











                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
