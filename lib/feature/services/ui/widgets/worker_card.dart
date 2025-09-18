import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/feature/services/ui/widgets/worker_info.dart';
import 'package:shatably_app/feature/workers/ui/screens/worker_screen.dart';

class WorkerCard extends StatelessWidget {
  final WorkerInfo worker;
  final String jobTitle;

  const WorkerCard({super.key, required this.worker, required this.jobTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder:
                (context) => WorkerScreen(
                  workerName: worker.name,
                  workerProf: jobTitle,
                  workerImage: worker.imagePath,
                ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        decoration: BoxDecoration(
          color: const Color(0XFFF7FCFB),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: Image.asset(
                    worker.imagePath,
                    width: 48.w,
                    height: 48.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        worker.name,
                        style: TextStyles.styleRegular(
                          context,
                          fontSize: 16.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Icon(
                              index < worker.rating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: const Color(0xFFDDA853),
                              size: 16.h,
                            );
                          }),
                          SizedBox(width: 4.w),
                          Text(
                            "(${worker.reviewCount})",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Book Now",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFDDA853),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
