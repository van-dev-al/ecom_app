import 'package:ecom_app/common/widgets/text/trademark_title_with_no_icon.dart';
import 'package:ecom_app/features/ecom/models/trademark_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/constaints/enums.dart';
import '../../../utils/constaints/sizes.dart';
import '../custom_shapes/containers/rouded_container.dart';
import '../images/circular_image.dart';

class ETrademarkCard extends StatelessWidget {
  const ETrademarkCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.trademark,
  });

  final TrademarkModel trademark;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ERoundedContainer(
        padding: const EdgeInsets.all(ESizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            // icon trademark ------------------------------------------------------------------------------------------------
            Flexible(
              child: ECircularImage(
                width: 36,
                height: 36,
                borderRadius: 10,
                padding: ESizes.sm / 2,
                image: trademark.image,
                isNetworkImage: true,
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(width: ESizes.spaceBtwItems / 2),

            // name trademark------------------------------------------------------------------------------------------------
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ETrademarkTitleWithNoIcon(
                    title: trademark.source,
                    trademarkTextSizes: TextSizes.large,
                  ),
                  const SizedBox(height: ESizes.spaceBtwItems / 4),
                  Text(
                    '${trademark.productCount ?? 0} products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
