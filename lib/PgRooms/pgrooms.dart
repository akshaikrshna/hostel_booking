import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pgrooms extends StatefulWidget {
  const Pgrooms({super.key});

  @override
  State<Pgrooms> createState() => _PgroomsState();
}

class _PgroomsState extends State<Pgrooms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFEAA61),
        title: Text("PG Rooms", style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: SizedBox(height: double.infinity,
      width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// SEARCH BAR
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextField(
                  style: TextStyle(fontSize: 14.sp),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                    hintText: "Search Pg's...",
                  ),
                ),
              ),
        
              SizedBox(height: 20.h),
        
              /// TITLE
              Text(
                "Available Pg's",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
        
              SizedBox(height: 12.h),
        
              /// LIST
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 70.w,
                            height: 70.w,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(Icons.home, size: 32.sp),
                          ),
        
                          SizedBox(width: 14.w),
        
                          /// DETAILS
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Green Stay",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
        
                                SizedBox(height: 4.h),
        
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined, size: 16.sp),
                                    SizedBox(width: 4.w),
                                    Expanded(
                                      child: Text(
                                        "kochi",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.grey[600],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
        
                                SizedBox(height: 4.h),
        
                                Text(
                                  "₹45,000",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xffFEAA61),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}