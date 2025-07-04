import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/calculations/checker/hematologi_checker.dart';
import 'package:hematologi/data_saved.dart';
import 'package:hematologi/database/database_service.dart';
import 'package:hematologi/provider/providers.dart';
import 'package:hematologi/utils/format_number.dart';

import '../components/analysis/result_parameter_card.dart';
import '../components/analysis/species_analysis_result_page.dart';
import '../models/species.dart';

class HematologiResults extends ConsumerWidget {
  final int? station;
  final Species species;
  final bool showBottomNav;
  final Map<String, dynamic> calculationResults;

  const HematologiResults({super.key, required this.calculationResults,
    required this.species, this.station, required this.showBottomNav});

  String formatToTitleCase(String text) {
    if (text.isEmpty) {
      return text; // Kalo string kosong, balikin aja
    }

    final String textWithSpaces = text.replaceAll('_', ' ');
    final List<String> words = textWithSpaces.split(' ');

    final List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) {
        return '';
      }
      return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
    }).toList();

    return capitalizedWords.join(' ');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genus = species.latin_name.split(' ')[0];

    final List<Widget> cards = calculationResults.entries
        .where((entry) => entry.value != 0.0)
        .map((entry) {
      final param = entry.key;
      final resultValue = entry.value as double;

      final lowerRange = HematologiChecker.normalRanges[genus]![param]![0];
      final upperRange = HematologiChecker.normalRanges[genus]![param]![1];
      final status = HematologiChecker.checkCalculation(genus, param, resultValue);
      final standardQuality = 'Standar baku mutu: ${formatNumber(lowerRange)}-${formatNumber(upperRange)}';

      return ResultParameterCard(
        parameterName: formatToTitleCase(param),
        resultValue: resultValue,
        status: status,
        standardQuality: standardQuality,
      );
    }).toList();

    void handleSave() {
      debugPrint(species.toMap().toString());
      final auth = FirebaseAuth.instance; // Contoh ambil auth dari provider
      final calculationResult = {
        'species_id': species.id!,
        'station_id': "Stasiun $station",
        'created_at': Timestamp.now(),
        'type': 'fish_hematology',
        ...calculationResults,
        'user_id': auth.currentUser!.uid,
      };
      ref.read(databaseServiceProvider).addCalculationResult(calculationResult);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const DataSaved()),
      );
    }
    return SpeciesAnalysisResultPage(
      title: 'Hasil Hematologi',
      resultCards: cards,
      onSave: handleSave,
      showSaveButton: showBottomNav,
    );
  }
}