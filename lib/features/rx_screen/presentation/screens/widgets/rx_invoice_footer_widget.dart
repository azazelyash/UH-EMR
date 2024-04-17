import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RxInvoiceFooter extends StatelessWidget {
  const RxInvoiceFooter({
    super.key,
    // required this.rxModel,
  });

  // final RxModel rxModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          context.read<UserProvider>().user.settings?.rxFormat?.footerInfo?.message ?? "Get Well Soon",
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        (context.read<UserProvider>().user.profile!.docSign != null)
            ? ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  height: 48.sp,
                  fit: BoxFit.cover,
                  imageUrl: context.read<UserProvider>().user.profile!.docSign!,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
