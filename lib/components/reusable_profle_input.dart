import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ReusableProfileInput extends StatefulWidget {
  final String initialPhotoUrl;
  final String initialUsername;
  final String initialInsitution;
  final String? initialGender;
  final DateTime? initialDate;
  final Future<void> Function(String username, String institution, [String? dateOfBirth,
  String? selectedGender, File? imageFile]) onSave;

  const ReusableProfileInput({super.key, required this.onSave,
    this.initialPhotoUrl = '', // Defaultnya string kosong
    this.initialUsername = '',
    this.initialGender,
    this.initialDate,
    this.initialInsitution = ''});

  @override
  State<ReusableProfileInput> createState() => _ReusableProfileInputState();
}

class _ReusableProfileInputState extends State<ReusableProfileInput> {
  late final TextEditingController _usernameTextController;
  late final TextEditingController _institutionTextController;

  bool _isLoading = false;

  final List<String> _genderItems = ['Laki-laki', 'Perempuan'];
  String? _selectedGender;
  late DateTime _selectedDate;

  File? _profileImage;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Use selectedDate or now
      firstDate: DateTime(1925), // Earliest allowable date
      lastDate: DateTime.now(), // Latest allowable date is today
      helpText: 'Pilih Tanggal Lahir',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      builder: (context, child) { // Optional: Theme the date picker
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ), dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pilih dari Galeri'),
              onTap: () {
                _pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Ambil dari Kamera'),
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (_usernameTextController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username tidak boleh kosong!'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Aktifkan loading
    });

    try {
      await widget.onSave(
        _usernameTextController.text.trim(),
        _institutionTextController.text.trim(),
        '${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}',
        _selectedGender,
        _profileImage
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _usernameTextController = TextEditingController(text: widget.initialUsername);
    _institutionTextController = TextEditingController();
    _selectedDate = widget.initialDate ?? DateTime.now();
    if (widget.initialGender != null && _genderItems.contains(widget.initialGender)) {
      _selectedGender = widget.initialGender;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60.r,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!) as ImageProvider
                    : (widget.initialPhotoUrl.isNotEmpty
                    ? NetworkImage(widget.initialPhotoUrl)
                    : const AssetImage('images/user.png') as ImageProvider),
                backgroundColor: Colors.white,
              )
            ),
            SizedBox(height: 15.h),
            Center(
              child: GestureDetector(
                onTap: _showImageSourceDialog,
                child: Text(
                  'Ganti foto profil',
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue),
                ),
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Text('Username',
                  style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500
                  )),
            ),
            TextField(
              controller: _usernameTextController,
              style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
              ),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: const BorderSide(width: 1, color: Color(0xFFC6D8F3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: const BorderSide(width: 1, color: Color(0xFFC6D8F3)),
                ),
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                fillColor: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.h),
              child: Text('Institusi',
                  style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500
                  )),
            ),
            TextField(
              controller: _institutionTextController,
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
              ),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: const BorderSide(width: 1, color: Color(0xFFC6D8F3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: const BorderSide(width: 1, color: Color(0xFFC6D8F3)),
                ),
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                fillColor: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.h),
              child: Text('Gender',
                  style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500
                  )),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                dropdownStyleData: const DropdownStyleData(
                  decoration: BoxDecoration(
                    color: Colors.white, // <-- GANTI WARNA DI SINI
                  ),
                ),
                isExpanded: true,
                hint: Text(
                  'Pilih opsi',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: _genderItems
                    .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                ))
                    .toList(),
                value: _selectedGender,
                onChanged: (String? value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(
                      color: const Color(0xFFC6D8F3),
                    ),
                    color: Colors.white,
                  ),
                ),
                menuItemStyleData: MenuItemStyleData(

                  height: 40.h,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.h),
              child: Text('Tanggal lahir',
                  style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500
                  )),
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                height: 60.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                    color: const Color(0xFFC6D8F3),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'Pilih tanggal'
                      // Format the date nicely
                          : DateFormat('dd MMMM yyyy').format(_selectedDate!),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: _selectedDate == null
                            ? Theme.of(context).hintColor
                            : Colors.black,
                        fontWeight: _selectedDate == null
                            ? FontWeight.normal
                            : FontWeight.w500,
                      ),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.grey),
                  ],
                ),
              ),
            ),
            Center(
                child: Container(
                    width: double.infinity,
                    height: 60.h,
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSave,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            )
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text('Simpan',
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ))
                    )
                )
            ),
          ],
        )
    );
  }

}