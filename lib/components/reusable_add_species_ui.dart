import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/database/database_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../utils/dashed_border.dart';

class ReusableAddSpeciesUI extends StatefulWidget {
  final int station;
  final String type;

  const ReusableAddSpeciesUI({super.key, required this.station, required this.type});

  @override
  State<ReusableAddSpeciesUI> createState() => _ReusableAddSpeciesUIState();
}

class _ReusableAddSpeciesUIState extends State<ReusableAddSpeciesUI> {
  final _formKey = GlobalKey<FormState>();

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
  TextEditingController identificationKey = TextEditingController();

  bool _isFormValidAndImageSelected = false;

  void _checkFormValidity() {
    setState(() {
      _isFormValidAndImageSelected = localName.text.isNotEmpty &&
          latinName.text.isNotEmpty &&
          description.text.isNotEmpty &&
          _imageFile != null;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      int fileSize = await imageFile.length();

      setState(() {
        _imageFile = imageFile;
        _imageName = basename(pickedFile.path);
        _imageSize = fileSize;
        _checkFormValidity();
      });
    } else {
      setState(() {
        _imageFile = null; // Ensure it's null if user cancels
        _checkFormValidity();
      });
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

  Future<void> _uploadSpecies(BuildContext context) async {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      setState(() {
        _isUploading = true;
      });
      Map<String, dynamic> fishToBeAdded = {
        "name": localName.text,
        "latin_name": latinName.text,
        "description": description.text,
        "type": widget.type,
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
    } else {
      setState(() {
        _isFormValidAndImageSelected = false;
      });
      if (_imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gambar spesies tidak boleh kosong', style: GoogleFonts.poppins()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    localName.addListener(_checkFormValidity);
    latinName.addListener(_checkFormValidity);
    description.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    localName.dispose();
    latinName.dispose();
    description.dispose();
    identificationKey.dispose();
    super.dispose();
  }

  String? _validateRequiredField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                child: Form(
                  key: _formKey,
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
                        TextFormField(
                          controller: localName,
                          decoration: InputDecoration(
                            labelText: 'Nama Lokal',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(width: 1, color: Color(0xFFADD5F8)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(width: 1, color: Color(0xFFADD5F8)),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFEFF6FF),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                          ),
                          validator: (value) => _validateRequiredField(value, 'Nama Lokal'),
                          style: GoogleFonts.poppins(),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: latinName,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(width: 1, color: Color(0xFFADD5F8)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(width: 1, color: Color(0xFFADD5F8)),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFEFF6FF),
                            labelText: 'Nama Latin',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                          ),
                          validator: (value) => _validateRequiredField(value, 'Nama Latin'),
                          style: GoogleFonts.poppins(),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: description,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(width: 1, color: Color(0xFFADD5F8)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(width: 1, color: Color(0xFFADD5F8)),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFEFF6FF),
                            labelText: 'Deskripsi',
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                          ),
                          validator: (value) => _validateRequiredField(value, 'Deskripsi'),
                          maxLines: 3, // For multiline description
                          style: GoogleFonts.poppins(),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
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
                        if (_imageFile == null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                            child: Text(
                              'Gambar spesies tidak boleh kosong',
                              style: GoogleFonts.poppins(color: Theme.of(context).colorScheme.error, fontSize: 12),
                            ),
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
                        TextFormField(
                          controller: identificationKey,
                          decoration: InputDecoration(
                            labelText: 'Kunci Identifikasi (Opsional)',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(width: 1, color: Color(0xFFADD5F8)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(width: 1, color: Color(0xFFADD5F8)),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFEFF6FF),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                          ),
                          style: GoogleFonts.poppins(),
                          textInputAction: TextInputAction.done,
                          // No validator, as it's optional
                        ),
                        const SizedBox(height: 40),
                        Center(
                            child: ElevatedButton(
                                onPressed: (_isFormValidAndImageSelected && !_isUploading)
                                    ? () {
                                  _uploadSpecies(context);
                                }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)),
                                    )),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 50
                                    ),
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
                  )
                )
            )
        )
      ],
    );
  }

}