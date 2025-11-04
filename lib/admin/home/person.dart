import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_booking/Login/loginpage.dart';
import 'package:hostel_booking/admin/home/addhostel.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Profile",style: TextStyle(fontSize: 26.sp,fontWeight: FontWeight.w500),)),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 55.r,
              child: Icon(Icons.person,size: 55.sp,),
            ),
            SizedBox(height: 7.h,),
            Text("Vendor",style: TextStyle(fontSize: 12.sp,color: const Color.fromARGB(255, 176, 167, 167),fontWeight: FontWeight.w500),),

            SizedBox(height: 1.h,),
            Text("Akshay krishna k",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500),),

            SizedBox(height: 12.h,),
           Padding(
             padding: const EdgeInsets.only(left: 15,right: 15),
             child: Card(
               child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Icon(Icons.mail,color: Colors.blue,),
                ),
                title: Text("Email"),
                subtitle: Text("akshay@gmail.com"),
               ),
             ),
           ),
              Padding(
             padding: const EdgeInsets.only(left: 15,right: 15),
             child: Card(
               child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Icon(Icons.phone,color: Colors.blue,),
                ),
                title: Text("Phone"),
                subtitle: Text("987654321"),),
                ),
                ),
                  Padding(
             padding: const EdgeInsets.only(left: 15,right: 15),
             child: Card(
               child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Icon(Icons.location_city,color: Colors.blue,),
                ),
                title: Text("City"),
                subtitle: Text("Manjeri"),),
                ),
              ),
                Padding(
             padding: const EdgeInsets.only(left: 15,right: 15),
             child: Card(
               child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Addhostel(),));
                },
                 child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 110,),
                    child: Icon(Icons.add_circle_outline_rounded,color: Colors.blue,),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 21),
                    child: Text("Add Hostel"),
                  ),
                  subtitle: Text(""),
                  ),
               ),
                ),
                ),
                SizedBox(height: 10.h,),
                Padding(
                  padding: const EdgeInsets.only(right:20),
                  child: GestureDetector(
                  onTap: () async{
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Loginpage(),));
                  },
                    child: Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.logout,color: Colors.red,),
                        Text("Logout",style: TextStyle(color: Colors.red),)
                      ],
                    ),
                  ),
                )
            
          ],
          
        ),
      ),
      
    );
  }
}