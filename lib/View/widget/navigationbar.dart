// import 'package:flutter/material.dart';
//
// import 'homepage_learner.dart';
//
//
// class MainTabView extends StatefulWidget {
//   const MainTabView({Key? key}) : super(key: key);
//
//   @override
//   State<MainTabView> createState() => _MainTabViewState();
// }
//
// class _MainTabViewState extends State<MainTabView> {
//   int _selectTab = 0;
//   late Widget _currentTab;
//
//   @override
//   void initState() {
//     _currentTab = HomePage(phone: '', name: '', id:0 );
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: _currentTab,
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: SizedBox(
//         width: 70,
//         height: 70,
//         child: InkWell(
//           onTap: () {},
//           child: Container(
//             width: 65,
//             height: 65,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   colors: TColor.primaryG),
//               borderRadius: BorderRadius.circular(35),
//               boxShadow: const [
//                 BoxShadow(color: Colors.black12, blurRadius: 2),
//               ],
//             ),
//             child: Icon(
//               Icons.search,
//               color: TColor.white,
//               size: 35,
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Container(
//           decoration: BoxDecoration(
//             color: TColor.white,
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 2,
//                 offset: Offset(0, -2),
//               ),
//             ],
//           ),
//           height: kToolbarHeight,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TabButton(
//                 icon: "assets/img/home_tab.png",
//                 selectIcon: "assets/img/home_tab_select.png",
//                 isActive: _selectTab == 0,
//                 onTap: () {
//                   setState(() {
//                     _selectTab = 0;
//                     _currentTab = HomeView();
//                   });
//                 },
//               ),
//               TabButton(
//                 icon: "assets/img/activity_tab.png",
//                 selectIcon: "assets/img/activity_tab_select.png",
//                 isActive: _selectTab == 1,
//                 onTap: () {
//                   setState(() {
//                     _selectTab = 1;
//                     _currentTab = const SelectView();
//                   });
//                 },
//               ),
//               const SizedBox(width: 40),
//               TabButton(
//                 icon: "assets/img/camera_tab.png",
//                 selectIcon: "assets/img/camera_tab_select.png",
//                 isActive: _selectTab == 2,
//                 onTap: () {
//                   setState(() {
//                     _selectTab = 2;
//                     _currentTab = const PhotoProgressView();
//                   });
//                 },
//               ),
//               TabButton(
//                 icon: "assets/img/user_text.png",
//                 selectIcon: "assets/img/profile_tab_select.png",
//                 isActive: _selectTab == 3,
//                 onTap: () {
//                   setState(() {
//                     _selectTab = 3;
//                     _currentTab = ProfileView();
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
