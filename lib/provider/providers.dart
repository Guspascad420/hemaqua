import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import model dan service lo
import '../database/database_service.dart';
import '../models/species.dart';

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final userDocStreamProvider = StreamProvider.autoDispose<DocumentSnapshot>((ref) {
  final db = ref.watch(databaseServiceProvider);
  final user = ref.watch(authStateProvider).asData?.value;

  if (user != null) {
    return db.getUserDocStream(user.uid);
  }

  return const Stream.empty();
});

final hematologiCartStreamProvider = StreamProvider.autoDispose<List<Species>>((ref) {
  final db = ref.watch(databaseServiceProvider);
  final user = ref.watch(authStateProvider).asData?.value;

  if (user == null) {
    return Stream.value([]);
  }

  final userDocStream = db.getUserDocStream(user.uid);

  return userDocStream.map((doc) {
    if (!doc.exists) return [];
    final data = doc.data(); // Data sudah otomatis Map<String, dynamic>
    final cartData = data?['hematologi_species_in_cart'] as List<dynamic>? ?? [];
    final speciesList =  cartData.map((map) => Species.fromMap(map)).toList();
    return speciesList;
  });
});

final hematologiCartListProvider = Provider.autoDispose<List<Species>>((ref) {
  final asyncValue = ref.watch(hematologiCartStreamProvider);
  return asyncValue.asData?.value ?? [];
});

final hemositCartStreamProvider = StreamProvider.autoDispose<List<Species>>((ref) {
  final db = ref.watch(databaseServiceProvider);
  final user = ref.watch(authStateProvider).asData?.value;

  if (user == null) {
    return Stream.value([]);
  }

  final userDocStream = db.getUserDocStream(user.uid);

  return userDocStream.map((doc) {
    if (!doc.exists) return [];
    final data = doc.data(); // Data sudah otomatis Map<String, dynamic>
    final cartData = data?['hemosit_species_in_cart'] as List<dynamic>? ?? [];
    return cartData.map((map) => Species.fromMap(map)).toList();
  });
});

final hemositCartListProvider = Provider.autoDispose<List<Species>>((ref) {
  final asyncValue = ref.watch(hemositCartStreamProvider);
  return asyncValue.asData?.value ?? [];
});

final favoriteSpeciesStreamProvider = StreamProvider.autoDispose<List<Species>>((ref) {
  final asyncSnapshot = ref.watch(userDocStreamProvider);

  return asyncSnapshot.when(
    data: (doc) {
      if (!doc.exists) return Stream.value([]);
      final data = doc.data() as Map<String, dynamic>?;
      final favorites = data?['favorite_species'] as List<dynamic>? ?? [];
      final speciesList = favorites.map((map) => Species.fromMap(map)).toList();
      return Stream.value(speciesList);
    },
    loading: () => Stream.value([]), // atau handle loading state
    error: (e, s) => Stream.error(e, s),
  );
});

final favoriteSpeciesListProvider = Provider.autoDispose<List<Species>>((ref) {
  final asyncValue = ref.watch(favoriteSpeciesStreamProvider);
  return asyncValue.asData?.value ?? [];
});

final calculationResultsProvider = StreamProvider.autoDispose<List<Map<String, dynamic>>>((ref) {
  final asyncSnapshot = ref.watch(userDocStreamProvider);
  return asyncSnapshot.when(
    data: (doc) {
      if (!doc.exists) return Stream.value([]);
      final data = doc.data() as Map<String, dynamic>?;
      final results = data?['calculation_results'] as List<dynamic>? ?? [];
      final resultsList = results.map((map) => map as Map<String, dynamic>).toList();
      return Stream.value(resultsList);
    },
    loading: () => Stream.value([]),
    error: (e, s) => Stream.error(e, s),
  );
});