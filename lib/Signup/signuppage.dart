import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _userFormKey = GlobalKey<FormState>();
  final _ownerFormKey = GlobalKey<FormState>();

  // Controllers for user fields
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userNumberController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userconfirmPasswordController =
      TextEditingController();

  // Controllers for turf owner fields
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _turfNameController = TextEditingController();
  final TextEditingController _ownerEmailController = TextEditingController();
  final TextEditingController _ownerNumberController = TextEditingController();
  final TextEditingController _ownerPasswordController =
      TextEditingController();
  final TextEditingController _ownerlocationController =
      TextEditingController();
  final TextEditingController _ownerAddressController = TextEditingController();
  final TextEditingController _ownerrateController = TextEditingController();
 


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0x40D9D9D9),
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w300,
        fontSize: 14,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 225, 225, 225),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFD4D4D4), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // void _registerUser() {
  //   if (_userFormKey.currentState!.validate()) {
  //     print("User registered: ${_userNameController.text}");
  //   }
  // }

  // void _registerOwner() {
  //   if (_ownerFormKey.currentState!.validate()) {
  //     print("Owner registered: ${_ownerNameController.text}");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: Colors.white,
        title: const Text("Register", style: TextStyle(color: Colors.black)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.green,
          tabs: const [Tab(text: "User"), Tab(text: "Vendor")],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // -------- USER FORM ----------
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _userFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Full Name",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _userNameController,
                    decoration: _inputDecoration("Enter your full name"),
                    validator:
                        (value) => value!.isEmpty ? "Enter your name" : null,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Phone Number",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _userNumberController,
                    keyboardType: TextInputType.phone, // ✅ numeric keyboard
                    decoration: _inputDecoration("Enter your phone number"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your phone number";
                      }
                      if (value.length < 10) {
                        return "Phone number must be at least 10 digits";
                      }
                      return null; // ✅ valid
                    },
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _userEmailController,
                    decoration: _inputDecoration("Enter your email"),
                    validator:
                        (value) => value!.isEmpty ? "Enter your email" : null,
                  ),
                  const SizedBox(height: 15),

                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(  
                    controller: _userPasswordController,
                    obscureText: true,
                    decoration: _inputDecoration("Enter your password"),
                    validator:
                        (value) =>
                            value!.length < 6 ? "Min 6 characters" : null,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Confirm Password",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _userconfirmPasswordController,
                    obscureText: true,
                    decoration: _inputDecoration("Confirm your password"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password";
                      }
                      if (value != _userPasswordController.text) {
                        return "Passwords do not match";
                      }
                      return null; // ✅ no error
                    },
                  ),
                  const SizedBox(height: 30),

                  // Register Button
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                       
                      },
                      child: Container(
                        height: 50,
                        width: 350,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 5, 90, 8),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            "Register as vendor",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // -------- OWNER FORM ----------
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _ownerFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Vendor Name",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _ownerNameController,
                    decoration: _inputDecoration("Enter Ventor name"),
                    validator:
                        (value) => value!.isEmpty ? "Enter your name" : null,
                  ),
                  const SizedBox(height: 15),

                  const Text(
                    "Name of Bussiness",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _ownerNumberController,
                    decoration: _inputDecoration("Enter your Bussiness "),
                  
                  ),
                  const SizedBox(height: 15),

                  const Text(
                    "Address",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _turfNameController,
                    decoration: _inputDecoration("Enter Your Address"),
                       validator:
                        (value) => value!.isEmpty ? "Enter your address" : null,
                  ),
                 
                  const SizedBox(height: 15),

                  const Text(
                    "City",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _ownerEmailController,
                    decoration: _inputDecoration("Enter your City"),
                     validator:
                        (value) =>
                            value!.isEmpty ? "Enter your location" : null,
                  
                  ),
                  const SizedBox(height: 15),

                  const Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _ownerPasswordController,
                    obscureText: true,
                    decoration: _inputDecoration("Enter your Email"),
                    validator:
                        (value) => value!.isEmpty ? "Enter your email" : null,
                   
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _ownerlocationController,

                    decoration: _inputDecoration("Enter your Password"),
                     validator:
                        (value) =>
                            value!.length < 6 ? "Min 6 characters" : null,
                
                  ),
                  const SizedBox(height: 15),

                  const Text(
                    "Phone Number",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _ownerAddressController,

                    decoration: _inputDecoration("Enter your Phone Number"),
                 validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your phone number";
                      }
                      if (value.length < 10) {
                        return "Phone number must be at least 10 digits";
                      }
                      return null; // ✅ valid
                    },
                  ),

                  SizedBox(height: 15),

                  const SizedBox(height: 20),

                  // Register Button
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        
                      },
                      child: Container(
                        height: 50,
                        width: 350,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 5, 90, 8),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            "Registor",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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