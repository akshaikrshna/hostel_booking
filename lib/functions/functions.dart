import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class fetchuserdata{
  
 getUserData() async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  

  DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('User').doc(uid).get();
     return userDoc.data();
    }

}