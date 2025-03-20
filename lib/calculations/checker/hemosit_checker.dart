import 'package:flutter/foundation.dart';

class HemositChecker {
  static final Map<String, Map<String, double>> normalGastropodaRanges = {
    'Sulcospira': {
      'THC': 580000,
      'Hyalin': 0.622,
      'Semi Granular': 0.371,
      'Granular': 0.185
    },
    'Pomacea': {
      'THC': 600000,
      'Hyalin': 0.585,
      'Semi Granular': 0.371,
      'Granular': 0.185
    },
    'Filopaludina': {
      'THC': 580000,
      'Hyalin': 0.622,
      'Semi Granular': 0.371,
      'Granular': 0.185
    },
    'Pila': {
      'THC': 580000,
      'Hyalin': 0.622,
      'Semi Granular': 0.371,
      'Granular': 0.185
    },
    'Amerianna': {
      'THC': 580000,
      'Hyalin': 0.622,
      'Semi Granular': 0.371,
      'Granular': 0.185
    },
    'Melanoides': {
      'THC': 580000,
      'Hyalin': 0.622,
      'Semi Granular': 0.371,
      'Granular': 0.185
    },
    'Terebia': {
      'THC': 580000,
      'Hyalin': 0.622,
      'Semi Granular': 0.371,
      'Granular': 0.185
    },
    'Mieniplotia': {
      'THC': 580000,
      'Hyalin': 0.622,
      'Semi Granular': 0.371,
      'Granular': 0.185
    },
    'Stenomelania': {
      'THC': 580000,
      'Hyalin': 0.622,
      'Semi Granular': 0.371,
      'Granular': 0.185
    },
    'Thiara': {
      'THC': 580000,
      'Hyalin': 0.622,
      'Semi Granular': 0.371,
      'Granular': 0.185
    },
    'Sermyla': {
      'THC': 580000,
      'Hyalin': 0.622,
      'Semi Granular': 0.371,
      'Granular': 0.185
    },
    'Bythinia': {
      'THC': 580000,
      'Hyalin': 0.622,
      'Semi Granular': 0.371,
      'Granular': 0.185
    },
    'Radix': {
      'THC': 580000,
      'Hyalin': 0.622,
      'Semi Granular': 0.371,
      'Granular': 0.185
    },
    'Indoplarnobis': {
      'THC': 580000,
      'Hyalin': 0.622,
      'Semi Granular': 0.371,
      'Granular': 0.185
    },
  };

  static final Map<String, Map<String, List<double>>> normalBivalviaRanges = {
    'Anodonta': {
      'THC': [640000],
      'Hyalin': [0.763, 0.873],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.1124, 0.224]
    },
    'Corbicula': {
      'THC': [450000],
      'Hyalin': [0.2961, 0.442],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.4453, 0.5784]
    },
    'Hyriopsis': {
      'THC': [2090000],
      'Hyalin': [0.763, 0.873],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.1124, 0.224]
    },
    'Sinanodonta': {
      'THC': [640000],
      'Hyalin': [0.763, 0.873],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.1124, 0.224]
    },
    'Pseudodon': {
      'THC': [640000],
      'Hyalin': [0.763, 0.873],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.1124, 0.224]
    },
    'Donax': {
      'THC': [3550000],
      'Hyalin': [0.763, 0.873],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.1124, 0.224]
    },
    'Paphia': {
      'THC': [61640000],
      'Hyalin': [0.763, 0.873],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.1124, 0.224]
    },
    'Tridacna': {
      'THC': [640000],
      'Hyalin': [0.763, 0.873],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.1124, 0.224]
    },
    'Meretrix': {
      'THC': [4400000],
      'Hyalin': [0.4971, 0.4971],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.1935, 0.1935]
    },
    'Perna': {
      'THC': [640000],
      'Hyalin': [0.763, 0.873],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.1124, 0.224]
    },
    'Pilsbryoconcha': {
      'THC': [640000],
      'Hyalin': [0.763, 0.873],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.1124, 0.224]
    },
    'Glauconome': {
      'THC': [640000],
      'Hyalin': [0.763, 0.873],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.1124, 0.224]
    },
    'Batissa': {
      'THC': [640000],
      'Hyalin': [0.763, 0.873],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.1124, 0.224]
    },
    'Lamellidens': {
      'THC': [640000],
      'Hyalin': [0.763, 0.873],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.1124, 0.224]
    },
    'Physunio': {
      'THC': [640000],
      'Hyalin': [0.763, 0.873],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.1124, 0.224]
    },
    'Beringiana': {
      'THC': [640000],
      'Hyalin': [0.763, 0.873],
      'Semi Granular': [0.2063, 0.3483],
      'Granular': [0.1124, 0.224]
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
    if (count == normalGastropodaRanges[genus]?['THC']) {
      return 'Normal';
    } else {
      return 'Tidak Normal';
    }
  }

  static String checkHyalunositCalculation(String genus, double count) {
    if (count < normalGastropodaRanges[genus]!['Hyalin']!) {
      return 'Normal';
    } else {
      return 'Tidak Normal';
    }
  }

  static String checkSemiGranularCalculation(String genus, double count) {
    if (count == normalGastropodaRanges[genus]?['Semi Granular']) {
      return 'Normal';
    } else {
      return 'Tidak Normal';
    }
  }

  static String checkGranularCalculation(String genus, double count) {
    debugPrint("Count : $count");
    debugPrint("${normalGastropodaRanges[genus]}");

    if (count > normalGastropodaRanges[genus]!['Granular']!) {
      return 'Normal';
    } else {
      return 'Tidak Normal';
    }
  }
}