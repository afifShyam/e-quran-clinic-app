import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String titleImage;
  final Widget leading;
  final List<Widget> actions;
  final Color startColor;
  final Color endColor;

  const CustomAppBar({
    Key? key,
    required this.height,
    required this.titleImage,
    this.leading = const SizedBox(),
    this.actions = const <Widget>[],
    this.startColor = Colors.white10, // Default start color for the gradient
    this.endColor = Colors.tealAccent, required Color backgroundColor, // Default end color for the gradient
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: AppBar(
        leading: leading,
        actions: actions,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [startColor, endColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                titleImage,
                fit: BoxFit.contain,
                height: height * 0.6, // Adjust the height as needed
              ),
              SizedBox(height: 8.0), // Add spacing between image and text
              Row(
                //mainAxisAlignment: MainAxisAlignment.center, // Center the row content
                children: [
                  Text(
                    "  Welcome Atiqa!",
                    style: GoogleFonts.roboto(
                      textStyle:  TextStyle(
                        fontSize: 23,
                        color: Colors.teal[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0), // Add spacing between text and icon
                  Icon(
                    Icons.emoji_people_sharp,
                    size: 24,
                    color: Colors.teal,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}