import 'package:e_quranclinic/main.dart';
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
  final double bottomBorderRadius; // New property for bottom border radius

  const CustomAppBar({
    Key? key, required this.height, required this.titleImage, required this.leading, required this.actions, required this.startColor, required this.endColor, required this.bottomBorderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getNameFromPrefs(), // Fetch the name asynchronously
      builder: (context, snapshot) {
        String name = snapshot.data ?? 'User'; // Default to 'User' if name not found
        return ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bottomBorderRadius),
            bottomRight: Radius.circular(bottomBorderRadius),
          ),
          child: Container(
            child: AppBar(
              leading: leading,
              actions: actions,
              flexibleSpace: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      titleImage,
                      fit: BoxFit.contain,
                      height:100,
                    ),
                    SizedBox(height: 50.0),
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
              elevation: 8, // Add elevation for shadow
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
