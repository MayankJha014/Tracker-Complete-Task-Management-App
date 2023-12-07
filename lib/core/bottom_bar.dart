import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/core/contants/constants.dart';
import 'package:tracker/features/chat/screen/chat_screen.dart';
import 'package:tracker/features/create/screen/project_create.dart';
import 'package:tracker/features/create/screen/task_create.dart';
import 'package:tracker/features/home/screen/home_screen.dart';
import 'package:tracker/features/project/screen/project_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  bottomBar() {
    showModalBottomSheet(
        backgroundColor: Pallet.darkThemeColor,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        context: context,
        builder: (context) {
          return SizedBox(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35.0,
                vertical: 20,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const TaskCreate())),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xff12141C),
                          )),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/edit.png',
                            scale: 1.1,
                            filterQuality: FilterQuality.high,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Create Task',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const ProjectCreation())),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xff12141C),
                          )),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/create.png',
                            scale: 1.1,
                            filterQuality: FilterQuality.high,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Create Project',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xff12141C),
                        )),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/team.png',
                          scale: 1.1,
                          filterQuality: FilterQuality.high,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Create Team',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                        backgroundColor: Pallet.darkButtonColor,
                        radius: 22,
                        child: Image.asset(
                          'assets/icons/close.png',
                          filterQuality: FilterQuality.high,
                          scale: 1.2,
                        )),
                  )
                ],
              ),
            ),
          );
        });
  }

  List<Widget> pages = [
    const HomeScreen(),
    const ProjectScreen(),
    const ChatScreen(),
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.home,
          Icons.folder_open_outlined,
          Icons.chat_outlined,
          Icons.person,
        ],
        activeIndex: _page,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        backgroundColor: const Color.fromARGB(255, 18, 22, 41),
        rightCornerRadius: 32,
        onTap: onPageChanged,
        activeColor: Pallet.darkButtonColor,
      ),
      floatingActionButton: GestureDetector(
        onTap: () => bottomBar(),
        child: const CircleAvatar(
          radius: 25,
          backgroundColor: Pallet.darkButtonColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
