import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:hostel_booking/Model/hostelmodel.dart';

class Adminhome extends StatefulWidget {
  const Adminhome({super.key});

  @override
  State<Adminhome> createState() => _AdminhomeState();
}

class _AdminhomeState extends State<Adminhome> {
  final List<Map<String, dynamic>> hostels = [
    // {
    //   'image': 'https://cdn.houseplansservices.com/product/g8don8g8g04bdnb7mfss65rj62/w560x373.jpg?v=2',
    //   'price': '₹5,000/month',
    //   'rating': '4.5',
    //   'title': 'Sunrise Hostel',
    //   'city': 'Mumbai',
    // },
    // {
    //   'image': 'https://cdn.houseplansservices.com/content/9a0kud8eguqun8d72nctn0all2/w991x660.jpg?v=10',
    //   'price': '₹4,500/month',
    //   'rating': '4.2',
    //   'title': 'Ocean View Hostel',
    //   'city': 'Goa',
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffFEAA61),
        title: Text(
          'Added Hostels',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: CircleAvatar(
            radius: 20.r,
            backgroundColor: const Color.fromARGB(255, 224, 222, 222),
            child: Icon(Icons.person, color: Color(0xffFEAA61), size: 25.sp),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 16.h),

            StreamBuilder(stream: FirebaseFirestore.instance.collection('Hostels').where('hostelerId',isEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots(), builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xffFEAA61),
                    ),
                  );
                }
      
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                     return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_work_outlined,
                          size: 80.sp,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "No hostels found",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }
      
               final docs = snapshot.data!.docs;

               final List<Hostelmodel> hostels = docs.map((doc) {
  final data = doc.data() as Map<String, dynamic>;

  final hostel = Hostelmodel.fromJson(data);
  hostel.hostelid = doc.id; 

  return hostel;
}).toList();

              return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hostels.length,
              itemBuilder: (context, index) {
                final hostel = hostels[index];
                return _buildHostelCard(hostel);
              },
            );
            },),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHostelCard(Hostelmodel hostel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Card(
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            // Navigate to hostel details
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              Stack(
                children: [
                  Image.network(
                                          hostel.imageUrl == null
                                              ? 'https://karnatakatourism.org/wp-content/uploads/2020/06/Mysuru-Palace-banner-1920_1100.jpg'
                                              : hostel.imageUrl!.first,
                                          height: 200.h,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                  
                ],
              ),

              // Details Section
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            hostel.hostelName ?? '',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Text(
                          hostel.price != null ? '₹${hostel.price}/month' : '',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFEAA61),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16.sp,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          hostel.place ?? '',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.edit, size: 18.sp),
                            label: Text('Edit', style: TextStyle(fontSize: 14.sp)),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Color(0xffFEAA61),
                              side: BorderSide(color: Color(0xffFEAA61)!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                          ),
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
    );
  }
}