import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';
import 'package:aasa_emr/utils/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RxInvoiceHeader extends StatelessWidget {
  const RxInvoiceHeader({
    super.key,
    this.logoUrl,
  });

  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            (context.read<UserProvider>().user.settings!.rxFormat!.rxHeaderInfo!.logo!)
                ? (logoUrl != null)
                    ? Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CachedNetworkImage(
                            height: 48.sp,
                            fit: BoxFit.cover,
                            imageUrl: logoUrl!,
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: Container(
                          height: 48.h,
                          width: 48.w,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: ConstantColors.kHeadlingColor),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.image_outlined,
                              color: ConstantColors.kHeadlingColor,
                              size: 20,
                            ),
                          ),
                        ),
                      )
                : const SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dr. ${context.read<UserProvider>().user.profile?.name}'s Practice",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 4.h),
                Text(
                  context.read<UserProvider>().user.profile?.specialization ?? '-',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            (context.read<UserProvider>().user.settings!.rxFormat!.rxHeaderInfo!.contactNo!)
                ? Row(
                    children: <Widget>[
                      const Icon(
                        Icons.call_outlined,
                        size: 18,
                      ),
                      SizedBox(width: 4.w),
                      Text("${context.read<UserProvider>().user.profile?.phone?.countryCode ?? ""} ${context.read<UserProvider>().user.profile?.phone?.phoneNumber ?? ""}"),
                      SizedBox(width: 12.w),
                    ],
                  )
                : const SizedBox(),
            (context.read<UserProvider>().user.settings!.rxFormat!.rxHeaderInfo!.emailId!)
                ? Row(
                    children: <Widget>[
                      const Icon(
                        Icons.email_outlined,
                        size: 18,
                      ),
                      SizedBox(width: 4.w),
                      Text(context.read<UserProvider>().user.profile?.email ?? ""),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
        (context.read<UserProvider>().user.settings!.rxFormat!.rxHeaderInfo!.clinicAddress!)
            ? Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                    ),
                    SizedBox(width: 4.w),
                    Text(context.read<UserProvider>().user.profile?.address ?? ""),
                  ],
                ),
              )
            : const SizedBox(),
        SizedBox(height: 12.h),
        const DottedDashedLine(
          height: 1,
          width: double.infinity,
          axis: Axis.horizontal,
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
