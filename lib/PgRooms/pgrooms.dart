import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Pgrooms extends StatefulWidget {
  @override
  _PgroomsState createState() => _PgroomsState();
}

class _PgroomsState extends State<Pgrooms> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int guests = 1;
  int rooms = 1;
  String selectedRoomType = 'Standard';

  final Color primaryColor = Color(0xffFEAA61);
  final Color backgroundColor = Colors.white;
  final Color cardColor = Color(0xff1A1918);
  final Color textColor = Colors.black;

  final List<Map<String, dynamic>> roomTypes = [
    {
      'type': 'Standard',
      'price': 99,
      'image': '🏨',
      'description': 'Comfortable room with basic amenities',
      'features': ['Free WiFi', 'TV', 'AC', '1 Bed']
    },
    {
      'type': 'Deluxe',
      'price': 149,
      'image': '🏢',
      'description': 'Spacious room with premium features',
      'features': ['Free WiFi', 'TV', 'AC', 'King Bed', 'Mini Bar']
    },
    {
      'type': 'Suite',
      'price': 249,
      'image': '🏛️',
      'description': 'Luxurious suite with separate living area',
      'features': ['Free WiFi', 'TV', 'AC', 'King Bed', 'Mini Bar', 'Jacuzzi']
    },
  ];

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12, 31),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: primaryColor,
            colorScheme: ColorScheme.dark(primary: primaryColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
        } else {
          checkOutDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Book Your Stay',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xffFEAA61),
            fontSize: 20,
          ),
        ),
        backgroundColor: cardColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primaryColor),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: primaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Card
            _buildSearchCard(),
            SizedBox(height: 24),
            
            // Room Types Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Available Rooms',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Choose the perfect room for your stay',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // Room Type List
            ...roomTypes.map((room) => _buildRoomCard(room)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Date Selection Row
            Row(
              children: [
                Expanded(
                  child: _buildDateField(
                    'Check-in',
                    checkInDate,
                    true,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildDateField(
                    'Check-out',
                    checkOutDate,
                    false,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Guests and Rooms Row
            Row(
              children: [
                Expanded(
                  child: _buildCounterField('Guests', guests, (value) {
                    setState(() => guests = value);
                  }),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildCounterField('Rooms', rooms, (value) {
                    setState(() => rooms = value);
                  }),
                ),
              ],
            ),
            SizedBox(height: 20),
            
            // Search Button
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle search functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                ),
                child: Text(
                  'Search Rooms',
                  style: TextStyle(
                    color: backgroundColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, bool isCheckIn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectDate(context, isCheckIn),
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[900]!.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[700]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: 12),
                Text(
                  date != null 
                    ? DateFormat('MMM dd, yyyy').format(date)
                    : 'Select Date',
                  style: TextStyle(
                    color: date != null ? textColor : Colors.grey[500],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCounterField(String label, int value, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[900]!.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[700]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: value > 1 ? () => onChanged(value - 1) : null,
                icon: Icon(Icons.remove, color: primaryColor),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
              Text(
                value.toString(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => onChanged(value + 1),
                icon: Icon(Icons.add, color: primaryColor),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoomCard(Map<String, dynamic> room) {
    bool isSelected = selectedRoomType == room['type'];
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: isSelected 
            ? Border.all(color: primaryColor, width: 2)
            : Border.all(color: Colors.grey[800]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Room Icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: primaryColor.withOpacity(0.3)),
                  ),
                  child: Center(
                    child: Text(
                      room['image'],
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                
                // Room Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            room['type'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Text(
                            '\$${room['price']}/night',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        room['description'],
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      
                      // Features
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: room['features'].map<Widget>((feature) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: primaryColor.withOpacity(0.3)),
                            ),
                            child: Text(
                              feature,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Book Now Button
            Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedRoomType = room['type'];
                  });
                  // Navigate to booking details page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected ? primaryColor : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: primaryColor),
                  ),
                ),
                child: Text(
                  isSelected ? 'Selected' : 'Select Room',
                  style: TextStyle(
                    color: isSelected ? backgroundColor : primaryColor,
                    fontWeight: FontWeight.bold,
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