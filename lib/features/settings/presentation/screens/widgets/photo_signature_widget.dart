import '../../../../user/presentation/providers/user_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'browse_image_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhotoSignatureWidget extends StatelessWidget {
  const PhotoSignatureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //TODO: Finish Edit Photo and Signature
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: Colors.grey.shade400),
      ),
      child: Consumer<UserProvider>(
        child: Text(
          "Photos & Signatures",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        builder: (context, userProvider, child) {
          final user = userProvider.user;
          final docPhoto = user.profile?.docPhoto;
          final signaturePhoto = user.profile?.docSign;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              child!,
              SizedBox(height: 12.h),
              BrowseImageTile(
                title: "Photo",
                imageUrl: docPhoto,
              ),
              BrowseImageTile(
                title: "Signature",
                imageUrl: signaturePhoto,
              ),
              const BrowseImageTile(title: "Logo"),
            ],
          );
        },
      ),
    );
  }
}
