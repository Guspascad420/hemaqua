import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hematologi/models/species.dart';

class DatabaseService {
  Future<List<Species>> retrieveFishes() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('specieses')
        .where('type', isEqualTo: 'fish')
        .get();
    List<Species> fishList = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String imageUrl = await FirebaseStorage.instance
          .ref('fishes/${data['image_url']}.png')
          .getDownloadURL();

      data['image_url'] = imageUrl;
      fishList.add(Species.fromMap(data));
    }
    return fishList;
  }

  void addSpeciesToCart(Species species, String uid, String field) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      field : FieldValue.arrayUnion([species.toMap()])
    });
  }

  void removeSpeciesFromCart(Species species, String uid, String field) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      field : FieldValue.arrayRemove([species.toMap()])
    });
  }

  void createNewUser(Map<String, dynamic> user, String uid) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).set(user);
  }

  Future<Map<String, dynamic>> retrieveUserData(String id) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection("users").doc(id).get();
    return snapshot.data()!;
  }

  Future<List<Species>> retrieveMolluscs() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('specieses')
        .where('type', isEqualTo: 'molluscs')
        .get();
    List<Species> molluscsList = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String imageUrl = await FirebaseStorage.instance
          .ref('molluscs/${data['image_url']}.png')
          .getDownloadURL();

      data['image_url'] = imageUrl;
      molluscsList.add(Species.fromMap(data));
    }
    return molluscsList;
  }
}