import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getNameFromPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('name'); // Assuming the key for the name is 'name'
}

class TColor {
  static const Color primaryColor1 = Color(0xad0cc0c3);
  static const Color primaryColor2 = Color(0xcff3c51d);
  static const Color primaryColor3 = Color(0xcffcf0db);

  static const Color secondaryColor1 = Color(0xcf0f735e);
  static const Color secondaryColor2 = Color(0xcff39908);

  static const Color black = Color(0xff1D1617);
  static const Color gray = Color(0xff786F72);
  static const Color white = Colors.white;
  static const Color lightGray = Color(0xffF7F8F8);
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String titleImage;
  final Widget leading;
  final List<Widget> actions;
  final Color startColor;
  final Color endColor;
  final double borderRadius; // New property for border radius

  const CustomAppBar({
    Key? key,
    required this.height,
    required this.titleImage,
    this.leading = const SizedBox(),
    this.actions = const <Widget>[],
    this.startColor = TColor.primaryColor3,
    this.endColor = TColor.primaryColor3,
    required this.borderRadius,
    required Color backgroundColor, // Initialize border radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getNameFromPrefs(), // Fetch the name asynchronously
      builder: (context, snapshot) {
        String name = snapshot.data ?? 'User'; // Default to 'User' if name not found
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
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
                      height: height * 0.6,
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "  Welcome $name!", // Display the retrieved name
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 23,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

