import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Eachlike extends StatelessWidget {
  const Eachlike({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: BoxConstraints(
          minHeight: screenHeight * 0.06,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assests/images/vk2.jpeg'),
            ),
            SizedBox(width: 8.0), // Adding some space between avatar and text
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(3, 11, 0, 0),
              child: Text(
                'displayName',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
