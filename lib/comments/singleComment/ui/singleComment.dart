import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Eachcomment extends StatelessWidget {
  const Eachcomment({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: BoxConstraints(
          minHeight: screenHeight * 0.075,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/vk2.jpeg'),
            ),
            SizedBox(width: 8.0), // Adding some space between avatar and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'displayName',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0), // Adding some space between displayName and comment
                  Text(
                    'comment',
                    style: GoogleFonts.lora(
                      textStyle: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    maxLines: null, // Allows text to wrap into multiple lines
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
