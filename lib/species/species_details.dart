import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/models/species.dart';

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

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavoriteSpecies;
  }

  @override
  Widget build(BuildContext context) {
    final hematologiCartList = ref.watch(hematologiCartListProvider);
    final hemositCartList = ref.watch(hemositCartListProvider);

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
            final uid = ref.read(authStateProvider).asData?.value?.uid;
            bool itemAdded = false; // Flag untuk nandain kalo ada item yg ditambah

            if (widget.species.type == "fish" && hematologiCartList.isEmpty) {
              ref.read(databaseServiceProvider).addSpeciesToHematologiCart(widget.species, uid!);
              itemAdded = true;
            } else if (widget.species.type == "molluscs" && hemositCartList.isEmpty) {
              ref.read(databaseServiceProvider).addSpeciesToHemositCart(widget.species, uid!);
              itemAdded = true;
            }

            if (itemAdded) {
              _showSnackBar(context, 'Spesies berhasil ditambahkan', Colors.green);
            } else {
              _showSnackBar(context, 'Keranjang sudah terisi, tidak bisa menambah lagi.', Colors.orange);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 22),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Add to cart',
                    style: GoogleFonts.poppins(
                        fontSize: 20, color: Colors.white)),
                const SizedBox(width: 10),
                const Icon(Icons.shopping_cart_outlined,
                    color: Colors.white, size: 30)
              ],
            ),
          )
      ),
      body: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        child: Image.network(widget.species.image_url),
                      ),
                      Expanded(
                        child: Container(
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
                              Text(widget.species.description,
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  )),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
            );
          }
      )
    );
  }

}