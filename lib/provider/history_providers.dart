import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final filterTypeProvider = StateProvider<String>((ref) => 'Semua');
final filterStationProvider = StateProvider<String>((ref) => 'Semua');
final stationListProvider = Provider<List<String>>((ref) {
  return ['Semua', 'Stasiun 1', 'Stasiun 2', 'Stasiun 3'];
});