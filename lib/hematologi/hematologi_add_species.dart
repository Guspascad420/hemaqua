import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/database/database_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hematologi/utils/reusableTextField.dart';
import 'package:path/path.dart';

import '../utils/dashed_border.dart';

class HematologiAddSpecies extends StatefulWidget {
  final int station;

  const HematologiAddSpecies({super.key, required this.station});

  @override
  State<HematologiAddSpecies> createState() => _HematologiAddSpeciesState();
}

class _HematologiAddSpeciesState extends State<HematologiAddSpecies> {
  File? _imageFile;
  String? _imageName;
  int _imageSize = 0;
  bool _isError = false;
  bool _isUploading = false;
  final ImagePicker _picker = ImagePicker();
  DatabaseService service = DatabaseService();

  TextEditingController localName = TextEditingController();
  TextEditingController latinName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController identificationKey = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      int fileSize = await imageFile.length();

      setState(() {
        _imageFile = imageFile;
        _imageName = basename(pickedFile.path);
        _imageSize = fileSize;
      });
    }
  }

  Future<void> _uploadSpecies(BuildContext context) async {
    if (_imageFile == null) {
      return;
    }
    setState(() {
      _isUploading = true;
    });
    Map<String, dynamic> fishToBeAdded = {
      "name": localName.text,
      "latin_name": latinName.text,
      "description": description.text,
      "type": "fish",
      "stations": [widget.station],
    };
    try {
     await service.addNewSpecies(fishToBeAdded, _imageFile!);
     setState(() {
       _isError = false;
     });
    } catch (e) {
      setState(() {
        _isError = true;
      });
    } finally {
      _isUploading = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(!_isError ? 'Berhasil Disimpan!' : 'Gagal Disimpan',
                style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            content: Text(
                !_isError
                    ? 'Data telah disimpan dan berhasil ditambahkan'
                    : 'Cek koneksi internet anda',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 17,
                )),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('OKE',
                    style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ),
            ],
          );
        },
      );
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return "$bytes B";
    } else if (bytes < 1024 * 1024) {
      return "${(bytes / 1024).toStringAsFixed(2)} KB";
    } else {
      return "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(height: double.infinity, color: Colors.blue,),
        Column(
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF60A5FA).withOpacity(0.3),
                          blurRadius: 3,
                          offset: const Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(left: 20),
                    child: IconButton(
                      padding: const EdgeInsets.only(left: 7),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.blue),
                    )),
                Text('Stasiun 1',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w600)),
                const SizedBox(
                  width: 40,
                )
              ],
            ),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.25),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Center(
                            child: SizedBox(
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
                          reusableTextField('Nama Lokal', localName),
                          reusableTextField('Nama Latin', latinName),
                          reusableTextField('Deskripsi', description,
                              TextInputType.multiline),
                          GestureDetector(
                              onTap: _pickImage,
                              child: DashedBorderContainer(
                                  child: Center(
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.cloud_upload_outlined,
                                      color: Colors.blue,
                                      size: 50,
                                    ),
                                    const SizedBox(height: 5),
                                    Text('Telusuri gambar anda',
                                        style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 5),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                          'Ukuran file yang diizinkan maksimal 5 MB',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: Colors.grey[600],
                                          )),
                                    )
                                  ],
                                ),
                              ))
                          ),
                          if (_imageFile != null)
                            Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFFDFEDFE)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        Image.asset('images/jpg_file.png',
                                            scale: 2.5),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('$_imageName',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(_formatFileSize(_imageSize),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.grey)),
                                          ],
                                        )
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _imageFile = null;
                                          });
                                        },
                                        icon: const Icon(Icons.delete_outline,
                                            color: Colors.blue))
                                  ],
                                )
                            ),
                          const SizedBox(height: 20),
                          reusableTextField('Kunci Identifikasi (Opsional)', identificationKey),
                          const SizedBox(height: 40),
                          Center(
                              child: ElevatedButton(
                                  onPressed: _isUploading
                                      ? () {}
                                      : () {
                                          _uploadSpecies(context);
                                        },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      )),
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 50),
                                      child: _isUploading
                                          ? const CircularProgressIndicator(
                                              color: Colors.white)
                                          : Text('Tambah',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w500))
                                  )
                              )
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    )))
          ],
        )
      ],
    ));
  }
}
