
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_booking/BookNow/address.dart';
import 'package:hostel_booking/Model/hostelmodel.dart';
import 'package:hostel_booking/Model/booking_model.dart';
import 'package:hostel_booking/utils/helper/razorpay_service/razorpay.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BookingPage extends StatefulWidget {
  final Hostelmodel? hosteldetailes;

  
  const BookingPage({super.key, required this.hosteldetailes});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {

  int _selectedTab = 0;
  String _selectedRoom = "Single Room";

  double _roomPrice = 0;
  double _tax = 0;
  double _guests = 1;
  double _totalAmount = 0;

  DateTime? _checkInDate;
int _months = 1;
  

  Future<void> _pickCheckInDate() async {
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 365)),
  );

  if (picked != null) {
    setState(() {
      _checkInDate = picked;
    });
  }
}

  List<Map<String, dynamic>> addresses = [
    {
      "name": "John Doe",
      "address": "123 Main Street, Downtown",
      "city": "New York",
      "pincode": "10001",
      "phone": "+1 234 567 8900",
      "type": "Home"
    },
    {
      "name": "John Doe",
      "address": "456 Office Park, Business District",
      "city": "New York",
      "pincode": "10002",
      "phone": "+1 234 567 8900",
      "type": "Office"
    }
  ];

  int _selectedAddressIndex = 0;


@override
void dispose() {

  super.dispose();
}


  @override
  void initState() {
    super.initState();
    print(" Hostel Details: ${widget.hosteldetailes?.hostelerid}");
    // Initialize price calculation
    _calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(0xffFEAA61),
        title: Text(
          'Hostel Booking',
          style: TextStyle(
            color: Color(0xff090807),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Colors.white,
            child: Row(
              children: [
                _buildTab(0, "Details"),
                _buildTab(1, "Address"),
                _buildTab(2, "Payment"),
              ],
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedTab,
              children: [
                _buildDetailsTab(),
                _buildAddressTab(),
                _buildPaymentTab(),
              ],
            ),
          ),
          // Bottom Payment Bar
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String title) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _selectedTab == index ? Color(0xffFEAA61) : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _selectedTab == index ? Color(0xffFEAA61) : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hostel Info Card
          Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                                "${widget.hosteldetailes?.imageUrl!.first}",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.hosteldetailes?.hostelName ?? "",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                              
                                Icon(Icons.location_on, color: Colors.grey, size: 16),
                                SizedBox(width: 4),
                                Text(widget.hosteldetailes?.place ?? "", style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 8),
                  Text(
                    "${widget.hosteldetailes?.discription}",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
        SizedBox(height: 16),

          // Guest Selection
          Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Number of Beds",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Beds"),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (_guests > 1) {
                                setState(() {
                                  _guests--;
                                  _calculateTotal();
                                });
                              }
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Icon(Icons.remove, size: 20),
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            "$_guests",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 16),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _guests++;
                                _calculateTotal();
                              });
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Icon(Icons.add, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),

/// CHECK-IN DATE
Card(
  elevation: 2,
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Check-in Date",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        InkWell(
          onTap: _pickCheckInDate,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _checkInDate == null
                      ? "Select check-in date"
                      : DateFormat("dd MMM yyyy").format(_checkInDate!),
                  style: TextStyle(fontSize: 16),
                ),
                Icon(Icons.calendar_today, color: Color(0xffFEAA61)),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
),

SizedBox(height: 16),

