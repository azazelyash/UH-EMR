import '../../../../../gen/assets.gen.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarButton extends StatelessWidget {
  const AvatarButton({
    super.key,
    this.selectAll = false,
    required this.clinicName,
    required this.onTap,
    this.logo,
  });

  final bool selectAll;
  final String clinicName;
  final VoidCallback onTap;
  final String? logo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: ConstantColors.kTileBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            child: Row(
              children: [
                (selectAll)
                    ? CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Assets.images.logo.image(),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: logo == null
                            ? null
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: CachedNetworkImage(
                                  imageUrl: logo!,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => const Icon(Icons.error_outline_outlined),
                                ),
                              ),
                      ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    clinicName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
