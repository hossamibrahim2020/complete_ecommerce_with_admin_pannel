import 'package:adminecommerce/shared/firebase_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ICanDelete {
  Future<void> deleteProduct(final QueryDocumentSnapshot e) async
  {
    await FirebaseFirestore.instance.collection(productCollection).doc(e.id).delete();
  }
}
