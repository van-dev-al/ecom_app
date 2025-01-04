import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/formatters/formatter.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsSpecScreen extends StatelessWidget {
  const ProductDetailsSpecScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final formatPrice = EFormatter.formatCurrency(product.price);
    final formatOriginalPrice =
        EFormatter.formatCurrency(product.originalPrice);

    return Scaffold(
      appBar: EAppBar(
        title: Text(
          'Technical Specifications',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: ESizes.spaceBtwItems),

              // Tên sản phẩm
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: ESizes.spaceBtwItems / 2),

              // Giá sản phẩm
              Row(
                children: [
                  Text(
                    'Giá hiện tại: $formatPrice',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: ESizes.spaceBtwItems / 2),
                  Text(
                    '-${product.discount}%',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ESizes.spaceBtwItems / 2),
              Text(
                'Giá gốc: $formatOriginalPrice',
                style: const TextStyle(
                  fontSize: 14,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(height: ESizes.spaceBtwItems),

              // Đánh giá
              Row(
                children: [
                  const Icon(Iconsax.star5, color: Colors.amber, size: 24),
                  const SizedBox(width: 4),
                  Text(
                    '${product.ratingAverage} / 5',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: ESizes.spaceBtwItems),
                  Text(
                    '(${product.reviewCount} đánh giá)',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: ESizes.spaceBtwItems),

              // Thông số kỹ thuật
              const Text(
                'Thông số kỹ thuật',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: ESizes.spaceBtwItems / 2),
              buildSpecificationsTable(product),

              const SizedBox(height: ESizes.spaceBtwItems),

              // Nút điều hướng đến nơi bán
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final uri = Uri.parse(product.urls);
                    launchUrl(uri, mode: LaunchMode.externalApplication);
                  },
                  child: const Text('Check out'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSpecificationsTable(ProductModel product) {
    final specifications = {
      'Pin': product.battery ?? 'N/A',
      'Bluetooth': product.bluetooth ?? 'N/A',
      'Camera chính': product.cameraPrimary ?? 'N/A',
      'Camera phụ': product.cameraSecondary ?? 'N/A',
      'Chip xử lý': product.chipSet ?? 'N/A',
      'CPU': product.cpu ?? 'N/A',
      'GPU': product.gpu ?? 'N/A',
      'RAM': product.ram ?? 'N/A',
      'ROM': product.rom ?? 'N/A',
      'Kích thước màn hình': product.screenSize ?? 'N/A',
      'Loại màn hình': product.displayType ?? 'N/A',
      'NFC': product.nfc ?? 'N/A',
      'GPS': product.gps ?? 'N/A',
      'Internet': product.internet ?? 'N/A',
      'Jack tai nghe': product.jack35mm ?? 'N/A',
      'Cổng sạc': product.chargingPort ?? 'N/A',
      'Trọng lượng': product.weight ?? 'N/A',
      'WiFi': product.wifi ?? 'N/A',
    };

    return Builder(builder: (context) {
      return Table(
        columnWidths: const {
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
        },
        border: TableBorder.all(color: Colors.grey, width: 0.5),
        children: specifications.entries.map((entry) {
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(ESizes.spaceBtwItems / 2),
                child: Text(
                  entry.key,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(ESizes.spaceBtwItems / 2),
                child: Text(
                  entry.value,
                  style: TextStyle(
                      color: EHelperFuntions.isDarkMode(context)
                          ? EColors.light
                          : EColors.dark),
                ),
              ),
            ],
          );
        }).toList(),
      );
    });
  }
}
