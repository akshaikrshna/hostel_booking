import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_booking/BookNow/booknow.dart';
import 'package:hostel_booking/Bookingpage/bookingbage.dart';
import 'package:hostel_booking/Globel/globel.dart';

class Prodectpage extends StatefulWidget {
  final String? imageUrl;
  final String? title;
  final String? price;
  const Prodectpage({super.key,this.imageUrl,this.price,this.title});
  
  @override
  State<Prodectpage> createState() => _ProdectpageState();
}

class _ProdectpageState extends State<Prodectpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new)),
        actions: [
         Padding(
           padding: const EdgeInsets.only(right: 20,bottom: 2),
           child: Icon(Icons.favorite_border_outlined,size: 32,),
         )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: 360.h,
                width: double.infinity,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Image.network("${widget.imageUrl}",fit: BoxFit.cover,),),
              Padding(
                padding: EdgeInsets.only(top: 310.h),
                child: Container(
                  height: 677.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 243, 242, 242),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(28).r,topRight: Radius.circular(28.r))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
        
                      children: [
                          SizedBox(
                            height: 60.h,
                            width: 413.w,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: product.length,
                              itemBuilder: (context, index) {
                              return  Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                    height: 50.h,
                                    width: 95.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r),
                                    image: DecorationImage(image: NetworkImage(product[index].imageUrl),fit: BoxFit.cover),
                                      color: const Color.fromARGB(255, 250, 250, 250)
                                    ),
                                 
                                  ),
                              );
                            },
                            ),
                          ),
                          SizedBox(
                            height: 65.h,
                            child: Row(
                              children: [
                                Text("₹ ${widget.price}",style: TextStyle(
                                  fontSize: 35.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.lightBlue,
                                ),),
                                Text(" /Month",style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  color: const Color.fromARGB(255, 145, 143, 144),
                                ),),
                               Spacer(),
                                Icon(Icons.star,color: Colors.pink,),
                                Text("4.5",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600,
                                ),)
                              ],
                            ),
                          ),
        
                          Text("Amenities",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                          SizedBox(
                            height: 6.h,
                          ),
                         
                          
                          Row(
                            children: [
                               Icon(Icons.check_box,color: Colors.green,size: 23.sp,),
                              Text("Parking",style: TextStyle(fontSize: 18.sp),),
                            ],
                          ),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Row(
                            children: [
                               Icon(Icons.check_box,color: Colors.green,size: 23.sp,),
                              Text("Good food",style: TextStyle(fontSize: 18.sp),),
                            ],
                          ),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Row(
                            children: [
                               Icon(Icons.check_box,color: Colors.green,size: 23.sp,),
                              Text("Attached bathroom",style: TextStyle(fontSize: 18.sp),),
                            ],
                          ),
                            SizedBox(
                              height: 20.h,
                            ),
        
                            GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                height: 199.h,
                                width: 450.w,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 251, 252, 252),
                                ),
                                  child: Image.network("https://media.wired.com/photos/59269cd37034dc5f91bec0f1/191:100/w_1280,c_limit/GoogleMapTA.jpg?mbid=social_retweet",fit: BoxFit.cover,),
                              ),
                            ),
                      ],
                    ),
                  ),
                  
                ),
              ),
            ]
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 200.h,
        width: 100.w,
        child: Column(
          children: [

            Divider(),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top:10 ),
                            child: Row(
                              children: [
                                Container(
                                  height: 65.h,
                                  width: 65.w,
                                  
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage("https://t3.ftcdn.net/jpg/06/99/46/60/360_F_699466075_DaPTBNlNQTOwwjkOiFEoOvzDV0ByXR9E.jpg",),  fit: BoxFit.cover),
                                  color: const Color.fromARGB(31, 37, 34, 34),
                                  borderRadius: BorderRadius.circular(18.r)
                                ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Hostel Owner",style: TextStyle(
                                      fontSize: 15.sp, color: const Color.fromARGB(255, 134, 133, 133)
                                    ),),
                                    Text("AlbertFlores",style: TextStyle(
                                      fontSize: 19.sp,fontWeight: FontWeight.w500
                                    ),)
                                  ],
                                ),
                                SizedBox(
                                  width: 175.w,
                                ),
                                CircleAvatar(radius: 25.r,backgroundColor: Colors.lightGreen,
                                child: Icon(Icons.call,color: Colors.white,size: 35.sp,),
                                )
                              ],
                            ),
                          ),
            Padding(
                              padding: const EdgeInsets.all( 13),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Booknow(),));
                                },
                                child: Container(
                                  height: 68.h,
                                  width: 420.w,
                                 decoration: 
                                 BoxDecoration( color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(20.r)
                                 ),
                                 child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,MaterialPageRoute(builder:(context) => Bookingpage(),));
                                  },
                                   child: Center(child: Text("Book Now",style: TextStyle(
                                    fontSize: 27.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(255, 245, 240, 240)
                                   ),)),
                                 ),
                                ),
                              ),
                            ),
          ],
        ),
      ),
    );
    
  }
}