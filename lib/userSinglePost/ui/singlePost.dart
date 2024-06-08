import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


class Posts extends StatefulWidget{
  @override

  State<StatefulWidget> createState() {
    return _PostsState();
  }
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
          return Scaffold(
            body:  SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      //height: screenHeight*0.625,
                      width: screenWidth,
                      child: Column(
                        children: [
                           Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: screenWidth*0.025,
                                  ),
                                  Container(
                                    height: screenHeight*0.065,
                                    width: screenWidth*0.09,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage('assests/images/vk1.jpeg'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth*0.025,
                                  ),
                                  Text('displayName',style:
                                  GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600
                                      )
                                  ),)
                                ],
                              ),
                           Container(
                             height: screenHeight*0.50,
                              width: screenWidth,
                              child: Image.asset('assests/images/vk2.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          Container(
                            height: screenHeight*0.06,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              SizedBox(
                              width: screenWidth*0.01,
                            ),
                                IconButton(
                                    onPressed: (){},
                                    icon: FaIcon(FontAwesomeIcons.heart)),
                                IconButton(
                                    onPressed: () {},
                                    icon: FaIcon(FontAwesomeIcons.comments))
                                          ]
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenWidth*0.04,
                              ),
                              Text('Liked by 15 others',style: GoogleFonts.lora(
                                textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              ),
                            ],
                          ),
                            Row(
                              children: [
                                SizedBox(
                                  width: screenWidth*0.04,
                                ),
                                Text('displayName',style:
                                GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w800
                                    )
                                ),),
                                SizedBox(
                                  width: screenWidth*0.02,
                                ),
                                Flexible(
                                  child: Text('caption',style: GoogleFonts.lora(
                                      textStyle: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenWidth*0.04,
                              ),
                              Text('All comments',style:
                              GoogleFonts.lora(
                                  textStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w500
                                  )
                              ),),
                            ],
                          )
                        ],
                      ),
                    ),
                  Container(
                    //height: screenHeight*0.625,
                    width: screenWidth,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: screenWidth*0.025,
                            ),
                            Container(
                              height: screenHeight*0.065,
                              width: screenWidth*0.09,
                              child: CircleAvatar(
                                backgroundImage: AssetImage('assests/images/vk1.jpeg'),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth*0.025,
                            ),
                            Text('displayName',style:
                            GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600
                                )
                            ),)
                          ],
                        ),
                        Container(
                          height: screenHeight*0.50,
                          width: screenWidth,
                          child: Image.asset('assests/images/vk2.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: screenHeight*0.06,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: screenWidth*0.01,
                                ),
                                IconButton(
                                    onPressed: (){},
                                    icon: FaIcon(FontAwesomeIcons.heart)),
                                IconButton(
                                    onPressed: () {},
                                    icon: FaIcon(FontAwesomeIcons.comments))
                              ]
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth*0.04,
                            ),
                            Text('Liked by 15 others',style: GoogleFonts.lora(
                              textStyle: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth*0.04,
                            ),
                            Text('displayName',style:
                            GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w800
                                )
                            ),),
                            SizedBox(
                              width: screenWidth*0.02,
                            ),
                            Flexible(
                              child: Text('caption',style: GoogleFonts.lora(
                                textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth*0.04,
                            ),
                            Text('All comments',style:
                            GoogleFonts.lora(
                                textStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w500
                                )
                            ),),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    //height: screenHeight*0.625,
                    width: screenWidth,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: screenWidth*0.025,
                            ),
                            Container(
                              height: screenHeight*0.065,
                              width: screenWidth*0.09,
                              child: CircleAvatar(
                                backgroundImage: AssetImage('assests/images/vk1.jpeg'),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth*0.025,
                            ),
                            Text('displayName',style:
                            GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600
                                )
                            ),)
                          ],
                        ),
                        Container(
                          height: screenHeight*0.50,
                          width: screenWidth,
                          child: Image.asset('assests/images/vk2.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: screenHeight*0.06,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: screenWidth*0.01,
                                ),
                                IconButton(
                                    onPressed: (){},
                                    icon: FaIcon(FontAwesomeIcons.heart)),
                                IconButton(
                                    onPressed: () {},
                                    icon: FaIcon(FontAwesomeIcons.comments))
                              ]
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth*0.04,
                            ),
                            Text('Liked by 15 others',style: GoogleFonts.lora(
                              textStyle: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth*0.04,
                            ),
                            Text('displayName',style:
                            GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w800
                                )
                            ),),
                            SizedBox(
                              width: screenWidth*0.02,
                            ),
                            Flexible(
                              child: Text('caption',style: GoogleFonts.lora(
                                textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth*0.04,
                            ),
                            Text('All comments',style:
                            GoogleFonts.lora(
                                textStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w500
                                )
                            ),),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    //height: screenHeight*0.625,
                    width: screenWidth,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: screenWidth*0.025,
                            ),
                            Container(
                              height: screenHeight*0.065,
                              width: screenWidth*0.09,
                              child: CircleAvatar(
                                backgroundImage: AssetImage('assests/images/vk1.jpeg'),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth*0.025,
                            ),
                            Text('displayName',style:
                            GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600
                                )
                            ),)
                          ],
                        ),
                        Container(
                          height: screenHeight*0.50,
                          width: screenWidth,
                          child: Image.asset('assests/images/vk2.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: screenHeight*0.06,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: screenWidth*0.01,
                                ),
                                IconButton(
                                    onPressed: (){},
                                    icon: FaIcon(FontAwesomeIcons.heart)),
                                IconButton(
                                    onPressed: () {},
                                    icon: FaIcon(FontAwesomeIcons.comments))
                              ]
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth*0.04,
                            ),
                            Text('Liked by 15 others',style: GoogleFonts.lora(
                              textStyle: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth*0.04,
                            ),
                            Text('displayName',style:
                            GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w800
                                )
                            ),),
                            SizedBox(
                              width: screenWidth*0.02,
                            ),
                            Flexible(
                              child: Text('caption',style: GoogleFonts.lora(
                                textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth*0.04,
                            ),
                            Text('All comments',style:
                            GoogleFonts.lora(
                                textStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w500
                                )
                            ),),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

}