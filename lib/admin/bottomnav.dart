import 'package:flutter/material.dart';
import 'package:hostel_booking/Homepage/homepage.dart';
import 'package:hostel_booking/admin/home/adminpage.dart';
import 'package:hostel_booking/admin/home/person.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index){
    setState(() {
     _selectedIndex = index;
    });
  }

  final List<Widget> _pages =[
    
     Adminpage(),
     Person()
     


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    body:_pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _navigateBottomBar,
      
      type: BottomNavigationBarType. fixed,
      items: [
      
      BottomNavigationBarItem(icon:Icon(Icons.home),label: "home"
      ),
      BottomNavigationBarItem(icon: Icon(Icons.person),label: "person"),
    ],
    selectedItemColor: Colors.blue,
    ),
    
    );
   
  }
}