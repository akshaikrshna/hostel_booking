import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

final _auth=FirebaseAuth.instance;
final _firestore=FirebaseFirestore.instance;


  Future<String>signup({
    required String name,
    required String phonenumber,
    required String email,
    required String password,
  }) async{
  String res="some error occure";
  if(name.isNotEmpty && email.isNotEmpty && password.isNotEmpty){
    UserCredential credential= await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await _firestore.collection("User").doc(credential.user!.uid).set({
      'name':name,
      'phonenumber':phonenumber,
      'uid':credential.user!.uid,
      'email':email,
    });
    res ="success";
  }else{
      res='please fill all the fields';
  }
  try{}catch(err){
    return err.toString();

  }
  return res;
}





  Future<void>login({
    required String email,
    required String password
  })
  async{
    
  UserCredential userCredential=    await _auth.signInWithEmailAndPassword(email:email,password:password);
    

   

  }




}