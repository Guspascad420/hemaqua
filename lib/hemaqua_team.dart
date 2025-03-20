import 'package:flutter/material.dart';
import 'package:hematologi/cards/team_card.dart';

class HemaquaTeam extends StatelessWidget {
  const HemaquaTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              teamCard('images/asus_maizar.png', 'Asus Maizar'),
              teamCard('images/m_asnin.png', 'M. Asnin'),
              teamCard('images/4266925.png', 'Renanda Bagas'),
              teamCard('images/kasyful.png', 'Kasyful'),
            ],
          ),
        )
      )
    );
  }

}