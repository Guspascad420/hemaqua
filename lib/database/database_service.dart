import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  Future<List<Map<String, dynamic>>> retrieveFishes() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('specieses')
        .where('type', isEqualTo: 'fish')
        .get();
    List<Map<String, dynamic>> fishList = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String imageUrl = await FirebaseStorage.instance
          .ref('fishes/${data['image_url']}.png')
          .getDownloadURL();

      data['image_url'] = imageUrl;
      fishList.add(data);
    }
    return fishList;
  }

  Future<List<Map<String, dynamic>>> retrieveMolluscs() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('specieses')
        .where('type', isEqualTo: 'molluscs')
        .get();
    List<Map<String, dynamic>> molluscsList = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String imageUrl = await FirebaseStorage.instance
          .ref('molluscs/${data['image_url']}.png')
          .getDownloadURL();

      data['image_url'] = imageUrl;
      molluscsList.add(data);
    }
    return molluscsList;
  }
}