import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hematologi/models/species.dart';
import 'package:rxdart/rxdart.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;

  Stream<List<Species>> retrieveFishes() {
    return _db
        .collection('specieses')
        .where('type', isEqualTo: 'fish')
        .snapshots()
        .switchMap((querySnapshot) {

      if (querySnapshot.docs.isEmpty) {
        return Stream.value([]);
      }

      final docs = querySnapshot.docs;

      List<Future<Species>> speciesFutures = docs.map((doc) async {
        Species species = Species.fromSnapshot(doc);

        try {
          final downloadUrl = await FirebaseStorage.instance
              .ref('fishes/${species.image_url}.png') // `species.imageUrl` disini masih nama file
              .getDownloadURL();

          return species.copyWith(imageUrl: downloadUrl);
        } catch (e) {
          return species.copyWith(imageUrl: 'URL_GAMBAR_DEFAULT_JIKA_ERROR');
        }
      }).toList();
      return Future.wait(speciesFutures).asStream();
    });
  }

  Future<String> uploadProfilePicture({required File file, required String uid}) async {
    final storageRef = FirebaseStorage.instance.ref().child('profile_pictures/$uid.png');
    await storageRef.putFile(file);
    final downloadUrl = await storageRef.getDownloadURL();
    return downloadUrl;
  }

  Future<void> addNewSpecies(Map<String, dynamic> species, File imageFile) async {
    String folder = species['type'] == 'fish' ? 'fishes' : 'molluscs';
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('$folder/${species['name']}.png');
    await storageRef.putFile(imageFile);

    species['image_url'] = species['name'];
    await _db.collection('specieses').add(species);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserDocStream(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .snapshots();
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> dataToUpdate) async {
    await _db.collection('users').doc(uid).update(dataToUpdate);
  }

  void addCalculationResult(Map<String, dynamic> result, String uid) async {
    await _db.collection('users').doc(uid).update({
      'calculation_results' : FieldValue.arrayUnion([result])
    });
  }

  void removeCalculationResult(Map<String, dynamic> result, String uid) async {
    await _db.collection('users').doc(uid).update({
      'calculation_results' : FieldValue.arrayRemove([result])
    });
  }

  void addSpeciesToFavorite(Species species, String uid) async {
    await _db.collection('users').doc(uid).update({
      'favorite_species' : FieldValue.arrayUnion([species.toMap()])
    });
  }

  Future<void> addSpeciesToHemositCart(Species species, String uid) async {
    await _db.collection('users').doc(uid).update({
      'hemosit_species_in_cart': FieldValue.arrayUnion([species.toMap()])
    });
  }

  Future<void> removeSpeciesFromHemositCart(Species species, String uid) async {
    await _db.collection('users').doc(uid).update({
      'hemosit_species_in_cart': FieldValue.arrayRemove([species.toMap()])
    });
  }


  Future<void> addSpeciesToHematologiCart(Species species, String uid) async {
    await _db.collection('users').doc(uid).update({
      'hematologi_species_in_cart': FieldValue.arrayUnion([species.toMap()])
    });
  }

  Future<void> removeSpeciesFromHematologiCart(Species species, String uid) async {
    await _db.collection('users').doc(uid).update({
      'hematologi_species_in_cart': FieldValue.arrayRemove([species.toMap()])
    });
  }

  void removeSpeciesFromFavorite(Species species, String uid) async {
    await _db.collection('users').doc(uid).update({
      'favorite_species' : FieldValue.arrayRemove([species.toMap()])
    });
  }

  void createNewUser(Map<String, dynamic> user, String uid) async {
    await _db.collection("users").doc(uid).set(user);
  }

  Stream<List<Species>> retrieveMolluscs() {
    return _db
        .collection('specieses')
        .where('type', isEqualTo: 'molluscs')
        .snapshots()
        .switchMap((querySnapshot) {

      if (querySnapshot.docs.isEmpty) {
        return Stream.value([]);
      }

      final docs = querySnapshot.docs;

      List<Future<Species>> speciesFutures = docs.map((doc) async {
        Species species = Species.fromSnapshot(doc);

        try {
          final downloadUrl = await FirebaseStorage.instance
              .ref('molluscs/${species.image_url}.png') // `species.imageUrl` disini masih nama file
              .getDownloadURL();

          return species.copyWith(imageUrl: downloadUrl);
        } catch (e) {
          return species.copyWith(imageUrl: 'URL_GAMBAR_DEFAULT_JIKA_ERROR');
        }
      }).toList();
      return Future.wait(speciesFutures).asStream();
    });
  }

  Future<List<Map<String, dynamic>>> retrieveBloods() async {
    QuerySnapshot querySnapshot = await _db
        .collection('bloods')
        .get();
    List<Map<String, dynamic>> bloodsList = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String imageUrl = await FirebaseStorage.instance
          .ref('bloods/${data['image_url']}.png')
          .getDownloadURL();

      data['image_url'] = imageUrl;
      bloodsList.add(data);
    }
    return bloodsList;
  }
}