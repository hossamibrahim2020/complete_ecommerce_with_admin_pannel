import 'package:cloud_firestore/cloud_firestore.dart';
import '../shared/firebase_keys.dart';

class FirebaseStreamViewmodel {
  Stream<QuerySnapshot> product(){
    return FirebaseFirestore.instance.collection(productCollection).snapshots();
  }
}