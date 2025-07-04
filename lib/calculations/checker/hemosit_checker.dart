import 'package:flutter/foundation.dart';

class HemositChecker {
  static final Map<String, Map<String, double>> normalGastropodaRanges = {
    'Sulcospira': {
      'thc': 580000,
      'hyalin': 0.622,
      'semi_granular': 0.371,
      'granular': 0.185
    },
    'Pomacea': {
      'thc': 600000,
      'hyalin': 0.585,
      'semi_granular': 0.371,
      'granular': 0.185
    },
    'Filopaludina': {
      'thc': 580000,
      'hyalin': 0.622,
      'semi_granular': 0.371,
      'granular': 0.185
    },
    'Pila': {
      'thc': 580000,
      'hyalin': 0.622,
      'semi_granular': 0.371,
      'granular': 0.185
    },
    'Amerianna': {
      'thc': 580000,
      'hyalin': 0.622,
      'semi_granular': 0.371,
      'granular': 0.185
    },
    'Melanoides': {
      'thc': 580000,
      'hyalin': 0.622,
      'semi_granular': 0.371,
      'granular': 0.185
    },
    'Terebia': {
      'thc': 580000,
      'hyalin': 0.622,
      'semi_granular': 0.371,
      'granular': 0.185
    },
    'Mieniplotia': {
      'thc': 580000,
      'hyalin': 0.622,
      'semi_granular': 0.371,
      'granular': 0.185
    },
    'Stenomelania': {
      'thc': 580000,
      'hyalin': 0.622,
      'semi_granular': 0.371,
      'granular': 0.185
    },
    'Thiara': {
      'thc': 580000,
      'hyalin': 0.622,
      'semi_granular': 0.371,
      'granular': 0.185
    },
    'Sermyla': {
      'thc': 580000,
      'hyalin': 0.622,
      'semi_granular': 0.371,
      'granular': 0.185
    },
    'Bythinia': {
      'thc': 580000,
      'hyalin': 0.622,
      'semi_granular': 0.371,
      'granular': 0.185
    },
    'Radix': {
      'thc': 580000,
      'hyalin': 0.622,
      'semi_granular': 0.371,
      'granular': 0.185
    },
    'Indoplarnobis': {
      'thc': 580000,
      'hyalin': 0.622,
      'semi_granular': 0.371,
      'granular': 0.185
    },
  };

  static final Map<String, Map<String, List<double>>> normalBivalviaRanges = {
    'Anodonta': {
      'thc': [640000],
      'hyalin': [0.763, 0.873],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.1124, 0.224]
    },
    'Corbicula': {
      'thc': [450000],
      'hyalin': [0.2961, 0.442],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.4453, 0.5784]
    },
    'Hyriopsis': {
      'thc': [2090000],
      'hyalin': [0.763, 0.873],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.1124, 0.224]
    },
    'Sinanodonta': {
      'thc': [640000],
      'hyalin': [0.763, 0.873],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.1124, 0.224]
    },
    'Pseudodon': {
      'thc': [640000],
      'hyalin': [0.763, 0.873],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.1124, 0.224]
    },
    'Donax': {
      'thc': [3550000],
      'hyalin': [0.763, 0.873],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.1124, 0.224]
    },
    'Paphia': {
      'thc': [61640000],
      'hyalin': [0.763, 0.873],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.1124, 0.224]
    },
    'Tridacna': {
      'thc': [640000],
      'hyalin': [0.763, 0.873],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.1124, 0.224]
    },
    'Meretrix': {
      'thc': [4400000],
      'hyalin': [0.4971, 0.4971],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.1935, 0.1935]
    },
    'Perna': {
      'thc': [640000],
      'hyalin': [0.763, 0.873],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.1124, 0.224]
    },
    'Pilsbryoconcha': {
      'thc': [640000],
      'hyalin': [0.763, 0.873],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.1124, 0.224]
    },
    'Glauconome': {
      'thc': [640000],
      'hyalin': [0.763, 0.873],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.1124, 0.224]
    },
    'Batissa': {
      'thc': [640000],
      'hyalin': [0.763, 0.873],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.1124, 0.224]
    },
    'Lamellidens': {
      'thc': [640000],
      'hyalin': [0.763, 0.873],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.1124, 0.224]
    },
    'Physunio': {
      'thc': [640000],
      'hyalin': [0.763, 0.873],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.1124, 0.224]
    },
    'Beringiana': {
      'thc': [640000],
      'hyalin': [0.763, 0.873],
      'semi_granular': [0.2063, 0.3483],
      'granular': [0.1124, 0.224]
    },
  };

  static String checkBivalviaCalculation(String genus, String param, double count) {
    if (normalBivalviaRanges.containsKey(genus)) {
      final range = normalBivalviaRanges[genus]?[param]!;
      if (count >= range![0] && count <= range[1]) {
        return 'Normal';
      } else {
        return 'Tidak Normal';
      }
    } else {
      return 'Genus not found in database';
    }
  }

  static String checkTHCCalculation(String genus, double count) {
    if (count == normalGastropodaRanges[genus]?['thc']) {
      return 'Normal';
    } else {
      return 'Tidak Normal';
    }
  }

  static String checkHyalunositCalculation(String genus, double count) {
    if (count < normalGastropodaRanges[genus]!['hyalin']!) {
      return 'Normal';
    } else {
      return 'Tidak Normal';
    }
  }

  static String checkSemiGranularCalculation(String genus, double count) {
    if (count == normalGastropodaRanges[genus]?['semi_granular']) {
      return 'Normal';
    } else {
      return 'Tidak Normal';
    }
  }

  static String checkGranularCalculation(String genus, double count) {
    debugPrint("Count : $count");
    debugPrint("${normalGastropodaRanges[genus]}");

    if (count > normalGastropodaRanges[genus]!['granular']!) {
      return 'Normal';
    } else {
      return 'Tidak Normal';
    }
  }
}