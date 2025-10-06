import 'package:flutter/material.dart';
import 'package:hostel_booking/Productpage/productpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black12,
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Find Perfect Local Hosts in the Area",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategory("All", true),
                    _buildCategory("House", false),
                    _buildCategory("Apartment", false),
                    _buildCategory("Townhouse", false),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildPropertyCard(
                      context,
                      imageUrl:
                          "https://ik.imagekit.io/bbhed67kj/wp-content/uploads/2022/10/Luxury-Sakleshpur-Homestay-Near-Waterfalls-3-500x300.jpg",
                      price: "\$220/day",
                      rating: "4.7",
                      title: "Fun loving family",
                      location: "1 km away, New York",
                    ),
                    _buildPropertyCard(
                      context,
                      imageUrl:
                          "https://d2rdhxfof4qmbb.cloudfront.net/wp-content/uploads/20201116185103/Srinikethana-Homestay.jpg",
                      price: "\$16/day",
                      rating: "4.5",
                      title: "A small family in a big house",
                      location: "3 km away, New York",
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

  Widget _buildCategory(String title, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.pink.shade100 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.pink : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPropertyCard(BuildContext context,
      {required String imageUrl,
      required String price,
      required String rating,
      required String title,
      required String location}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Prodectpage()),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl,
                height: 180, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.pink, size: 18),
                          Text(rating,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(location,
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
