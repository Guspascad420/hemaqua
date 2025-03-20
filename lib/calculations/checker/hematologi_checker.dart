class HematologiChecker {
  static final Map<String, Map<String, List<double>>> normalRanges = {
    'Puntius': {
      'Leukosit': [20000, 150000],
      'Eritrosit': [15000, 25000],
      'Hematokrit': [0.2, 0.3],
      'Hemoglobin': [4, 6],
      'Mikronuklei': [8, 23],
      'Limfosit': [0.7, 0.8],
      'Monosit': [0.10, 0.15],
      'Neutrofil': [0.5, 0.10]
    },
    'Clarias': {
      'Leukosit': [10133, 25480],
      'Eritrosit': [15000, 35000],
      'Hematokrit': [0.308, 0.455],
      'Hemoglobin': [10.3, 13.5],
      'Mikronuklei': [8, 23],
      'Limfosit': [0.7112, 0.8288],
      'Monosit': [0.12, 0.12],
      'Neutrofil': [0.7, 0.7]
    },
    'Hemibagrus': {
      'Leukosit': [50000, 150000],
      'Eritrosit': [50000, 90000],
      'Hematokrit': [0.22, 0.6],
      'Hemoglobin': [6, 8],
      'Limfosit': [0.7, 0.8],
      'Monosit': [0.10, 0.15],
      'Neutrofil': [0.5, 0.10]
    },
    'Oreochromis': {
      'Leukosit': [50000, 150000],
      'Eritrosit': [20000, 3000000],
      'Hematokrit': [0.2, 0.3],
      'Hemoglobin': [4.0, 9.8],
      'Mikronuklei': [8, 23],
      'Limfosit': [0.7, 0.8],
      'Monosit': [0.10, 0.15],
      'Neutrofil': [0.5, 0.10]
    },
    'Cyprinus': {
      'Leukosit': [50000, 150000],
      'Eritrosit': [61200, 74000],
      'Hematokrit': [0.1749, 0.2194],
      'Hemoglobin': [5.94, 6.60],
      'Limfosit': [0.7, 0.8],
      'Monosit': [0.10, 0.15],
      'Neutrofil': [0.5, 0.10]
    },
    'Pangasius': {
      'Leukosit': [50000, 150000],
      'Eritrosit': [303300, 303300],
      'Hematokrit': [0.2933, 0.2933],
      'Hemoglobin': [11.13, 11.13],
      'Limfosit': [0.75, 0.82],
      'Monosit': [0.11, 0.15],
      'Neutrofil': [0.0767, 0.13]
    },
    'Anabas': {
      'Leukosit': [50000, 150000],
      'Eritrosit': [86600, 86600],
      'Hematokrit': [0.2, 0.3],
      'Hemoglobin': [5.36, 5.48],
      'Limfosit': [0.7, 0.8],
      'Monosit': [0.10, 0.15],
      'Neutrofil': [0.5, 0.10]
    },
    'Channa': {
      'Leukosit': [153000, 165000],
      'Eritrosit': [86600, 86600],
      'Hematokrit': [0.2325, 0.2483],
      'Hemoglobin': [5, 7],
      'Limfosit': [0.7613, 0.7820],
      'Monosit': [0.0573, 0.0653],
      'Neutrofil': [0.1607, 0.1740]
    },
    'Osphronemus': {
      'Leukosit': [50000, 150000],
      'Eritrosit': [1050000, 3000000],
      'Hematokrit': [0.2, 0.3],
      'Hemoglobin': [5, 7],
      'Limfosit': [0.7, 0.8],
      'Monosit': [0.10, 0.15],
      'Neutrofil': [0.5, 0.10]
    },
    'Osteochilus': {
      'Leukosit': [125000, 333000],
      'Eritrosit': [98000, 3330000],
      'Hematokrit': [0.17, 0.3333],
      'Hemoglobin': [5, 7],
      'Limfosit': [0.7, 0.8],
      'Monosit': [0.10, 0.15],
      'Neutrofil': [0.5, 0.10]
    },
    'Colossoma': {
      'Leukosit': [50000, 150000],
      'Eritrosit': [1050000, 3000000],
      'Hematokrit': [0.2, 0.3],
      'Hemoglobin': [5, 7],
      'Limfosit': [0.7, 0.8],
      'Monosit': [0.10, 0.15],
      'Neutrofil': [0.5, 0.10]
    },
    'Trichogaster': {
      'Leukosit': [50000, 150000],
      'Eritrosit': [1050000, 3000000],
      'Hematokrit': [0.2, 0.3],
      'Hemoglobin': [5, 7],
      'Limfosit': [0.7, 0.8],
      'Monosit': [0.10, 0.15],
      'Neutrofil': [0.5, 0.10]
    },
    'Tor': {
      'Leukosit': [50000, 150000],
      'Eritrosit': [1050000, 3000000],
      'Hematokrit': [0.2, 0.3],
      'Hemoglobin': [5, 7],
      'Limfosit': [0.7, 0.8],
      'Monosit': [0.10, 0.15],
      'Neutrofil': [0.5, 0.10]
    },
    'Mystus': {
      'Leukosit': [50000, 150000],
      'Eritrosit': [1050000, 3000000],
      'Hematokrit': [0.2, 0.3],
      'Hemoglobin': [5, 7],
      'Limfosit': [0.7, 0.8],
      'Monosit': [0.10, 0.15],
      'Neutrofil': [0.5, 0.10]
    },
    'Gobiopterus': {
      'Leukosit': [50000, 150000],
      'Eritrosit': [1050000, 3000000],
      'Hematokrit': [0.2, 0.3],
      'Hemoglobin': [5, 7],
      'Limfosit': [0.7, 0.8],
      'Monosit': [0.10, 0.15],
      'Neutrofil': [0.5, 0.10]
    },
    'Chanos': {
      'Leukosit': [50000, 150000],
      'Eritrosit': [1050000, 3000000],
      'Hematokrit': [0.2, 0.3],
      'Hemoglobin': [5, 7],
      'Limfosit': [0.7, 0.8],
      'Monosit': [0.10, 0.15],
      'Neutrofil': [0.5, 0.10]
    },
    'Nemacheilus': {
      'Leukosit': [50000, 150000],
      'Eritrosit': [1050000, 3000000],
      'Hematokrit': [0.2, 0.3],
      'Hemoglobin': [5, 7],
      'Limfosit': [0.7, 0.8],
      'Monosit': [0.10, 0.15],
      'Neutrofil': [0.5, 0.10]
    },
    'Hampala': {
      'Leukosit': [50000, 150000],
      'Eritrosit': [1050000, 3000000],
      'Hematokrit': [0.2, 0.3],
      'Hemoglobin': [5, 7],
      'Limfosit': [0.7, 0.8],
      'Monosit': [0.10, 0.15],
      'Neutrofil': [0.5, 0.10]
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