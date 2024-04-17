import 'package:aasa_emr/gen/assets.gen.dart';

import 'package:flutter/material.dart';

class UniversalLoadingWidget extends StatelessWidget {
  const UniversalLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.2),
      child: const Center(
        child: UniversalLoadingGif(),
      ),
    );
  }
}

class UniversalLoadingGif extends StatelessWidget {
  const UniversalLoadingGif({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.gif.loadingAnimation.path,
      height: 100,
    );
  }
}
