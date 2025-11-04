// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:hostel_booking/Homepage/homepage.dart';
// import 'package:hostel_booking/Model/hostelmodel.dart';
// import 'package:hostel_booking/Model/usermodel.dart';
// import 'package:hostel_booking/admin/bottomnav.dart';


// class AuthService {

// final _auth=FirebaseAuth.instance;
// final _firestore=FirebaseFirestore.instance;


//   Future<String>signup({
//    required Hostelmodel data,
//   }) async{
//   String res="some error occurs";
  
    
//     await _firestore.collection("hostels").doc(credential.user!.uid).set({
//       'name':data.name,
//       'phonenumber':data.number,
//       "role":data.role,
//       "address":data.address,
//       'uid':credential.user!.uid,
//       'email':data.email,
//     });
//     res ="success";
  
//   try{}catch(err){
//     return err.toString();

//   }
//   return res;
// }





//  Future<String?> login({



//   required String email,
//   required String password,
//  required BuildContext context
// }) async {
//   try {
//     UserCredential _usercredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
//     User? user = _usercredential.user;
//       if(user!=null){
//       DocumentSnapshot userdoc= await _firestore.collection("User").doc(user.uid).get();
//        if (userdoc.exists) {
//           Map<String, dynamic> userdata =
//               userdoc.data() as Map<String, dynamic>;
//           String role = userdata['role'];

//         if(role == 'user'){
//           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Homepage(),), (route) => false,);
//         }else{
//           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Bottomnav(),), (route) => false,);
//         }
//        }
//       }
//     return "success"; // ✅ Return success message
//   } on FirebaseAuthException catch (e) {
//     // ✅ Handle Firebase-specific errors
//     if (e.code == 'user-not-found') {
//       return 'No user found for that email.';
//     } else if (e.code == 'wrong-password') {
//       return 'Wrong password provided.';
//     } else if (e.code == 'invalid-email') {
//       return 'Invalid email address.';
//     } else if (e.code == 'invalid-credential') {
//       return 'Invalid login credentials.';
//     } else {
//       return 'Login failed. Please try again.';
//     }
//   } catch (e) {
//     // ✅ Handle any other unexpected errors
//     return 'An unexpected error occurred. Please try again later.';
//   }
// }








// }