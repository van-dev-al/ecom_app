import 'package:ecom_app/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

import '../../../utils/constaints/colors.dart';
import '../../../utils/helpers/helper_funtions.dart';

class ETabBar extends StatelessWidget implements PreferredSizeWidget {
  const ETabBar({
    super.key,
    required this.tabs,
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);
    return Material(
      color: dark ? EColors.dark : EColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: false,
        indicatorColor: EColors.primary,
        indicatorWeight: 3.0,
        unselectedLabelColor: EColors.darkGrey,
        labelColor: dark ? EColors.white : EColors.primary,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(EDeviceUtils.getAppBarHeight());
}
