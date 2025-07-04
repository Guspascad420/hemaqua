import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:hematologi/models/species.dart';
import 'package:rxdart/rxdart.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;

  Stream<List<Species>> retrieveSpecieses(String type) {
    final querySnapshotStream = _db
        .collection('specieses')
        .where('type', isEqualTo: type)
        .snapshots();

    return querySnapshotStream.map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return [];
      }
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Species.fromMap(data);
      }).toList();
    });
  }

  Query retrieveCalculationHistory(String userId) {
    return _db.collection('hasil_pantauan')
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true);
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

  Future<Species> retrieveSpeciesDetails(String speciesId) async {
    final doc = await _db.collection('specieses').doc(speciesId).get();
    if (!doc.exists) {
      throw Exception('Spesies dengan ID $speciesId tidak ditemukan');
    }
    final data = doc.data()!;
    data['id'] = doc.id;
    return Species.fromMap(data);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserDocStream(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .snapshots();
  }

  Future<void> seedMolluscsData() async {
    final collectionRef = _db.collection('specieses');
    List<Map<String, dynamic>> dummyMolluscs = [
      {
        'name': 'Keong Batu / Keong Geris',
        'latin_name': 'Mieniplotia scabra',
        'description': 'Siput air tawar yang sering menempel di bebatuan sungai jernih. Pola cangkangnya yang unik sering dipelajari dalam kaitannya dengan kandungan mineral air.',
        'class': 'Gastropoda',
        'type': 'mollusc',
      },
      {
        'name': 'Tutut / Keong Sawah',
        'latin_name': 'Filopaludina javanica',
        'description': 'Siput air tawar ikonik yang umum dijumpai di persawahan dan perairan tenang di Asia Tenggara. Merupakan bagian penting dari ekosistem dan sering dikonsumsi.',
        'class': 'Gastropoda',
        'type': 'mollusc',
      },
      {
        'name': 'Keong Terompet Merah',
        'latin_name': 'Melanoides tuberculata',
        'description': 'Dikenal sebagai Red-rimmed melania, siput ini dapat berkembang biak dengan cepat. Merupakan inang perantara penting bagi berbagai parasit, membuatnya signifikan dalam studi kesehatan ekologi.',
        'class': 'Gastropoda',
        'type': 'mollusc',
      }
    ];

    debugPrint('Memulai proses seeding data moluska...');

    for (final fishData in dummyMolluscs) {
      await collectionRef.add(fishData);
      debugPrint('Berhasil menambahkan: ${fishData['name']}');
    }

    debugPrint('Proses seeding selesai!');
  }

  Future<void> seedFishesData() async {
    final collectionRef = _db.collection('specieses');

    // List dummy data dari atas
    final List<Map<String, dynamic>> dummyFishes = [
      {
        'name': 'Ikan Nila',
        'latin_name': 'Oreochromis niloticus',
        'description': 'Spesies ikan yang sangat adaptif dan toleran terhadap berbagai kondisi lingkungan, '
            'sering digunakan sebagai bio-indikator kualitas air.',
        'type': 'fish',
      },
      {
        'name': 'Ikan Mas',
        'latin_name': 'Cyprinus carpio',
        'description': 'Salah satu ikan budidaya paling populer di Indonesia. '
            'Sensitif terhadap perubahan mendadak pada suhu dan kadar oksigen terlarut (DO).',
        'type': 'fish',
      },
      {
        'name': 'Ikan Gurame',
        'latin_name': 'Osphronemus goramy',
        'description': 'Dikenal dengan kemampuannya mengambil oksigen langsung dari '
            'udara. Kondisi hematologinya sering dipelajari untuk melihat efek pakan buatan.',
        'type': 'fish',
      },
      {
        'name': 'Ikan Lele',
        'latin_name': 'Clarias batrachus',
        'description': 'Sangat tangguh dan dapat bertahan hidup di perairan dengan kualitas air '
            'yang buruk dan kadar oksigen rendah, namun tetap rentan terhadap infeksi bakteri.',
        'type': 'fish',
      },
      {
        'name': 'Ikan Tawes',
        'latin_name': 'Puntius javanicus',
        'description': 'Ikan air tawar asli Indonesia yang sering ditemukan di sungai dan rawa. '
            'Digunakan dalam studi dampak polusi logam berat.',
        'type': 'fish',
      },
      {
        'name': 'Ikan Patin',
        'latin_name': 'Pangasius sp.',
        'description': 'Ikan komersial penting yang pertumbuhannya sangat dipengaruhi '
            'oleh kualitas pakan dan parameter air seperti amonia.',
        'type': 'fish',
      },
      {
        'name': 'Ikan Gabus',
        'latin_name': 'Channa striata',
        'description': 'Ikan predator air tawar yang memiliki nilai ekonomis tinggi '
            'karena kandungan albuminnya. Sangat tahan banting di berbagai lingkungan.',
        'type': 'fish',
      },
    ];

    debugPrint('Memulai proses seeding data ikan...');

    for (final fishData in dummyFishes) {
      await collectionRef.add(fishData);
      print('Berhasil menambahkan: ${fishData['name']}');
    }

    debugPrint('Proses seeding selesai!');
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> dataToUpdate) async {
    await _db.collection('users').doc(uid).update(dataToUpdate);
  }

  void addCalculationResult(Map<String, dynamic> result) async {
    // await _db.collection('users').doc(uid).update({
    //   'calculation_results' : FieldValue.arrayUnion([result])
    // });
    await _db.collection('hasil_pantauan').add(result);
  }

  void removeCalculationResult(String resultId) async {
    // await _db.collection('users').doc(uid).update({
    //   'calculation_results' : FieldValue.arrayRemove([result])
    // });
    await _db.collection('hasil_pantauan').doc(resultId).delete();
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