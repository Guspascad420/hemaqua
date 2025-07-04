import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../calculations/checker/hemosit_checker.dart';
import '../components/analysis/result_parameter_card.dart';
import '../components/analysis/species_analysis_result_page.dart';
import '../data_saved.dart';
import '../models/species.dart';
import '../provider/providers.dart';
import '../utils/format_number.dart';

class HemositResults extends ConsumerWidget {
  final Map<String, dynamic> calculationResults;
  final Species species;
  final bool showBottomNav;
  final int? station;

  const HemositResults({super.key, required this.calculationResults,
        required this.species, this.station, required this.showBottomNav});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genus = species.latin_name.split(' ')[0];

    final List<Widget> cards = calculationResults.entries
        .where((entry) => entry.value != 0.0)
        .map((entry) {
      final param = entry.key;
      final resultValue = entry.value as double;

      String status = '';
      String standardQuality = 'Standar baku mutu: ';
      double maxHyalunosit = 0;
      double minGranulosit = 0;
      double normalSemiGranulosit = 0;
      double normalThc = 0;

      if (species.klass == 'bivalvia') {
        final lowerRange = HemositChecker.normalGastropodaRanges[genus]![param]!;
        final upperRange = HemositChecker.normalGastropodaRanges[genus]![param]!;
        status = HemositChecker.checkBivalviaCalculation(genus, param, resultValue);
        standardQuality = '$standardQuality ${formatNumber(lowerRange)}-${formatNumber(upperRange)}';

      } else {
        if (param == 'hyalin') {
          maxHyalunosit = HemositChecker.normalGastropodaRanges[genus]!['hyalin']!;
          status = HemositChecker.checkHyalunositCalculation(genus, calculationResults[param]!);
          standardQuality = '$standardQuality <${formatNumber(maxHyalunosit)}';

        } else if (param == 'granular') {
          minGranulosit = HemositChecker.normalGastropodaRanges[genus]!['granular']!;
          status = HemositChecker.checkGranularCalculation(genus,
              calculationResults[param]!);
          standardQuality = '$standardQuality >${formatNumber(minGranulosit)}';

        } else if (param == 'semi_granular') {
          normalSemiGranulosit = HemositChecker.normalGastropodaRanges[genus]!['semi_granular']!;
          status = HemositChecker.checkSemiGranularCalculation(genus,
              calculationResults[param]!);
          standardQuality = '$standardQuality ${formatNumber(normalSemiGranulosit)}';

        } else if (param == 'thc') {
          normalThc = HemositChecker.normalGastropodaRanges[genus]!['thc']!;
          status = HemositChecker.checkTHCCalculation(genus,
              calculationResults[param]!);
          standardQuality = '$standardQuality ${formatNumber(normalThc)}';
        }
      }

      return ResultParameterCard(
        parameterName: param,
        resultValue: resultValue,
        status: status,
        standardQuality: standardQuality,
      );
    }).toList();

    void handleSave() {
      final auth = FirebaseAuth.instance;
      final calculationResult = {
        'species_id': species.id!,
        'station': station,
        'created_at': Timestamp.now(),
        'type': 'fish_hematology',
        ...calculationResults, // Spread operator untuk semua parameter
        'user_id': auth.currentUser!.uid,
      };
      ref.read(databaseServiceProvider).addCalculationResult(calculationResult);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const DataSaved()),
      );
    }

    return SpeciesAnalysisResultPage(
      title: 'Hasil Hemosit',
      resultCards: cards,
      onSave: handleSave,
      showSaveButton: showBottomNav,
    );
  }
}
