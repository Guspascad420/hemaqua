import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/components/analysis/analysis_result_card.dart';
import 'package:hematologi/hemosit/hemosit_parameters.dart';
import 'package:hematologi/models/chart_data.dart';
import 'package:hematologi/models/species.dart';

import '../hematologi/hematologi_parameters.dart';
import '../provider/history_providers.dart';
import '../provider/providers.dart';

class SpeciesDetails extends ConsumerStatefulWidget {
  const SpeciesDetails({super.key, required this.species,
    required this.station,
    required this.isFavoriteSpecies, required this.showBottomNav});

  final int station;
  final bool isFavoriteSpecies;
  final bool showBottomNav;
  final Species species;

  @override
  ConsumerState<SpeciesDetails> createState() => _SpeciesDetailsState();
}

class _SpeciesDetailsState extends ConsumerState<SpeciesDetails> {

  bool _isFavorite = false;
  final List<String> dataTypes = [];

  void _showSnackBar(BuildContext context, String textContent, MaterialColor backgroundColor) {
    SnackBar snackBar = SnackBar(
      content: Text(textContent),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _addSpeciesToFavorite() {
    final uid = ref.read(authStateProvider).asData?.value?.uid;
    ref.read(databaseServiceProvider).addSpeciesToFavorite(widget.species, uid!);
    setState(() {
      _isFavorite = !_isFavorite;
    });
    _showSnackBar(context, "Berhasil menambahkan ikan ke favorit", Colors.blue);
  }

  void _removeSpeciesFromFavorite() {
    final uid = ref.read(authStateProvider).asData?.value?.uid;
    ref.read(databaseServiceProvider).removeSpeciesFromFavorite(widget.species, uid!);
    setState(() {
      _isFavorite = !_isFavorite;
    });
    _showSnackBar(context, "Berhasil menghapus ikan dari favorit", Colors.blue);
  }

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

  Widget _mainContent(int totalAnalysisCount, WidgetRef ref) {
    final speciesCalculationsData = ref.watch(speciesCalculationDataProvider(widget.species.id!));
    // final groupingMode = ref.watch(groupingModeProvider);
    final totalAnalysisCount = ref.watch(totalAnalysisCountProvider(widget.species.id!));
    final selectedComponent = ref.watch(selectedComponentProvider(widget.species.type));

    List<BloodComponent> relevantComponents = [];
    switch (widget.species.type) {
      case 'fish':
        relevantComponents = [
          BloodComponent.eritrosit, BloodComponent.leukosit, BloodComponent.hematokrit,
          BloodComponent.hemoglobin, BloodComponent.mikronuklei, BloodComponent.limfosit,
          BloodComponent.monosit, BloodComponent.neutrofil,
        ];
        break;
      case 'mollusc':
        relevantComponents = [
          BloodComponent.thc,
          BloodComponent.hyalin,
          BloodComponent.granular,
          BloodComponent.semi_granular,
        ];
        break;
    }

    return Container(
      padding: const EdgeInsets.only(left: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              width: 70,
              height: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.species.name,
                  style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontSize: 27,
                      fontWeight: FontWeight.w500
                  )),
              Visibility(
                  visible: ref.read(authStateProvider).asData?.value?.uid != null,
                  child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          onPressed: _isFavorite ? _removeSpeciesFromFavorite : _addSpeciesToFavorite,
                          icon: _isFavorite
                              ? const Icon(Icons.favorite, color: Colors.red)
                              : const Icon(Icons.favorite_border)
                      )
                  )
              )
            ],
          ),
          Text(widget.species.latin_name,
              style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              )),
          const SizedBox(height: 25),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.blue, size: 40,),
              const SizedBox(width: 4),
              Text('Stasiun ${widget.station}',
                  style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )),
            ],
          ),
          const SizedBox(height: 25),
          Text('Deskripsi',
              style: GoogleFonts.poppins(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              )),
          const SizedBox(height: 5),
          Container(
            margin: EdgeInsets.only(right: 15.w),
            child: Text(widget.species.description,
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 15,
                ))
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Analisis',
                  style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )),
              Container(
                margin: EdgeInsets.only(right: 15.w),
                child: Text('${totalAnalysisCount.value ?? 0} Kali',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.grey
                    )),
              )
            ],
          ),
          SizedBox(height: 15.h),
          Text('Tren Parameter (30 hari terakhir)',
              style: GoogleFonts.poppins(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              )),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownMenu<BloodComponent>(
                initialSelection: selectedComponent,
                menuStyle: MenuStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.white)
                ),
                dropdownMenuEntries: relevantComponents.map((comp) {
                  return DropdownMenuEntry(
                    value: comp,
                    label: formatToTitleCase(comp.name),
                  );
                }).toList(),
                onSelected: (val) {
                  if (val != null) ref.read(selectedComponentProvider(widget.species.type).notifier).state = val;
                },
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              )
            ],
          ),
          SizedBox(height: 20.h),
          speciesCalculationsData.when(
            data: (data) {
              if (data.isEmpty) {
                return Center(child: Text('no data'));
              }
              final chartData = _buildSpotsFromRaw(
                rawData: data,
                selectedType: selectedComponent,
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 300.h,
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: chartData.spots,
                              isCurved: true,
                              color: Colors.teal,
                              dotData: const FlDotData(show: true),
                              barWidth: 3,
                            )
                          ],
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final index = value.toInt();

                                  final isDataPoint = chartData.spots.any((spot) => spot.x == index.toDouble());

                                  if (!isDataPoint) return const SizedBox.shrink();

                                  final date = chartData.dates[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      '${date.day}/${date.month}',
                                      style: GoogleFonts.poppins(fontSize: 12),
                                    ),
                                  );
                                },
                                reservedSize: 30,
                                interval: 1,
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Riwayat Analisis',
                          style: GoogleFonts.poppins(
                              color: Colors.blue,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                          )),
                      Container(
                        margin: EdgeInsets.only(right: 15.w),
                        child: TextButton(
                            onPressed: () {

                            },
                            child: Text('Lihat semua',
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  color: Colors.grey,
                                ))
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length > 3 ? 3 : data.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final result = data[index];
                      return AnalysisResultCard(result: result, style: ResultCardStyle.compact);
                    }),
                  SizedBox(height: 25.h)
                ],
              );
            },
            error: (err, stack) => const Center(child: Icon(Icons.error)),
            loading: () => const Center(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }

  ChartData _buildSpotsFromRaw({
    required List<Map<String, dynamic>> rawData,
    required BloodComponent selectedType,
  }) {
    final Map<DateTime, List<double>> grouped = {};

    for (final entry in rawData) {
      if (entry['created_at'] == null || entry[selectedType.name] == null) continue;

      final ts = entry['created_at'] as Timestamp;
      final rawDate = ts.toDate();
      final dateOnly = DateTime(rawDate.year, rawDate.month, rawDate.day);

      final value = (entry[selectedType.name] ?? 0).toDouble();

      if (value == 0) continue;

      grouped.putIfAbsent(dateOnly, () => []).add(value);
    }

    final sortedDates = grouped.keys.toList()..sort();
    final List<FlSpot> spots = [];

    for (int i = 0; i < sortedDates.length; i++) {
      final date = sortedDates[i];
      final values = grouped[date]!;

      if (values.isEmpty) continue;

      final avg = values.reduce((a, b) => a + b) / values.length;
      debugPrint("$avg");
      spots.add(FlSpot(i.toDouble(), avg));
    }

    return ChartData(spots, sortedDates);
  }


  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavoriteSpecies;
  }

  @override
  Widget build(BuildContext context) {
    final imageUrlAsync = ref.watch(imageUrlProvider(widget.species.image_url ?? ''));

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
            ),
            margin: const EdgeInsets.only(left: 20),
            child: IconButton(
              padding: const EdgeInsets.only(left: 7),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
            )
        ),
        title: Text('Detail Spesies',
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w600
            )),
      ),
      bottomNavigationBar: !widget.showBottomNav ? null : GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => widget.species.type == 'fish'
                    ? HematologiParameters(
                        species: widget.species, station: widget.station
                      )
                    : HemositParameters(species: widget.species, station: widget.station))
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 22),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Mulai Analisis',
                    style: GoogleFonts.poppins(
                        fontSize: 20, color: Colors.white)),
              ],
            ),
          )
      ),
      body: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: Column(
                    children: [
                      imageUrlAsync.when(
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (err, stack) => const Center(child: Icon(Icons.error)),
                          data: (url) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 30),
                              child: Image.network(url),
                            );
                          }
                      ),
                      _mainContent(0, ref)
                    ],
                  )
              ),
            );
          }
      )
    );
  }

}