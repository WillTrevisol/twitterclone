import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import '../../data/constants/constants.dart';

class DefaultAppBar {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        height: 30,
        colorFilter: const ColorFilter.mode(Pallete.blueColor, BlendMode.srcIn),
      ),
      centerTitle: true,
    );
  }
}