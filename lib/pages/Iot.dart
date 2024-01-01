import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_portal/Datas/UserData.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Iot extends StatefulWidget {
  @override
  _IotState createState() => _IotState();
}

class _IotState extends State<Iot> {
  var soc_1=0;
  var soc_2=0;
  var soc_3=0;
  var id;
  loadState()async{

    var data = await Firestore.instance.collection("Iot").where("id",isEqualTo:UserData.number).getDocuments();
    var values = data.documents[0];

    setState(() {
        soc_1=values["soc_1"];
        soc_2=values["soc_2"];
        soc_3=values["soc_3"];
        id = values.documentID;
    });





  }


  @override
  void initState() {
     loadState();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("IOT Management"),),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("Motor",style: TextStyle(fontWeight: FontWeight.bold,),),
                          trailing: Switch(
                            value: soc_1==0,
                            onChanged: (_){
                              


                              setState(() {

                                if(_){
                                soc_1=0;
                              }else{
                                soc_1=1;
                              }
                                
                              });

                              Firestore.instance.collection("Iot").document(id).updateData({"soc_1":soc_1});
                              
                            

                            },
                          ),
                        ),
                        ListTile(
                          title: Text("Pump Set",style: TextStyle(fontWeight: FontWeight.bold,),),
                          trailing: Switch(
                            value: soc_2==0,
                            onChanged: (_){
                              setState(() {
                                    if(_){
                                soc_2=0;
                              }else{
                                soc_2=1;
                              }
                                
                              });
                            

                              Firestore.instance.collection("Iot").document(id).updateData({"soc_2":soc_2});

                            
                            },
                          ),
                        ),
                        ListTile(
                          title: Text("Light",style: TextStyle(fontWeight: FontWeight.bold,),),
                          trailing: Switch(
                            value: soc_3==0,
                            onChanged: (_){
                            
                              setState(() {

                                  if(_){
                                soc_3=0;
                              }else{
                                soc_3=1;
                              }

                                
                              });

                              Firestore.instance.collection("Iot").document(id).updateData({"soc_3":soc_3});


                            },
                          ),
                        ),

                        Divider(),

                        Padding(
                          padding: const EdgeInsets.only(top:3.0),
                          child: Center(child: Text("Sechedule",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 18),),),
                        ),

                       
                      ],
                    ),
                  ),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(bottom:4.0),
                              child: Icon(FontAwesomeIcons.camera,color: Colors.red,),
                            ),
                            title:Text("View Farm",style: TextStyle(fontWeight: FontWeight.bold),),
                            trailing: Icon(Icons.arrow_forward_ios,size: 12,),
                            onTap: (){},
                          ),
               )
          ],),
        ),
    );
  }
}