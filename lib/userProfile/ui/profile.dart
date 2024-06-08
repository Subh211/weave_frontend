import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weave_frontend/userSinglePost/ui/singlePost.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  int selectedIndex = 0; // State to track the selected icon index

  @override
  Widget build(BuildContext context) {
    var arrColors = [
      Colors.greenAccent,
      Colors.purpleAccent,
      Colors.amberAccent,
      Colors.cyan,
      Colors.brown,
      Colors.deepPurple,
      Colors.lime,
      Colors.pink,
      Colors.amber,
      Colors.purple,
      Colors.orange,
      Colors.greenAccent,
      Colors.grey,
      Colors.red,
      Colors.yellow,
      Colors.blue,
      Colors.black,
      Colors.brown
    ];

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenHeight * 0.03;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: screenHeight * 0.16,
                  width: screenWidth * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(12.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assests/images/vk2.jpeg'),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '100  \n Posts ',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Text(
                      '100  \n followings ',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Text(
                      '100  \n followers ',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('subh'),
                  Text('Subhadeep Das'),
                  Text('here is my bio'),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: CustomTextButton(
                onPressed: () {},
                showPencilIcon: true,
                showBorder: false,
                horizontalPadding: screenWidth * 0.26,
                buttonText: 'Edit Profile',
                screenHeight: screenHeight,
                buttonHeight: screenHeight * 0.06,
                fontSize: screenHeight * 0.022,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.tableCells,
                      size: iconSize,
                      color: selectedIndex == 0 ? Colors.black : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.squarePlus,
                      size: iconSize,
                      color: selectedIndex == 1 ? Colors.black : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.bookmark,
                      size: iconSize,
                      color: selectedIndex == 2 ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Posts()),
                    );
                  },
                  child: Container(
                    color: arrColors[index],
                  ),
                );
              },
              itemCount: arrColors.length,
            ),
          ],
        ),
      ),
    );
  }
}
