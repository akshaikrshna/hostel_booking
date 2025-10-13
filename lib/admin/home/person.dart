import 'package:flutter/material.dart';
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
        title: Center(child: Text("Profile",style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500),)),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 55,
              child: Icon(Icons.person,size: 55,),
            ),
            SizedBox(height: 7,),
            Text("Vendor",style: TextStyle(fontSize: 12,color: const Color.fromARGB(255, 176, 167, 167),fontWeight: FontWeight.w500),),

            SizedBox(height: 1,),
            Text("Akshay krishna k",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),

            SizedBox(height: 12,),
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
                    padding: const EdgeInsets.only(left: 100,),
                    child: Icon(Icons.add_circle_outline_rounded,color: Colors.blue,),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Add Hostel"),
                  ),
                  subtitle: Text(""),
                  ),
               ),
                ),
                ),
                SizedBox(height: 6,),
                Container(
                  height: 42,
                  width: 120,
                 decoration: BoxDecoration(
                  color:Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  
                 ),
                 child: Padding(
                   padding: const EdgeInsets.only(left: 22),
                   child: Row(
                     children: [
                       Icon(Icons.logout),
                       Text("Logout")
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