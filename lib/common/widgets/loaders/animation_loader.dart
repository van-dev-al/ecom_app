import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';

class EAnimationLoaderWidget extends StatelessWidget {
  const EAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animaton,
    this.showaction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animaton;
  final bool showaction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            animaton,
            width: MediaQuery.of(context).size.width * 0.6,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: ESizes.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: ESizes.defaultSpace),
          showaction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                      onPressed: onActionPressed,
                      child: Text(
                        actionText!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: EColors.light),
                      )),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
