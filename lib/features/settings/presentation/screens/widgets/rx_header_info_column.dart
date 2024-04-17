import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../user/presentation/providers/user_provider.dart';
import '../../providers/header_info_provider.dart';
import 'rx_header_info_tile.dart';

class RxHeaderInfoColumn extends StatelessWidget {
  const RxHeaderInfoColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: Colors.grey.shade400),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Rx Header Info",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              // ElevatedButton(
              //   onPressed: () {},
              //   style: ElevatedButton.styleFrom(backgroundColor: ConstantColors.kSecondaryColor),
              //   child: const Text("Add"),
              // ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    "Field",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Show in Rx",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
          Consumer2<UserProvider, HeaderInfoProvider>(builder: (context, userProvider, headerInfoProvider, child) {
            return ListView.builder(
              itemCount: headerInfoProvider.allHeaderInfo.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return RxHeaderInfoTile(
                    vitalName: headerInfoProvider.allHeaderInfo[index],
                    isCheckBoxSelected:
                        headerInfoProvider.selectedHeaderInfo.contains(headerInfoProvider.allHeaderInfo[index]),
                    onCheckboxSelected: (value) {
                      headerInfoProvider.onChanged(value, headerInfoProvider.allHeaderInfo[index]);
                    });
              },
            );
          }),
        ],
      ),
    );
  }
}
