import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_booking/Cloudnary_uploader/cloudnery_uploader.dart';
import 'package:hostel_booking/Model/hostelmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Addhostel extends StatefulWidget {
  const Addhostel({super.key});

  @override
  State<Addhostel> createState() => _AddhostelState();
}

class _AddhostelState extends State<Addhostel> {
  bool option1 = false;
  bool option2 = false;
  bool option3 = false;
  bool option4 = false;
  bool option5 = false;

  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _hostelnameController = TextEditingController();
  final TextEditingController _LocationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _availablebedController = TextEditingController();
   String? uploadedUrl;
   XFile? pickedfile;
 ImagePicker _picker = ImagePicker();
  String? phoneNumber; // ✅ store complete phone number here
  bool isLoading =false;

final cloudinaryUploader = CloudneryUploader();

  Future<void> pickAndUploadImage() async{
    final  pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null)return;

    setState(() {
      pickedfile = pickedFile; 
      isLoading = true;
    });

    final url = await cloudinaryUploader.uploadFile(pickedFile);

    if (url != null){
      
      setState(() {
        uploadedUrl =url;
        isLoading = false;
      });
    }else{
      setState(() {
        isLoading = false;
      });
      print("Upload failed");
    }
  }

  // 🔹 Upload Hostel Data to Firestore
 Future<void> _submitData() async {
  if (_ownerNameController.text.isEmpty ||
      _hostelnameController.text.isEmpty ||
      _LocationController.text.isEmpty ||
      _addressController.text.isEmpty ||
      _priceController.text.isEmpty ||
      _availablebedController.text.isEmpty ||
      phoneNumber == null ||
      uploadedUrl == null) { // ✅ Added check for image
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('⚠️ Please fill all fields and upload an image')),
    );
    return;
  }

  try {
    Hostelmodel body = Hostelmodel();
    body.ownerName = _ownerNameController.text.trim();
    body.hostelName = _hostelnameController.text.trim();
    body.location = _LocationController.text.trim();
    body.address = _addressController.text.trim();
    body.phone = phoneNumber;
    body.price = _priceController.text.trim();
    body.availableBeds = _availablebedController.text.trim();
    body.imageUrl = uploadedUrl;
    body.amenities = Amenities(
      locker: option1,
      furnished: option2,
      food: option3,
      parking: option4,
      attachedBathroom: option5,
    );
    body.createdAt = Timestamp.now();

    await FirebaseFirestore.instance.collection('Hostels').add(body.toJson());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Hostel added successfully!')),
    );

    _ownerNameController.clear();
    _hostelnameController.clear();
    _LocationController.clear();
    _addressController.clear();
    _priceController.clear();
    _availablebedController.clear();
    setState(() {
      option1 = option2 = option3 = option4 = option5 = false;
      phoneNumber = null;
      uploadedUrl = null;
      pickedfile = null;
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('❌ Error: $e')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          "Add Hostel",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Owner Name"),
              TextFormField(
                controller: _ownerNameController,
                decoration: InputDecoration(
                  hintText: "Owner Name",
                  hintStyle: TextStyle(fontSize: 14.sp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
               SizedBox(height: 7.h),
              const Text("Hostel Name"),
              TextFormField(
                controller: _hostelnameController,
                decoration: InputDecoration(
                  hintText: "Hostel Name",
                  hintStyle: TextStyle(fontSize: 14.sp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 7.h),
              const Text("Location"),
              TextFormField(
                controller: _LocationController,
                decoration: InputDecoration(
                  hintText: "Location",
                  hintStyle:  TextStyle(fontSize: 14.sp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
               SizedBox(height: 7.h),
              const Text("Address"),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: "Address",
                  hintStyle: TextStyle(fontSize: 14.sp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
               SizedBox(height: 7.h),
              const Text("Phone Number"),
              IntlPhoneField(
                controller: SearchController(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  phoneNumber = phone.completeNumber;
                },
              ),
               SizedBox(height: 7.h),
              const Text("Price"),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Price",
                  hintStyle:  TextStyle(fontSize: 14.sp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
               SizedBox(height: 7.h),
              const Text("Available Beds"),
              TextFormField(
                controller: _availablebedController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Available Beds",
                  hintStyle:  TextStyle(fontSize: 14.sp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),

               SizedBox(height: 10.h),
              const Text("Amenities"),
              CheckboxListTile(
                title: const Text("Locker"),
                value: option1,
                onChanged: (val) => setState(() => option1 = val!),
              ),
              CheckboxListTile(
                title: const Text("Furnished"),
                value: option2,
                onChanged: (val) => setState(() => option2 = val!),
              ),
              CheckboxListTile(
                title: const Text("Food"),
                value: option3,
                onChanged: (val) => setState(() => option3 = val!),
              ),
              CheckboxListTile(
                title: const Text("Parking"),
                value: option4,
                onChanged: (val) => setState(() => option4 = val!),
              ),
              CheckboxListTile(
                title: const Text("Attached Bathroom"),
                value: option5,
                onChanged: (val) => setState(() => option5 = val!),
              ),
              SizedBox(height: 20.h),

              GestureDetector(
                onTap: () {
                pickAndUploadImage(); 
                },
                child: Container(
                  child:
                  pickedfile == null? Icon(Icons.image_search_sharp,size: 35.sp,):ClipRRect(
                    child:Image.file(File(pickedfile!.path), fit: BoxFit.cover)

                  ),
                  height: 120.h,
                  width: 410.w,
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                ),
              ),

              SizedBox(height: 20.h),
              GestureDetector(
                onTap: _submitData,
                child: Container(
                  height: 68,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child:  Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 27.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}