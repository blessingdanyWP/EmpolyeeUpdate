import 'package:EmployeeUpdate/services/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller= TextEditingController();
    TextEditingController agecontroller= TextEditingController();
    TextEditingController locationcontroller= TextEditingController();
    return Scaffold(appBar:   AppBar(title:  Row(
          mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Employee ',style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold),),
          Text('Fill-in',style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold),)
        ],),),  
       
      body: Container(
        margin: EdgeInsets.only(left: 20,top: 30,right: 20),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
              child: TextField(
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
              controller: locationcontroller,
              decoration: InputDecoration(border:InputBorder.none),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(onPressed: ()async{
                String id= randomAlphaNumeric(10);
                Map<String, dynamic> employeeInfoMap={
                  "Name":namecontroller.text,
                  "Age":agecontroller.text,
                  "Id": id,
                  "Location":locationcontroller.text,
                };
                await DatabaseMethods().addEmployeeDetails(employeeInfoMap, id).then((value) {
                  Fluttertoast.showToast(
        msg: "Employee Details have been added successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
                });
                
              
              }, child: Text("Add", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
            )
          ],
        ),
      ),
    );
  }
}