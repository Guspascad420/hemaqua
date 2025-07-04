class HematologiChecker {
  static final Map<String, Map<String, List<double>>> normalRanges = {
    'Puntius': {
      'leukosit': [20000, 150000],
      'eritrosit': [15000, 25000],
      'hematokrit': [0.2, 0.3],
      'hemoglobin': [4, 6],
      'mikronuklei': [8, 23],
      'limfosit': [0.7, 0.8],
      'monosit': [0.10, 0.15],
      'neutrofil': [0.5, 0.10]
    },
    'Clarias': {
      'leukosit': [10133, 25480],
      'eritrosit': [15000, 35000],
      'hematokrit': [0.308, 0.455],
      'hemoglobin': [10.3, 13.5],
      'mikronuklei': [8, 23],
      'limfosit': [0.7112, 0.8288],
      'monosit': [0.12, 0.12],
      'neutrofil': [0.7, 0.7]
    },
    'Hemibagrus': {
      'leukosit': [50000, 150000],
      'eritrosit': [50000, 90000],
      'hematokrit': [0.22, 0.6],
      'hemoglobin': [6, 8],
      'mikronuklei': [8, 23],
      'limfosit': [0.7, 0.8],
      'monosit': [0.10, 0.15],
      'neutrofil': [0.5, 0.10]
    },
    'Oreochromis': {
      'leukosit': [50000, 150000],
      'eritrosit': [20000, 3000000],
      'hematokrit': [0.2, 0.3],
      'hemoglobin': [4.0, 9.8],
      'mikronuklei': [8, 23],
      'limfosit': [0.7, 0.8],
      'monosit': [0.10, 0.15],
      'neutrofil': [0.5, 0.10]
    },
    'Cyprinus': {
      'leukosit': [50000, 150000],
      'eritrosit': [61200, 74000],
      'hematokrit': [0.1749, 0.2194],
      'hemoglobin': [5.94, 6.60],
      'mikronuklei': [8, 23],
      'limfosit': [0.7, 0.8],
      'monosit': [0.10, 0.15],
      'neutrofil': [0.5, 0.10]
    },
    'Pangasius': {
      'leukosit': [50000, 150000],
      'eritrosit': [303300, 303300],
      'hematokrit': [0.2933, 0.2933],
      'hemoglobin': [11.13, 11.13],
      'mikronuklei': [8, 23],
      'limfosit': [0.75, 0.82],
      'monosit': [0.11, 0.15],
      'neutrofil': [0.0767, 0.13]
    },
    'Anabas': {
      'leukosit': [50000, 150000],
      'eritrosit': [86600, 86600],
      'hematokrit': [0.2, 0.3],
      'hemoglobin': [5.36, 5.48],
      'mikronuklei': [8, 23],
      'limfosit': [0.7, 0.8],
      'monosit': [0.10, 0.15],
      'neutrofil': [0.5, 0.10]
    },
    'Channa': {
      'leukosit': [153000, 165000],
      'eritrosit': [86600, 86600],
      'hematokrit': [0.2325, 0.2483],
      'hemoglobin': [5, 7],
      'mikronuklei': [8, 23],
      'limfosit': [0.7613, 0.7820],
      'monosit': [0.0573, 0.0653],
      'neutrofil': [0.1607, 0.1740]
    },
    'Osphronemus': {
      'leukosit': [50000, 150000],
      'eritrosit': [1050000, 3000000],
      'hematokrit': [0.2, 0.3],
      'hemoglobin': [5, 7],
      'limfosit': [0.7, 0.8],
      'mikronuklei': [8, 23],
      'monosit': [0.10, 0.15],
      'neutrofil': [0.5, 0.10]
    },
    'Osteochilus': {
      'leukosit': [125000, 333000],
      'eritrosit': [98000, 3330000],
      'hematokrit': [0.17, 0.3333],
      'hemoglobin': [5, 7],
      'limfosit': [0.7, 0.8],
      'mikronuklei': [8, 23],
      'monosit': [0.10, 0.15],
      'neutrofil': [0.5, 0.10]
    },
    'Colossoma': {
      'leukosit': [50000, 150000],
      'eritrosit': [1050000, 3000000],
      'hematokrit': [0.2, 0.3],
      'hemoglobin': [5, 7],
      'limfosit': [0.7, 0.8],
      'mikronuklei': [8, 23],
      'monosit': [0.10, 0.15],
      'neutrofil': [0.5, 0.10]
    },
    'Trichogaster': {
      'leukosit': [50000, 150000],
      'eritrosit': [1050000, 3000000],
      'hematokrit': [0.2, 0.3],
      'hemoglobin': [5, 7],
      'limfosit': [0.7, 0.8],
      'mikronuklei': [8, 23],
      'monosit': [0.10, 0.15],
      'neutrofil': [0.5, 0.10]
    },
    'Tor': {
      'leukosit': [50000, 150000],
      'eritrosit': [1050000, 3000000],
      'hematokrit': [0.2, 0.3],
      'hemoglobin': [5, 7],
      'limfosit': [0.7, 0.8],
      'mikronuklei': [8, 23],
      'monosit': [0.10, 0.15],
      'neutrofil': [0.5, 0.10]
    },
    'Mystus': {
      'leukosit': [50000, 150000],
      'eritrosit': [1050000, 3000000],
      'hematokrit': [0.2, 0.3],
      'hemoglobin': [5, 7],
      'limfosit': [0.7, 0.8],
      'mikronuklei': [8, 23],
      'monosit': [0.10, 0.15],
      'neutrofil': [0.5, 0.10]
    },
    'Gobiopterus': {
      'leukosit': [50000, 150000],
      'eritrosit': [1050000, 3000000],
      'hematokrit': [0.2, 0.3],
      'hemoglobin': [5, 7],
      'limfosit': [0.7, 0.8],
      'mikronuklei': [8, 23],
      'monosit': [0.10, 0.15],
      'neutrofil': [0.5, 0.10]
    },
    'Chanos': {
      'leukosit': [50000, 150000],
      'eritrosit': [1050000, 3000000],
      'hematokrit': [0.2, 0.3],
      'hemoglobin': [5, 7],
      'limfosit': [0.7, 0.8],
      'mikronuklei': [8, 23],
      'monosit': [0.10, 0.15],
      'neutrofil': [0.5, 0.10]
    },
    'Nemacheilus': {
      'leukosit': [50000, 150000],
      'eritrosit': [1050000, 3000000],
      'hematokrit': [0.2, 0.3],
      'hemoglobin': [5, 7],
      'limfosit': [0.7, 0.8],
      'mikronuklei': [8, 23],
      'monosit': [0.10, 0.15],
      'neutrofil': [0.5, 0.10]
    },
    'Hampala': {
      'leukosit': [50000, 150000],
      'eritrosit': [1050000, 3000000],
      'hematokrit': [0.2, 0.3],
      'hemoglobin': [5, 7],
      'limfosit': [0.7, 0.8],
      'mikronuklei': [8, 23],
      'monosit': [0.10, 0.15],
      'neutrofil': [0.5, 0.10]
    },
  };

  static String checkCalculation(String genus, String param, double count) {
    if (normalRanges.containsKey(genus)) {
      final range = normalRanges[genus]?[param]!;
      if (count >= range![0] && count <= range[1]) {
        return 'Normal';
      } else {
        return 'Tidak Normal';
      }
    } else {
      return 'Genus not found in database';
    }
  }
}