import 'package:flutter/material.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({Key? key}) : super(key: key);

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  String searchQuery = '';
  String statusFilter = 'all';
  
  final List<Booking> bookings = [
    Booking(
      id: 'BK-2024-001',
      patientName: 'John Doe',
      department: 'Cardiology',
      doctor: 'Dr. Sarah Johnson',
      date: '2024-11-05',
      time: '10:00 AM',
      status: BookingStatus.completed,
      type: 'Consultation',
      location: 'Building A, Floor 2',
    ),
    Booking(
      id: 'BK-2024-002',
      patientName: 'Jane Smith',
      department: 'Orthopedics',
      doctor: 'Dr. Michael Chen',
      date: '2024-11-06',
      time: '02:30 PM',
      status: BookingStatus.confirmed,
      type: 'Follow-up',
      location: 'Building B, Floor 1',
    ),
    Booking(
      id: 'BK-2024-003',
      patientName: 'Robert Wilson',
      department: 'Neurology',
      doctor: 'Dr. Emily Brown',
      date: '2024-11-04',
      time: '11:15 AM',
      status: BookingStatus.cancelled,
      type: 'Consultation',
      location: 'Building A, Floor 3',
    ),
    Booking(
      id: 'BK-2024-004',
      patientName: 'Maria Garcia',
      department: 'Pediatrics',
      doctor: 'Dr. James Wilson',
      date: '2024-11-07',
      time: '09:00 AM',
      status: BookingStatus.pending,
      type: 'Vaccination',
      location: 'Building C, Floor 1',
    ),
    Booking(
      id: 'BK-2024-005',
      patientName: 'David Lee',
      department: 'Dermatology',
      doctor: 'Dr. Lisa Anderson',
      date: '2024-11-03',
      time: '03:45 PM',
      status: BookingStatus.completed,
      type: 'Consultation',
      location: 'Building B, Floor 2',
    ),
  ];

  List<Booking> get filteredBookings {
    return bookings.where((booking) {
      final matchesSearch = booking.patientName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          booking.doctor.toLowerCase().contains(searchQuery.toLowerCase()) ||
          booking.department.toLowerCase().contains(searchQuery.toLowerCase()) ||
          booking.id.toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = statusFilter == 'all' || 
          booking.status.toString().split('.').last == statusFilter;
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Booking History'),
        backgroundColor: Colors.blue[700],
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
                    hintText: 'Search by patient, doctor, department...',
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
                      borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
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
                      return BookingCard(booking: filteredBookings[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({Key? key, required this.booking}) : super(key: key);

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
                        booking.patientName,
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
            _buildInfoRow(Icons.person, booking.doctor, booking.department),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.calendar_today, booking.date, booking.time),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.location_on, booking.location, null),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.medical_services, booking.type, null),
            const SizedBox(height: 16),
            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility, size: 18),
                    label: const Text('View'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue[700],
                      side: BorderSide(color: Colors.blue[700]!),
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

  Widget _buildInfoRow(IconData icon, String primary, String? secondary) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.blue[700]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            secondary != null ? '$primary • $secondary' : primary,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
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

class Booking {
  final String id;
  final String patientName;
  final String department;
  final String doctor;
  final String date;
  final String time;
  final BookingStatus status;
  final String type;
  final String location;

  Booking({
    required this.id,
    required this.patientName,
    required this.department,
    required this.doctor,
    required this.date,
    required this.time,
    required this.status,
    required this.type,
    required this.location,
  });
}