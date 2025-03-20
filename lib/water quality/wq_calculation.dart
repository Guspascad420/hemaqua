import 'dart:math';

class WaterPollutionIndex {
  static double calculateWQI(Map<String, double> testValues, {double? naturalTemp}) {
    if (testValues.length < 6) {
      throw ArgumentError("Minimal 6 parameter harus diberikan untuk perhitungan.");
    }

    Map<String, double> standards = {
      "pH": 7.5,
      "DO": 4.0,
      "BOD": 3.0,
      "COD": 25.0,
      "Nitrat": 10.0,
      "Nitrit": 0.06,
      "TSS": 50.0,
      "Sulfat": 300.0,
      "Fenol": 0.05,
      "Merkuri": 0.002,
      "Timbal": 0.03,
      "Tembaga": 0.02,
      "Kromium": 0.05
    };
    List<double> qnWnCalculations = [];
    double sumWn = 0.0;
    double x = 0.0;

    testValues.forEach((parameter, vn) {
      if (standards.containsKey(parameter)) {
        x += 1 / standards[parameter]!;
      }
    });

    double k = 1 / x;
    testValues.forEach((parameter, vn) {
      if (standards.containsKey(parameter)) {
        double standard = standards[parameter]!;
        double wn = k / standard;
        double qn = 0;

        if (parameter == "pH") {
          qn = ((vn - 7).abs() / (standard - 7)) * 100;
        } else if (parameter == "DO") {
          qn = ((14.6 - vn) / (14.6 - standard)) * 100;
        } else {
          qn = (vn / standard) * 100;
        }

        qnWnCalculations.add(qn * wn);
        sumWn += wn;
      }
    });
    double wqi = qnWnCalculations.reduce((a, b) => a + b) / sumWn;
    return wqi;
  }

  // Method untuk mendapatkan kategori pencemaran berdasarkan IP
  static String pollutionCategory(double wqi) {
    if (wqi < 26) {
      return "Excellent";
    } else if (wqi < 51) {
      return "Bagus";
    } else if (wqi < 76) {
      return "Cukup";
    } else if (wqi < 101) {
      return "Buruk";
    } else if (wqi < 151) {
      return "Sangat Buruk";
    } else {
      return "Tidak Layak";
    }
  }

  static String getCopywritingBasedOnCategory(double wqi) {
    String category = pollutionCategory(wqi);

    switch (category) {
      case "Excellent":
        return "Air sungai yang sangat baik, anugerah alam yang tak ternilai. Kejernihan dan kemurniannya mencerminkan ekosistem yang sehat dan seimbang. Mari kita jaga keindahan ini agar terus mengalirkan kehidupan";

        case "Bagus":
        return "Air yang berada dalam kondisi baik adalah sumber kehidupan yang mendukung kesejahteraan makhluk hidup di sekitarnya. Dengan parameter yang memenuhi baku mutu, air ini tetap bersih dan aman, memberikan manfaat bagi ekosistem serta manusia. Jaga kebersihan dan kelestariannya agar tetap terjaga";

      case "Cukup":
        return "Kualitas air sungai dalam kondisi cukup memerlukan perhatian lebih. Meskipun masih memenuhi beberapa standar, upaya perbaikan perlu dilakukan untuk mencegah penurunan kualitas lebih lanjut. Mari bersama-sama tingkatkan kualitas air demi masa depan yang lebih baik";

      case "Buruk":
        return "Kondisi air sungai yang buruk adalah peringatan bagi kita semua. Dampak pencemaran telah merusak keseimbangan ekosistem dan mengancam kesehatan. Tindakan nyata diperlukan untuk memulihkan kondisi air dan mencegah kerusakan lebih parah";

      case "Sangat Buruk":
        return "Air sungai dalam kondisi sangat buruk adalah krisis lingkungan yang serius. Pencemaran berat telah menyebabkan kerusakan ekosistem yang parah. Langkah-langkah drastis dan kolaboratif sangat dibutuhkan untuk menyelamatkan sumber daya air yang berharga ini";

      default:
        return "Air sungai yang tidak layak digunakan adalah hasil dari kelalaian kita terhadap lingkungan. Air yang tercemar berat ini tidak hanya berbahaya bagi manusia, tetapi juga menghancurkan kehidupan akuatik. Mari kita ambil tanggung jawab untuk memulihkan dan melindungi sumber air kita";
    }
  }

}