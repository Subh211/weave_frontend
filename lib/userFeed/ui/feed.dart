import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weave_frontend/optionScreen/ui/optionScreen.dart';
import 'package:weave_frontend/userProfile/ui/profile.dart';
import 'package:weave_frontend/userSinglePost/ui/singlePost.dart';

class Feed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  // Declare _selectedIndex as a member variable
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Posts(), // Index 0
    Profile(), // Index 1 - You can replace Placeholder() with the desired widget for index 1
    Posts(),
    Posts(), // Index 2 - You can replace Placeholder() with the desired widget for index 2
    Profile(), // Index 3 - You can replace Placeholder() with the desired widget for index 3
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to Page when index is 2 (plus button)
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Posts()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Weave',
        style: GoogleFonts.clickerScript(
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(165, 179, 158, 1),
          fontSize: AppBar().preferredSize.height,
        ),
      ),
      actions: [
        IconButton(
          icon: FaIcon(FontAwesomeIcons.bars),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => OptionScreen()));
          },
        ),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.bell),
          onPressed: () {},
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: _selectedIndex == 0 ? Colors.black : Colors.grey,
              ),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: _selectedIndex == 1 ? Colors.black : Colors.grey,
              ),
              onPressed: () => _onItemTapped(1),
            ),
            TextButton(
              onPressed: () {
                return _onItemTapped(2);
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFC3B0E7),
                padding: EdgeInsets.all(
                    15), // Reduce padding to make the button smaller
                shape:
                    CircleBorder(), // Use CircleBorder to create a circular shape
                shadowColor: Colors.black, // Shadow color
                elevation: 10, // Elevation
              ),
              child: SizedBox(
                width: 35, // Set a fixed width for the button
                height: 35, // Set a fixed height for the button
                child: Align(
                  alignment: Alignment.center,
                  child: FaIcon(
                    FontAwesomeIcons.plus,
                    color: Colors.purple,
                    size: 20, // Adjust icon size as needed
                  ),
                ),
              ),
            ),
            // The dummy child for spacing
            IconButton(
              icon: Icon(
                Icons.group,
                color: _selectedIndex == 2 ? Colors.black : Colors.grey,
              ),
              onPressed: () => _onItemTapped(3),
            ),
            IconButton(
              icon: CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    'https://res.cloudinary.com/dlramkpev/image/upload/v1717303554/lms/vnffvzde5cc3bgvqtar5.png'),
              ),
              onPressed: () => _onItemTapped(4),
            ),
          ],
        ),
      ),
    );
  }
}
