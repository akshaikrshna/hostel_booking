import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_booking/Login/loginpage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _profileState();
}

class _profileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.lightBlue,
        title: Center(child: Text(" Profile",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),)),
      ),
      body: Column(
        children: [
          Stack(
            children: [ Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.r),bottomRight: Radius.circular(20.r))
              ),
              
            ),
                         Center(
               child: Column(
                 children: [
                   CircleAvatar(
                    radius: 55.r,
                    backgroundColor: const Color.fromARGB(255, 248, 247, 247),
                    child: Icon(Icons.person,size: 55.sp,),
                               ),
                                           SizedBox(height: 7.h,),
            Text("User",style: TextStyle(fontSize: 12,color: const Color.fromARGB(255, 236, 234, 234),fontWeight: FontWeight.w500),),

            SizedBox(height: 1.h,),
            Text("Swalih ibnu muhammed",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500),),
                 ],
               ),
             ),
             
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 5.w,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email"),
                         Text("swalih@gmail.com"),
                      ],
                    )
                  ],
                ),
                
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 12,right: 12),
          child: Divider(),
        ),
         Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.phone_iphone_sharp),
                    SizedBox(width: 5.w,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Phone"),
                         Text("9876543210"),
                      ],
                    )
                  ],
                ),
                
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 12,right: 12),
          child: Divider(),
        ),
         Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.flash_on_outlined),
                    SizedBox(width: 5.w,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("What's new"),
                         Text("Improved performance and faster loading, \nBug fixes and stability updates",style: TextStyle(fontSize: 10.sp),),
                      ],
                    )
                  ],
                ),
                
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 12,right: 12),
          child: Divider(),
        ),
           GestureDetector(onTap: () async{
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
        ],
      ),
    );
  }
}