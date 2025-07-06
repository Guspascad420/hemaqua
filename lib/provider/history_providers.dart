import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hematologi/provider/providers.dart';

enum BloodComponent { eritrosit, limfosit, mikronuklei, monosit, neutrofil,
  leukosit, hematokrit, hemoglobin, thc, // Mungkin ini buat molluscs?
  hyalin,
  granular,
  semi_granular, }
enum GroupingMode { daily, weekly }

final filterTypeProvider = StateProvider<String>((ref) => 'Semua');
final filterStationProvider = StateProvider<String>((ref) => 'Semua');
final stationListProvider = Provider<List<String>>((ref) {
  return ['Semua', 'Stasiun 1', 'Stasiun 2', 'Stasiun 3'];
});

final selectedComponentProvider = StateProvider.family<BloodComponent, String>((ref, speciesType) {
  if (speciesType == 'fish') {
    return BloodComponent.eritrosit;
  } else if (speciesType == 'mollusc') {
    return BloodComponent.thc;
  }
  return BloodComponent.leukosit;
});

final groupingModeProvider = StateProvider<GroupingMode>((ref) => GroupingMode.daily);

final speciesCalculationDataProvider = FutureProvider.autoDispose.family<List<Map<String, dynamic>>, String>((ref, speciesId) async {
  return await ref.read(databaseServiceProvider).retrieveCalculationsbySpecies(speciesId);
});
