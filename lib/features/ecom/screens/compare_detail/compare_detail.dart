import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class CompareDetailScreen extends StatelessWidget {
  const CompareDetailScreen(
      {super.key, required this.product1, required this.product2});

  final ProductModel product1;
  final ProductModel product2;

  @override
  Widget build(BuildContext context) {
    final formatPrice1 = EFormatter.formatCurrency(product1.price);
    final formatPrice2 = EFormatter.formatCurrency(product2.price);

    final formatPriceButton1 = EFormatter.formatCurrency(product1.price);
    final formatPriceButton2 = EFormatter.formatCurrency(product2.price);

    final priceColor1 =
        product1.price < product2.price ? Colors.green[700] : Colors.blue[900];
    final priceColor2 =
        product2.price < product1.price ? Colors.green[700] : Colors.blue[900];

    bool productTextSize1 = product1.price > product2.price;
    bool productTextSize2 = product2.price > product1.price;

    return Scaffold(
      appBar: EAppBar(
        showBackArrow: true,
        title: Text(
          'Product specifications',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: ESizes.sm, right: ESizes.sm, bottom: ESizes.sm),
          child: Column(
            children: [
              const SizedBox(height: ESizes.spaceBtwItems),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                },
                border: TableBorder.all(color: Colors.grey, width: 0.5),
                children: [
                  _buildTableRow('Tên', product1.name, product2.name),
                  _buildTableRow('Hãng', product1.brand, product2.brand),
                  _buildTableRow('Model', product1.model.toString(),
                      product2.model.toString()),
                  _buildTableRow('Giá hiện tại', formatPrice1, formatPrice2),
                  _buildTableRow(
                      'Giá gốc',
                      EFormatter.formatCurrency(product1.originalPrice),
                      EFormatter.formatCurrency(product2.originalPrice)),
                  _buildTableRow('Discount', '${product1.discount}%',
                      '${product2.discount}%'),
                  _buildTableRow('Đánh giá', '${product1.ratingAverage}',
                      '${product2.ratingAverage}'),
                  _buildTableRow('Reviews', '${product1.reviewCount}',
                      '${product2.reviewCount}'),
                  _buildTableRow(
                      'CPU', product1.cpu ?? 'N/A', product2.cpu ?? 'N/A'),
                  _buildTableRow(
                      'GPU', product1.gpu ?? 'N/A', product2.gpu ?? 'N/A'),
                  _buildTableRow(
                      'RAM', product1.ram ?? 'N/A', product2.ram ?? 'N/A'),
                  _buildTableRow(
                      'ROM', product1.rom ?? 'N/A', product2.rom ?? 'N/A'),
                  _buildTableRow('Pin', product1.battery ?? 'N/A',
                      product2.battery ?? 'N/A'),
                  _buildTableRow('Chip set', product1.chipSet ?? 'N/A',
                      product2.chipSet ?? 'N/A'),
                  _buildTableRow(
                      'Camera chính',
                      product1.cameraPrimary ?? 'N/A',
                      product2.cameraPrimary ?? 'N/A'),
                  _buildTableRow(
                      'Camera phụ',
                      product1.cameraSecondary ?? 'N/A',
                      product2.cameraSecondary ?? 'N/A'),
                  _buildTableRow('Quay phim', product1.cameraVideo ?? 'N/A',
                      product2.cameraVideo ?? 'N/A'),
                  _buildTableRow('Loại màn hình', product1.displayType ?? 'N/A',
                      product2.displayType ?? 'N/A'),
                  _buildTableRow(
                      'Kích thước màn hình',
                      product1.screenSize ?? 'N/A',
                      product2.screenSize ?? 'N/A'),
                  _buildTableRow('Loại Sim', product1.simType ?? 'N/A',
                      product2.simType ?? 'N/A'),
                  _buildTableRow('Internet', product1.internet ?? 'N/A',
                      product2.internet ?? 'N/A'),
                  _buildTableRow(
                      'Wifi', product1.wifi ?? 'N/A', product2.wifi ?? 'N/A'),
                  _buildTableRow('Cổng sạc', product1.chargingPort ?? 'N/A',
                      product2.chargingPort ?? 'N/A'),
                  _buildTableRow('Jack tai nghe', product1.jack35mm ?? 'N/A',
                      product2.jack35mm ?? 'N/A'),
                  _buildTableRow('Nguồn', product1.trademarkModel!.source,
                      product2.trademarkModel!.source),
                  _buildTableRow('Trọng lượng', product1.weight ?? 'N/A',
                      product2.weight ?? 'N/A'),
                  _buildTableRow('Phụ kiện', product1.accessories ?? 'N/A',
                      product2.accessories ?? 'N/A'),
                ],
              ),
              const SizedBox(height: ESizes.spaceBtwItems),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: priceColor1,
                        side: BorderSide.none,
                      ),
                      onPressed: () {
                        final uri1 = Uri.parse(product1.urls);
                        launchUrl(uri1, mode: LaunchMode.externalApplication);
                      },
                      child: Text(
                        'Checkout ${formatPriceButton1.toString()}',
                        style: TextStyle(fontSize: productTextSize1 ? 15 : 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ESizes.spaceBtwItems / 2),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: priceColor2,
                        side: BorderSide.none,
                      ),
                      onPressed: () {
                        final uri2 = Uri.parse(product2.urls);
                        launchUrl(uri2, mode: LaunchMode.externalApplication);
                      },
                      child: Text('Checkout ${formatPriceButton2.toString()}',
                          style:
                              TextStyle(fontSize: productTextSize2 ? 15 : 20)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value1, String value2) {
    Color color1 = Colors.black;
    Color color2 = Colors.black;

    if (label == 'Giá hiện tại') {
      String cleanValue1 =
          value1.replaceAll('.', '').replaceAll('₫', '').trim();
      String cleanValue2 =
          value2.replaceAll('.', '').replaceAll('₫', '').trim();

      double price1 = double.tryParse(cleanValue1) ?? 0.0;
      double price2 = double.tryParse(cleanValue2) ?? 0.0;

      // print("Original value1: $value1, value2: $value2");
      // print("Cleaned value1: $cleanValue1, value2: $cleanValue2");
      // print("Parsed price1: $price1, price2: $price2");

      color1 = price1 < price2 ? Colors.green : Colors.red;
      color2 = price2 < price1 ? Colors.green : Colors.red;
    } else if (label == 'Discount') {
      double discount1 = double.tryParse(value1.replaceAll('%', '')) ?? 0;
      double discount2 = double.tryParse(value2.replaceAll('%', '')) ?? 0;

      color1 = discount1 > discount2 ? Colors.red : Colors.black;
      color2 = discount2 > discount1 ? Colors.red : Colors.black;
    }

    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(ESizes.spaceBtwItems / 2),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(ESizes.spaceBtwItems / 2),
          child: _buildValueWithIcon(label, value1, color1),
        ),
        Padding(
          padding: const EdgeInsets.all(ESizes.spaceBtwItems / 2),
          child: _buildValueWithIcon(label, value2, color2),
        ),
      ],
    );
  }

  Widget _buildValueWithIcon(String label, String value, Color color) {
    if (label == 'Đánh giá') {
      return Row(
        children: [
          Text(
            value,
            style: TextStyle(color: color),
          ),
          const SizedBox(width: ESizes.spaceBtwItems / 4),
          Icon(Iconsax.star5, color: Colors.amber, size: ESizes.iconSm),
        ],
      );
    } else {
      return Text(
        value,
        style: TextStyle(color: color),
      );
    }
  }
}