/// STAY DURATION
Card(
  elevation: 2,
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Stay Duration",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Months"),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (_months > 1) {
                      _months--;
                      _calculateTotal();
                    }
                  },
                  icon: Icon(Icons.remove_circle_outline),
                ),
                Text(
                  "$_months",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    _months++;
                    _calculateTotal();
                  },
                  icon: Icon(Icons.add_circle_outline),
                ),
              ],
            )
          ],
        ),
      ],
    ),
  ),
),

        ],
      ),
    );
  }
  Widget _buildAddressTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Address",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ...List.generate(addresses.length, (index) {
            return _buildAddressCard(index);
          }),
          SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddressManagementPage(),));
            },
            icon: Icon(Icons.add),
            label: Text("Add New Address"),
            style: OutlinedButton.styleFrom(
              foregroundColor: Color(0xffFEAA61),
              side: BorderSide(color: Color(0xffFEAA61)),
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(int index) {
    final address = addresses[index];
    bool isSelected = _selectedAddressIndex == index;
    
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 12),
      color: isSelected ? Color(0xFF2874F0).withOpacity(0.1) : Colors.white,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedAddressIndex = index;
          });
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Color(0xffFEAA61) : Colors.grey,
                    width: 2,
                  ),
                  color: isSelected ? Color(0xffFEAA61) : Colors.transparent,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          address["name"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            address["type"],
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(address["address"]),
                    Text("${address["city"]} - ${address["pincode"]}"),
                    SizedBox(height: 4),
                    Text(address["phone"]),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _editAddress(index),
                icon: Icon(Icons.edit, color: Color(0xffFEAA61)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price Breakdown
          Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Price Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  _buildPriceRow("Room Price (${_guests} bed(s) ", 
                      "₹${NumberFormat().format(_roomPrice.toInt())}"),
                  _buildPriceRow("Taxes & Fees", "₹${NumberFormat().format(_tax.toInt())}"),
                  Divider(),
                  _buildPriceRow(
                    "Total Amount",
                    "₹${NumberFormat().format(_totalAmount.toInt())}",
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),

          // Payment Methods
          
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? Color(0xffFEAA61) : Colors.black,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Color(0xffFEAA61) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "₹${NumberFormat().format(_totalAmount.toInt())}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFEAA61),
                  ),
                ),
                Text(
                  "Total Amount",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: _proceedToNextStep,
              child: Text(
                _selectedTab == 2 ? "Pay Now" : "Continue",
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFEAA61),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _proceedToNextStep() async{
    FirebaseAuth _auth=FirebaseAuth.instance;
    if (_selectedTab == 2) {
  if (_checkInDate == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please select check-in date")),
    );
    return;
  }
}
    if (_selectedTab < 2) {
      setState(() {
        _selectedTab++;
      });
    } else {
      try{
        PaymentModel body = PaymentModel();

        body.hostelname = widget.hosteldetailes?.hostelName;
        body.hostelprice = widget.hosteldetailes?.price;
        body.hostelid = widget.hosteldetailes?.hostelid;
        body.userid =_auth.currentUser?.uid; 
        body.bedconunt = _guests.toString();
        body.grandtotal = _roomPrice.toString();
        body.paymentstatus = "pending";
        body.status = 1;
        body.hostelerid = widget.hosteldetailes?.hostelerid;
        body.checkindate = Timestamp.fromDate(_checkInDate!);
        body.months = _months.toString();

         await FirebaseFirestore.instance.collection('booking').add(body.toJson()).then((value) {
          body.bookingid = value.id;
           value.update(body.toJson());
         },);

        final razorpayService = RazorpayService(
  context: context,
  onSuccess: (PaymentSuccessResponse response) async {
    body.paymentstatus = "success";
    

    if (body.bookingid != null && body.bookingid!.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('booking')
          .doc(body.bookingid)
          .update(body.toJson());
    }

    _processPayment();
  },
  onError: (PaymentFailureResponse response) async{
     body.paymentstatus = "Failed";


    if (body.bookingid != null && body.bookingid!.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('booking')
          .doc(body.bookingid)
          .update(body.toJson());
    }
    debugPrint("Payment failed");
  },
);

// ✅ USE SAME INSTANCE
razorpayService.openCheckout(
  key: "rzp_test_RQX7adT0U42yu4",
  amount: (_totalAmount * 100).toInt(),
);

      }catch(e){

      }
    
    }
  }

  void _calculateTotal() {
  double pricePerBedPerMonth = widget.hosteldetailes?.price != null
      ? double.parse(widget.hosteldetailes!.price.toString())
      : 1000.0;

  _roomPrice = pricePerBedPerMonth * _guests * _months;
  _totalAmount = _roomPrice;

  setState(() {});
}

  

  void _editAddress(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Address"),
        content: Text("Edit address form would go here"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  void _processPayment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment Successful!"),
        content: Text("Your booking has been confirmed."),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}