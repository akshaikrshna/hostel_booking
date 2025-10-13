import 'package:flutter/material.dart';

class Adminpage extends StatefulWidget {
  const Adminpage({super.key});

  @override
  State<Adminpage> createState() => _HomepageState();
}

class _HomepageState extends State<Adminpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 130,top: 350),
            child: Text("homepage",style: TextStyle(fontSize: 22,),),
          )
        ],
      ),
    );
  }
}