// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/core/contants/constants.dart';

class ChipsTask extends StatefulWidget {
  int activeChips;
  ChipsTask({
    Key? key,
    required this.activeChips,
  }) : super(key: key);

  @override
  State<ChipsTask> createState() => _ChipsTaskState();
}

class _ChipsTaskState extends State<ChipsTask> {
  List chips = [
    'Recent',
    'Completed',
    'All',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: ListView.builder(
        itemCount: chips.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                widget.activeChips = 0;
                widget.activeChips = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                right: 5.0,
                top: 25,
                left: 5,
                bottom: 10,
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white24,
                ),
                child: Text(
                  chips[index],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: widget.activeChips == index
                        ? Colors.white
                        : Pallet.greyColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
