import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WaterQualityGauge extends StatelessWidget {
  final double value;

  const WaterQualityGauge({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    double adjustedValue = value > 151 ? 150 : value;

    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          startAngle: 180,
          endAngle: 0,
          minimum: 0,
          maximum: 151,
          showTicks: false,
          showLabels: false,
          radiusFactor: 0.9,
          axisLineStyle: const AxisLineStyle(thickness: 15),
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 25,
              color: Colors.blue.shade800,
              startWidth: 15,
              endWidth: 15,
            ),
            GaugeRange(
              startValue: 26,
              endValue: 50,
              color: Colors.green.shade800,
              startWidth: 15,
              endWidth: 15,
            ),
            GaugeRange(
              startValue: 51,
              endValue: 75,
              color: Colors.yellow.shade900,
              startWidth: 15,
              endWidth: 15,
            ),
            GaugeRange(
              startValue: 76,
              endValue: 100,
              color: Colors.orange.shade900,
              startWidth: 15,
              endWidth: 15,
            ),
            GaugeRange(
              startValue: 101,
              endValue: 150,
              color: Colors.red.shade900,
              startWidth: 15,
              endWidth: 15,
            ),
            GaugeRange(
              startValue: 150,
              endValue: 151,
              color: Colors.black,
              startWidth: 15,
              endWidth: 15,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: adjustedValue,
              enableAnimation: true,
              needleLength: 0.7,
              needleColor: Colors.black,
              knobStyle: const KnobStyle(color: Colors.black),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              angle: 90,
              positionFactor: 0.5,
              widget: Text(
                value.toStringAsFixed(2),
                style: GoogleFonts.poppins(
                    fontSize: 35.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
