import 'package:flutter/material.dart';
import 'package:hostel_booking/Bookingpage/bookingbage.dart';
import 'package:hostel_booking/Favorites/favorites.dart';
import 'package:hostel_booking/Homepage/homepage.dart';
import 'package:hostel_booking/Profile/profile.dart';





class Bottombav extends StatefulWidget {
  const Bottombav({super.key});

  @override
  State<Bottombav> createState() => _BottombavState();
}

class _BottombavState extends State<Bottombav> {
  late List<Widget> pages;

  late Homepage homepage;
  late Bookingpage bookings;
  late Favorites fav;
  late Profile profile;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    homepage = const Homepage();
    bookings = const Bookingpage();
    fav = const Favorites();
    profile = const Profile();
    pages = [homepage, bookings, fav, profile];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentTabIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor:  Colors.lightBlue,
        unselectedItemColor: Colors.white,
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
  