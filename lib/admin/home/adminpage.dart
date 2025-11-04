import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class Adminpage extends StatefulWidget {
  const Adminpage({super.key});

  @override
  State<Adminpage> createState() => _HomepageState();
}

class _HomepageState extends State<Adminpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(radius: 9.r),
      ),
    body: SingleChildScrollView(
      child: Column(
        children: [
            Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    "https://cdn.houseplansservices.com/product/g8don8g8g04bdnb7mfss65rj62/w560x373.jpg?v=2",
                    height: 180.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "price",
                              style:  TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue,
                              ),
                            ),
                            Row(
                              children: [
                                 Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18.sp,
                                ),
                                Text(
                                  "rating",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                         SizedBox(height: 6.h),
                        Text(
                          "title",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                           Icon(
                              Icons.location_on,
                              size: 16.sp,
                              color: Colors.grey,
                            ),
                             SizedBox(width: 4.w),
                            Text(
                              "City",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

            Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    "https://cdn.houseplansservices.com/content/9a0kud8eguqun8d72nctn0all2/w991x660.jpg?v=10",
                    height: 180.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "price",
                              style:  TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue,
                              ),
                            ),
                            Row(
                              children: [
                                 Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 18.sp,
                                ),
                                Text(
                                  "rating",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                         SizedBox(height: 6.h),
                        Text(
                          "title",
                          style:  TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                         SizedBox(height: 4.h),
                        Row(
                          children: [
                             Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.grey,
                            ),
                             SizedBox(width: 4.h),
                            Text(
                              "City",
                              style:  TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),         
        ]        
      ),
    ),
    );
  }
}
