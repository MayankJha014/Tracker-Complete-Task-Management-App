import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tracker/model/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.95,
      height: 80,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        border: Border.all(
          color: Colors.blue[700]!.withOpacity(0.25),
        ),
        color: Colors.transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   task.title,
                //   style: GoogleFonts.poppins(
                //     fontSize: 13,
                //     color: Colors.grey,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    task.title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Text(
                //   '${TimeOfDay(
                //     hour: task.startT.hour as TimeOfDay,
                //     minute: task.startT.minute as TimeOfDay,
                //   )} min ago',
                //   style: GoogleFonts.poppins(
                //     fontSize: 13,
                //     color: Colors.grey,
                //   ),
                // ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 100,
          //   child: CircularPercentIndicator(
          //     radius: 28.0,
          //     lineWidth: 5.0,
          //     percent: completion,
          //     center: Text(
          //       "${completion * 100}%",
          //       style: GoogleFonts.poppins(
          //         fontSize: 12,
          //       ),
          //     ),
          //     progressColor: Colors.blue,
          //   ),
          // )
        ],
      ),
    );
  }
}
