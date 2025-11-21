import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_booking/Cloudnary_uploader/cloudnery_uploader.dart';
import 'package:hostel_booking/Model/hostelmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class Addhostel extends StatefulWidget {
  const Addhostel({super.key});

  @override
  State<Addhostel> createState() => _AddhostelState();
}

class _AddhostelState extends State<Addhostel> {

  String? selecteddormetry;
  List<String> dormetrytype = [
    "Hostel",
    "Paying guest"
  ];

    String? selectedgenter; 
    List<String> gendertype = [
  "Males Only",
  "Females Only",
  "Mixed",
  
];

  bool option1 = false;
  bool option2 = false;
  bool option3 = false;
  bool option4 = false;
  bool option5 = false;

  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _hostelnameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _availablebedController = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();

  XFile? pickedfile;
  XFile? pickedfile2;
  XFile? pickedfile3;
  XFile? pickedfile4;

  List<String> imageurl = [];
  ImagePicker _picker = ImagePicker();
  String? phoneNumber;
  bool isLoading = false;

  final cloudinaryUploader = CloudneryUploader();

  Future<void> pickAndUploadImage() async {
    List<XFile?> images = [pickedfile, pickedfile2, pickedfile3, pickedfile4];
    imageurl.clear(); // Clear previous URLs

    for (var i = 0; i < images.length; i++) {
      if (images[i] != null) {
        final url = await cloudinaryUploader.uploadFile(images[i]!);
        imageurl.add(url.toString());
      }
    }
  }

  Future<void> _submitData() async {
    // Validation
    if (_ownerNameController.text.isEmpty ||
        _hostelnameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _availablebedController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _discriptionController.text.isEmpty ||
        gendertype.isEmpty||
        dormetrytype.isEmpty||
        phoneNumber == null ||
        pickedfile == null) {
      // ✅ Check if at least one image is picked
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '⚠️ Please fill all fields and upload at least one image',
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Upload images first
      await pickAndUploadImage();

      // Create hostel model
      Hostelmodel body = Hostelmodel();
      body.ownerName = _ownerNameController.text.trim();
      body.hostelName = _hostelnameController.text.trim();
      body.location = _locationController.text.trim();
      body.address = _addressController.text.trim();
      body.phone = phoneNumber;
      body.price = _priceController.text.trim();
      body.availableBeds = _availablebedController.text.trim();
      body.discription = _discriptionController.text.trim();
      body.selectedgenter = selectedgenter;
      body.selecteddormetry = selecteddormetry;

      body.imageUrl = imageurl;
      body.amenities = Amenities(
        locker: option1,
        furnished: option2,
        food: option3,
        parking: option4,
        attachedBathroom: option5,
      );
      body.createdAt = Timestamp.now();

      // Add to Firestore
      await FirebaseFirestore.instance.collection('Hostels').add(body.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Hostel added successfully!')),
      );

      // Clear form
      _ownerNameController.clear();
      _hostelnameController.clear();
      _locationController.clear();
      _addressController.clear();
      _priceController.clear();
      _availablebedController.clear();
      _discriptionController.clear();
      

      setState(() {
        option1 = option2 = option3 = option4 = option5 = false;
        phoneNumber = null;
        pickedfile = null;
        pickedfile2 = null;
        pickedfile3 = null;
        pickedfile4 = null;
        imageurl.clear();
        isLoading = false;
      });

      Navigator.pop(context);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('❌ Error: $e')));
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
      body: Stack(
        children: [
          SingleChildScrollView(
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
                    controller: _locationController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.my_location_outlined),
                        onPressed: () async {
                          final Uri googleMapsUrl = Uri.parse(
                            'https://www.google.com/maps',
                          );

                          if (await canLaunchUrl(googleMapsUrl)) {
                            await launchUrl(
                              googleMapsUrl,
                              mode: LaunchMode
                                  .inAppBrowserView, // Opens in in-app browser
                            );
                          } else {
                            // Handle error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Could not open Google Maps'),
                              ),
                            );
                          }
                        },
                      ),
                      hintText: "Choose location",
                      hintStyle: TextStyle(fontSize: 14.sp),
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
                    Text("Select type"),
                    DropdownButtonFormField<String>(
  decoration: InputDecoration(
    hintText: "Choose type",
    hintStyle: TextStyle(fontSize: 14.sp),
    border: OutlineInputBorder(),
  ),
  value: selectedgenter,
  items: gendertype.map((item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }).toList(),
  onChanged: (value) {
    setState(() {
      selectedgenter = value;
    });
  },
),

SizedBox(height: 7.h),
Text("Select category"),
DropdownButtonFormField<String>(
  decoration: InputDecoration(
    hintText: "Choose category",
     hintStyle: TextStyle(fontSize: 14.sp),
    border: OutlineInputBorder(),
  ),
  value: selecteddormetry,
  items: dormetrytype.map((item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }).toList(),
  onChanged: (value) {
    setState(() {
      selecteddormetry = value;
    });
  },
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
                  
                  const Text("Price"),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Price",
                      hintStyle: TextStyle(fontSize: 14.sp),
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
                      hintStyle: TextStyle(fontSize: 14.sp),
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

                  SizedBox(height: 7.h),

                  const Text("Discription"),
                  TextFormField(
                    maxLines: 3,
                    controller: _discriptionController,
                    decoration: InputDecoration(
                      hintText: "Discription",
                      hintStyle: TextStyle(fontSize: 14.sp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  const Text("Upload Images (At least 1 required)"),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final pickedFile = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          setState(() {
                            pickedfile = pickedFile;
                          });
                        },
                        child: Container(
                          height: 98.h,
                          width: 98.w,
                          decoration: BoxDecoration(border: Border.all()),
                          child: pickedfile == null
                              ? Icon(Icons.image_search_sharp, size: 35.sp)
                              : ClipRRect(
                                  child: Image.file(
                                    File(pickedfile!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () async {
                          final pickedFile2Temp = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          setState(() {
                            pickedfile2 = pickedFile2Temp;
                          });
                        },
                        child: Container(
                          height: 98.h,
                          width: 98.w,
                          decoration: BoxDecoration(border: Border.all()),
                          child: pickedfile2 == null
                              ? Icon(Icons.image_search_sharp, size: 35.sp)
                              : ClipRRect(
                                  child: Image.file(
                                    File(pickedfile2!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () async {
                          final pickedFile3Temp = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          setState(() {
                            pickedfile3 = pickedFile3Temp;
                          });
                        },
                        child: Container(
                          height: 98.h,
                          width: 98.w,
                          decoration: BoxDecoration(border: Border.all()),
                          child: pickedfile3 == null
                              ? Icon(Icons.image_search_sharp, size: 35.sp)
                              : ClipRRect(
                                  child: Image.file(
                                    File(pickedfile3!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () async {
                          final pickedFile4Temp = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          setState(() {
                            pickedfile4 = pickedFile4Temp;
                          });
                        },
                        child: Container(
                          height: 98.h,
                          width: 98.w,
                          decoration: BoxDecoration(border: Border.all()),
                          child: pickedfile4 == null
                              ? Icon(Icons.image_search_sharp, size: 35.sp)
                              : ClipRRect(
                                  child: Image.file(
                                    File(pickedfile4!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: isLoading ? null : _submitData,
                    child: Container(
                      height: 68.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isLoading ? Colors.grey : Colors.lightBlue,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
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
        ],
      ),
    );
  }
}
