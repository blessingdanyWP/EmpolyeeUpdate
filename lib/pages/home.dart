

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:EmployeeUpdate/pages/fillin.dart';
import 'package:EmployeeUpdate/services/database.dart';
import 'package:flutter/material.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController namecontroller= TextEditingController();
  TextEditingController agecontroller= TextEditingController();
  TextEditingController locationcontroller= TextEditingController();
  
  Stream? employeeStream;

  getontheload()async{
    employeeStream = await DatabaseMethods().getEmployeeDetails();
    setState(() {
      
    });
  }

  @override
  void initState() {
    getontheload();
    // TODO: implement initState
    super.initState();
  }

  Widget allEmployeeDetils() {
    return 
    StreamBuilder( stream:employeeStream, builder:  (context, AsyncSnapshot snapshot) {
      return snapshot.hasData
          ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds=snapshot.data.docs[index];
              return Container(
                margin: EdgeInsets.only(bottom:20),
                child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(10)),
                  child: (Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        

                        children: [
                          Text(
                            "Name: "+ds["Name"],
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          GestureDetector(
                          onTap: (){
                            namecontroller.text = ds["Name"];
                            agecontroller.text = ds["Age"];
                            locationcontroller.text = ds["Location"];
                            EditEmployeeDetails(ds["Id"]);
                          },   
                          child: Icon(Icons.edit, color: Colors.orange,),),

                          SizedBox(width:5),
                        
                          GestureDetector(
                            onTap: ()async{
await DatabaseMethods().deleteEmployeeDetail(ds["Id"]);
                            },
                            child: Icon(Icons.delete, color: Colors.orange,),)
                          
                        
                          
                        ],
                      ),
                
                      
                      Text(
                        "Age: "+ds["Age"],
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Location: "+ds["Location"],
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                ),
                            ),
              );
            })
          : Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Employee(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Firebase',
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30),
        child: Column(
          children: [
            Expanded(child: allEmployeeDetils()),
            
          ],
        ),
      ),
    );
  }

  Future EditEmployeeDetails(String id) => showDialog(context: context, builder: (context) => AlertDialog(
    contentPadding: EdgeInsets.all(0),
    content: Container(
      height: 450,
      width: 300,
      padding: EdgeInsets.all(8),
      
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        
       
                      color: Color.fromARGB(150, 202, 182, 247),),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context, );}
            ,
            child: Icon(Icons.cancel)),
            SizedBox(width: 60,),
            Text(
              'Edit ',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Details',
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
            
        ],
        ),
         Text('Name', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
              child: TextField(
              style: TextStyle(fontWeight: FontWeight.bold),
              controller: namecontroller,
              decoration: InputDecoration(border:InputBorder.none),
              ),
            ),

            SizedBox(height: 15.0),
            
            Text('Age', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
              child: TextField(
                keyboardType: TextInputType.number,
              style: TextStyle(fontWeight: FontWeight.bold),
              controller: agecontroller,
              decoration: InputDecoration(border:InputBorder.none),
              ),
            ),

            SizedBox(height: 15.0),

            Text('Location', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
              child: TextField(
                
                style: TextStyle(fontWeight: FontWeight.bold),
              controller: locationcontroller,
              decoration: InputDecoration(border:InputBorder.none),
              ),
            ),
            SizedBox(height: 30.0),
            Center(child:ElevatedButton(onPressed: ()async{
              Map<String, dynamic> updateInfo={
                "Name": namecontroller.text,
                "Age": agecontroller.text,
                "Id": id,
                "Location": locationcontroller.text
              };
              await DatabaseMethods().updateEmployeeDetail(id, updateInfo).then((value) {
                Navigator.pop(context);
              });
            }, child: Text("Update"),))
         
      ]),
    ),
  ));
}
