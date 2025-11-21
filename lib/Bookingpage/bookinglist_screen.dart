import 'package:flutter/material.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({Key? key}) : super(key: key);

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  String searchQuery = '';
  String statusFilter = 'all';
  
  final List<HostelBooking> bookings = [
    HostelBooking(
      id: 'HST-2024-001',
      guestName: 'John Doe',
      hostelName: 'Sunrise Hostel',
      roomType: 'Deluxe Room',
      checkInDate: '2024-11-15',
      checkOutDate: '2024-11-20',
      status: BookingStatus.confirmed,
      totalAmount: '₹5,000',
      location: 'Perintalmanna, Kerala',
      guests: 2,
    ),
    HostelBooking(
      id: 'HST-2024-002',
      guestName: 'Jane Smith',
      hostelName: 'Mountain View Hostel',
      roomType: 'Standard Room',
      checkInDate: '2024-11-10',
      checkOutDate: '2024-11-12',
      status: BookingStatus.completed,
      totalAmount: '₹3,500',
      location: 'Malappuram, Kerala',
      guests: 1,
    ),
    HostelBooking(
      id: 'HST-2024-003',
      guestName: 'Robert Wilson',
      hostelName: 'City Center Hostel',
      roomType: 'Shared Dormitory',
      checkInDate: '2024-11-08',
      checkOutDate: '2024-11-10',
      status: BookingStatus.cancelled,
      totalAmount: '₹1,500',
      location: 'Calicut, Kerala',
      guests: 1,
    ),
    HostelBooking(
      id: 'HST-2024-004',
      guestName: 'Maria Garcia',
      hostelName: 'Beach Side Hostel',
      roomType: 'Private Room',
      checkInDate: '2024-11-18',
      checkOutDate: '2024-11-22',
      status: BookingStatus.pending,
      totalAmount: '₹6,800',
      location: 'Kozhikode, Kerala',
      guests: 3,
    ),
    HostelBooking(
      id: 'HST-2024-005',
      guestName: 'David Lee',
      hostelName: 'Green Valley Hostel',
      roomType: 'Premium Suite',
      checkInDate: '2024-11-05',
      checkOutDate: '2024-11-07',
      status: BookingStatus.completed,
      totalAmount: '₹4,200',
      location: 'Manjeri, Kerala',
      guests: 2,
    ),
  ];

  List<HostelBooking> get filteredBookings {
    return bookings.where((booking) {
      final matchesSearch = booking.guestName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          booking.hostelName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          booking.roomType.toLowerCase().contains(searchQuery.toLowerCase()) ||
          booking.location.toLowerCase().contains(searchQuery.toLowerCase()) ||
          booking.id.toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = statusFilter == 'all' || 
          booking.status.toString().split('.').last == statusFilter;
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: const Color(0xffFEAA61),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filters Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by guest, hostel, location...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF4facfe), width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                // Status Filter
                DropdownButtonFormField<String>(
                  value: statusFilter,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.filter_list),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All Status')),
                    DropdownMenuItem(value: 'completed', child: Text('Completed')),
                    DropdownMenuItem(value: 'confirmed', child: Text('Confirmed')),
                    DropdownMenuItem(value: 'pending', child: Text('Pending')),
                    DropdownMenuItem(value: 'cancelled', child: Text('Cancelled')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      statusFilter = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          // Results Count
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Showing ${filteredBookings.length} of ${bookings.length} bookings',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
          ),
          // Bookings List
          Expanded(
            child: filteredBookings.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No bookings found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your search or filter',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredBookings.length,
                    itemBuilder: (context, index) {
                      return HostelBookingCard(booking: filteredBookings[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class HostelBookingCard extends StatelessWidget {
  final HostelBooking booking;

  const HostelBookingCard({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.hostelName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        booking.id,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(booking.status),
              ],
            ),
            const SizedBox(height: 16),
            // Details
            _buildInfoRow(Icons.person, 'Guest:', booking.guestName),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.bed, 'Room:', booking.roomType),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.calendar_today, 
              'Check-in:', 
              '${booking.checkInDate} → ${booking.checkOutDate}'
            ),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.location_on, 'Location:', booking.location),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.group, 'Guests:', '${booking.guests} person(s)'),
            const SizedBox(height: 12),
            // Total Amount
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF4facfe).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    booking.totalAmount,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4facfe),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility, size: 18),
                    label: const Text('View Details'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF4facfe),
                      side: const BorderSide(color: Color(0xFF4facfe)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download, size: 18),
                    label: const Text('Receipt'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green[700],
                      side: BorderSide(color: Colors.green[700]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF4facfe)),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              children: [
                TextSpan(
                  text: '$label ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(BookingStatus status) {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case BookingStatus.completed:
        bgColor = Colors.green[50]!;
        textColor = Colors.green[800]!;
        label = 'Completed';
        break;
      case BookingStatus.confirmed:
        bgColor = Colors.blue[50]!;
        textColor = Colors.blue[800]!;
        label = 'Confirmed';
        break;
      case BookingStatus.pending:
        bgColor = Colors.orange[50]!;
        textColor = Colors.orange[800]!;
        label = 'Pending';
        break;
      case BookingStatus.cancelled:
        bgColor = Colors.red[50]!;
        textColor = Colors.red[800]!;
        label = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Models
enum BookingStatus { completed, confirmed, pending, cancelled }

class HostelBooking {
  final String id;
  final String guestName;
  final String hostelName;
  final String roomType;
  final String checkInDate;
  final String checkOutDate;
  final BookingStatus status;
  final String totalAmount;
  final String location;
  final int guests;

  HostelBooking({
    required this.id,
    required this.guestName,
    required this.hostelName,
    required this.roomType,
    required this.checkInDate,
    required this.checkOutDate,
    required this.status,
    required this.totalAmount,
    required this.location,
    required this.guests,
  });
}