import 'package:flutter/material.dart';

class AddressManagementPage extends StatefulWidget {
  @override
  _AddressManagementPageState createState() => _AddressManagementPageState();
}

class _AddressManagementPageState extends State<AddressManagementPage> {
  List<Address> addresses = [
    Address(
      id: '1',
      fullName: 'John Doe',
      phoneNumber: '+1 234 567 8900',
      addressLine1: '123 Main Street',
      addressLine2: 'Apartment 4B',
      city: 'New York',
      state: 'NY',
      pincode: '10001',
      addressType: 'Home',
      isDefault: true,
    ),
    Address(
      id: '2',
      fullName: 'John Doe',
      phoneNumber: '+1 234 567 8900',
      addressLine1: '456 Office Park',
      addressLine2: 'Suite 200',
      city: 'New York',
      state: 'NY',
      pincode: '10002',
      addressType: 'Office',
      isDefault: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(0xffFEAA61),
        title: Text(
          'My Addresses',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _navigateToAddAddressPage();
            },
          ),
        ],
      ),
      body: addresses.isEmpty ? _buildEmptyState() : _buildAddressList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddAddressPage();
        },
        backgroundColor: Color(0xffFEAA61),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'No Addresses Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Add your first address to get started',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              _navigateToAddAddressPage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffFEAA61),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text('Add New Address'),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        return _buildAddressCard(addresses[index], index);
      },
    );
  }

  Widget _buildAddressCard(Address address, int index) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xffFEAA61).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xffFEAA61)),
                      ),
                      child: Text(
                        address.addressType,
                        style: TextStyle(
                          color: Color(0xffFEAA61),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    if (address.isDefault) ...[
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Text(
                          'DEFAULT',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    _handleAddressAction(value, index);
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20, color: Color(0xffFEAA61)),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 20, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete'),
                        ],
                      ),
                    ),
                    if (!address.isDefault)
                      PopupMenuItem(
                        value: 'set_default',
                        child: Row(
                          children: [
                            Icon(Icons.star, size: 20, color: Colors.amber),
                            SizedBox(width: 8),
                            Text('Set as Default'),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              address.fullName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              address.phoneNumber,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              address.addressLine1,
              style: TextStyle(fontSize: 14),
            ),
            if (address.addressLine2.isNotEmpty) ...[
              SizedBox(height: 2),
              Text(
                address.addressLine2,
                style: TextStyle(fontSize: 14),
              ),
            ],
            SizedBox(height: 4),
            Text(
              '${address.city}, ${address.state} - ${address.pincode}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 12),
            Divider(),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _useThisAddress(address);
                    },
                    icon: Icon(Icons.location_on, size: 18),
                    label: Text('Use This Address'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Color(0xffFEAA61),
                      side: BorderSide(color: Color(0xffFEAA61)),
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

  void _navigateToAddAddressPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditAddressPage(
          onSave: (newAddress) {
            setState(() {
              // If this is the first address, set it as default
              if (addresses.isEmpty) {
                newAddress.isDefault = true;
              }
              addresses.add(newAddress);
            });
          },
        ),
      ),
    );
  }

  void _handleAddressAction(String action, int index) {
    switch (action) {
      case 'edit':
        _editAddress(index);
        break;
      case 'delete':
        _deleteAddress(index);
        break;
      case 'set_default':
        _setDefaultAddress(index);
        break;
    }
  }

  void _editAddress(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditAddressPage(
          address: addresses[index],
          onSave: (updatedAddress) {
            setState(() {
              addresses[index] = updatedAddress;
            });
          },
        ),
      ),
    );
  }

  void _deleteAddress(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Address'),
        content: Text('Are you sure you want to delete this address?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // If deleting default address, set another as default
                if (addresses[index].isDefault && addresses.length > 1) {
                  // Find another address to set as default
                  for (int i = 0; i < addresses.length; i++) {
                    if (i != index) {
                      addresses[i].isDefault = true;
                      break;
                    }
                  }
                }
                addresses.removeAt(index);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _setDefaultAddress(int index) {
    setState(() {
      // Remove default from all addresses
      for (var address in addresses) {
        address.isDefault = false;
      }
      // Set new default
      addresses[index].isDefault = true;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Address set as default'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _useThisAddress(Address address) {
    // Navigate back to booking page with selected address
    Navigator.pop(context, address);
  }
}

class AddEditAddressPage extends StatefulWidget {
  final Address? address;
  final Function(Address) onSave;

  const AddEditAddressPage({
    Key? key,
    this.address,
    required this.onSave,
  }) : super(key: key);

  @override
  _AddEditAddressPageState createState() => _AddEditAddressPageState();
}

class _AddEditAddressPageState extends State<AddEditAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  String _selectedAddressType = 'Home';
  bool _isDefault = false;

  final List<String> _addressTypes = ['Home', 'Office', 'Other'];

  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      _fullNameController.text = widget.address!.fullName;
      _phoneNumberController.text = widget.address!.phoneNumber;
      _addressLine1Controller.text = widget.address!.addressLine1;
      _addressLine2Controller.text = widget.address!.addressLine2;
      _cityController.text = widget.address!.city;
      _stateController.text = widget.address!.state;
      _pincodeController.text = widget.address!.pincode;
      _selectedAddressType = widget.address!.addressType;
      _isDefault = widget.address!.isDefault;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(0xffFEAA61),
        title: Text(
          widget.address == null ? 'Add New Address' : 'Edit Address',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Address Type Selection
                      _buildAddressTypeSelection(),
                      SizedBox(height: 16),
                      
                      // Full Name
                      _buildTextField(
                        controller: _fullNameController,
                        label: 'Full Name',
                        hintText: 'Enter your full name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Phone Number
                      _buildTextField(
                        controller: _phoneNumberController,
                        label: 'Phone Number',
                        hintText: 'Enter your phone number',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length < 10) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Address Line 1
                      _buildTextField(
                        controller: _addressLine1Controller,
                        label: 'Address Line 1',
                        hintText: 'House No., Building, Street',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter address line 1';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Address Line 2
                      _buildTextField(
                        controller: _addressLine2Controller,
                        label: 'Address Line 2 (Optional)',
                        hintText: 'Area, Landmark',
                      ),
                      SizedBox(height: 16),

                      // City, State, Pincode Row
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _cityController,
                              label: 'City',
                              hintText: 'City',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter city';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              controller: _stateController,
                              label: 'State',
                              hintText: 'State',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter state';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Pincode
                      _buildTextField(
                        controller: _pincodeController,
                        label: 'Pincode',
                        hintText: 'Enter pincode',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter pincode';
                          }
                          if (value.length != 6) {
                            return 'Please enter a valid 6-digit pincode';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Set as Default Checkbox
                      if (widget.address == null || !widget.address!.isDefault)
                        Row(
                          children: [
                            Checkbox(
                              value: _isDefault,
                              onChanged: (value) {
                                setState(() {
                                  _isDefault = value ?? false;
                                });
                              },
                              activeColor: Color(0xffFEAA61),
                            ),
                            Text('Set as default address'),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveAddress,
                child: Text(
                  widget.address == null ? 'Save Address' : 'Update Address',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFEAA61),
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              if (widget.address != null)
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address Type',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _addressTypes.map((type) {
            bool isSelected = _selectedAddressType == type;
            return ChoiceChip(
              label: Text(type),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedAddressType = type;
                });
              },
              selectedColor: Color(0xffFEAA61),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      final address = Address(
        id: widget.address?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        fullName: _fullNameController.text,
        phoneNumber: _phoneNumberController.text,
        addressLine1: _addressLine1Controller.text,
        addressLine2: _addressLine2Controller.text,
        city: _cityController.text,
        state: _stateController.text,
        pincode: _pincodeController.text,
        addressType: _selectedAddressType,
        isDefault: _isDefault,
      );

      widget.onSave(address);
      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.address == null 
                ? 'Address added successfully!' 
                : 'Address updated successfully!',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }
}

class Address {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String pincode;
  final String addressType;
  bool isDefault;

  Address({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.pincode,
    required this.addressType,
    this.isDefault = false,
  });
}

// Usage in your main app:
class HostelBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hostel Booking',
      theme: ThemeData(
        primaryColor: Color(0xffFEAA61),
        primarySwatch: Colors.blue,
      ),
      home: AddressManagementPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}