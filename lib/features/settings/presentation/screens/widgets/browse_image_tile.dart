import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrowseImageTile extends StatelessWidget {
  const BrowseImageTile({
    super.key,
    required this.title,
    this.imageUrl,
    this.pickedImage,
    this.onBrowsePressed,
  });

  final String title;
  final String? imageUrl;
  final File? pickedImage;
  final void Function()? onBrowsePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: pickedImage != null
                      ? Image.file(
                          pickedImage!,
                          fit: BoxFit.cover,
                        )
                      : imageUrl == null
                          ? null
                          : CachedNetworkImage(
                              imageUrl: imageUrl!,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error_outline,
                                color: Colors.amber,
                              ),
                            ),
                ),
              ),
              SizedBox(width: 12.w),
              ElevatedButton(
                onPressed: onBrowsePressed,
                child: const Text("Browse"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
