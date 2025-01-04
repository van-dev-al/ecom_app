import 'package:ecom_app/common/widgets/custom_shapes/containers/rouded_container.dart';
import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/features/ecom/models/news_model.dart';
import 'package:ecom_app/features/ecom/screens/new/widgets/item_image_author_and_description.dart';
import 'package:ecom_app/features/ecom/screens/new/widgets/item_qc_and_share_button.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ENewItem extends StatelessWidget {
  const ENewItem({
    super.key,
    required this.news,
  });

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(ESizes.productImageRadius),
        onTap: () {
          final uri = Uri.parse(news.url);
          launchUrl(uri, mode: LaunchMode.externalApplication);
        },
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            border: Border.all(
                color: dark
                    ? EColors.light.withOpacity(0.6)
                    : EColors.dark.withOpacity(0.6)),
            borderRadius: BorderRadius.circular(ESizes.productImageRadius),
            color: dark ? EColors.black : EColors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: ERoundedContainer(
                  width: EHelperFuntions.screenWidth(),
                  padding: const EdgeInsets.only(
                      left: ESizes.md, right: ESizes.sm, bottom: ESizes.sm),
                  backgroundColor:
                      dark ? EColors.dark.withOpacity(0.6) : EColors.light,
                  child: Column(
                    children: [
                      // new qc and share button
                      EItemNewQcAndShareButton(onPressed: () async {
                        await _copyUrlToClipboard(context);
                      }),
                      // image, author and description
                      EItemImageAuthorAndDescription(
                        author: news.author,
                        description: news.description,
                        imageNew: news.imageUrl,
                        title: news.title,
                      ),
                      const SizedBox(height: ESizes.spaceBtwItems),
                      // publised
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(news.published),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _copyUrlToClipboard(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: news.url));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        ELoader.successSnackBar(
            title: 'Copied URL successfully!',
            message: 'Share it to be everyone ^^.'),
      );
    }
  }
}
