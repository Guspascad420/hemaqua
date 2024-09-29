import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  final TextEditingController _messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF6FF),
        centerTitle: true,
        title: Text('Help Center',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                controller: _messageTextController,
                style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(width: 1, color: Color(0xFFEDF1F3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(width: 1, color: Color(0xFFEDF1F3)),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.only(left: 20, top: 10),
                    fillColor: Colors.white,
                    hintText: 'Write your message',
                    hintStyle: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 20
                    )
                ),
              )
            ),
            Container(
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 40),
                child: ElevatedButton(
                    onPressed: (){
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (context) => const HomePage()),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        )
                    ),
                    child: Text('Send Message',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ))
                )
            )
          ],
        ),
      ),
    );
  }

}