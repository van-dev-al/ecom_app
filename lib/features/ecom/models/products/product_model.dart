import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/features/ecom/models/trademark_model.dart';

class ProductModel {
  String id;
  String name;
  String brand;
  double price;
  double originalPrice;
  double discount;
  int reviewCount;
  double ratingAverage;
  String categoryId;
  String urls;
  String thumbnail;
  List<String> imageUrls;

  TrademarkModel? trademarkModel;
  // ProductDetailsModel productDetailsModel;
  String? battery;
  String? bluetooth;
  String? cameraPrimary;
  String? cameraSecondary;
  String? cameraVideo;
  String? displayType;
  String? screenSize;
  String? gpu;
  String? cpu;
  String? ram;
  String? rom;
  String? chipSet;
  String? nfc;
  String? gps;
  String? internet;
  String? accessories;
  String? model;
  String? jack35mm;
  String? simType;
  String? chargingPort;
  String? weight;
  String? wifi;

  // Constructor sửa đổi
  ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.originalPrice,
    this.reviewCount = 0,
    this.ratingAverage = 0.0,
    required this.discount,
    required this.urls,
    required this.imageUrls,
    required this.thumbnail,
    required this.categoryId,
    this.trademarkModel,
    // required this.productDetailsModel,
    this.battery,
    this.bluetooth,
    this.cameraPrimary,
    this.cameraSecondary,
    this.cameraVideo,
    this.displayType,
    this.screenSize,
    this.gpu,
    this.cpu,
    this.ram,
    this.rom,
    this.chipSet,
    this.nfc,
    this.gps,
    this.internet,
    this.accessories,
    this.model,
    this.jack35mm,
    this.simType,
    this.chargingPort,
    this.weight,
    this.wifi,
  });

  // empty function
  static ProductModel empty() => ProductModel(
        id: '',
        name: '',
        price: 0.0,
        originalPrice: 0.0,
        urls: '',
        imageUrls: [],
        thumbnail: '',
        trademarkModel: TrademarkModel.empty(),
        discount: 0,
        brand: '',
        categoryId: '',
      );

  // json format
  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Brand': brand,
      'Price': price,
      'OriginalPrice': originalPrice,
      'ReviewCount': reviewCount,
      'RatingAverage': ratingAverage,
      'Discount': discount,
      'Urls': urls,
      'ImageUrls': imageUrls,
      'Thumbnail': thumbnail,
      'CategoryId': categoryId,
      'TrademarkModel': trademarkModel?.toJson(),
      'battery': battery,
      'bluetooth': bluetooth,
      'camera_primary': cameraPrimary,
      'camera_secondary': cameraSecondary,
      'camera_video': cameraVideo,
      'display_type': displayType,
      'screen_size': screenSize,
      'GPU': gpu,
      'CPU': cpu,
      'RAM': ram,
      'ROM': rom,
      'chip_set': chipSet,
      'NFC': nfc,
      'GPS': gps,
      'internet': internet,
      'accessories': accessories,
      'model': model,
      'jack_3.5mm': jack35mm,
      'sim_type': simType,
      'charging_port': chargingPort,
      'weight': weight,
      'wifi': wifi,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Name': name,
      'Brand': brand,
      'Price': price,
      'OriginalPrice': originalPrice,
      'ReviewCount': reviewCount,
      'RatingAverage': ratingAverage,
      'Discount': discount,
      'Urls': urls,
      'ImageUrls': imageUrls,
      'Thumbnail': thumbnail,
      'CategoryId': categoryId,
      'TrademarkModel': trademarkModel?.toJson(),
      'battery': battery,
      'bluetooth': bluetooth,
      'camera_primary': cameraPrimary,
      'camera_secondary': cameraSecondary,
      'camera_video': cameraVideo,
      'display_type': displayType,
      'screen_size': screenSize,
      'GPU': gpu,
      'CPU': cpu,
      'RAM': ram,
      'ROM': rom,
      'chip_set': chipSet,
      'NFC': nfc,
      'GPS': gps,
      'internet': internet,
      'accessories': accessories,
      'model': model,
      'jack_3.5mm': jack35mm,
      'sim_type': simType,
      'charging_port': chargingPort,
      'weight': weight,
      'wifi': wifi,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    List<String> processImageUrls() {
      var imageData = data['image_url'];
      if (imageData == null) return [];
      if (imageData is String) {
        return imageData
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
      }
      if (imageData is List) {
        return List<String>.from(
            imageData.where((url) => url != null && url.toString().isNotEmpty));
      }
      return [];
    }

    return ProductModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      brand: data['brand'] ?? '',
      price: double.tryParse(data['current_price'] ?? '0') ?? 0,
      originalPrice: double.tryParse(data['original_price'] ?? '0') ?? 0.0,
      reviewCount: int.tryParse(data['review_count'] ?? '0') ?? 0,
      ratingAverage: double.tryParse(data['rating_average'] ?? '0') ?? 0.0,
      discount: double.tryParse(data['discount_rate'] ?? '0') ?? 0.0,
      urls: data['url'] ?? [],
      imageUrls: processImageUrls(),
      thumbnail: data['thumbnails'] ?? '',
      categoryId: data['category_id'] ?? '',
      trademarkModel: TrademarkModel.fromJson(
        {'Source': data['source'] ?? '', 'Image': data['image'] ?? ''},
      ),
      battery: data['battery'] ?? '',
      bluetooth: data['bluetooth'] ?? '',
      cameraPrimary: data['camera_primary'] ?? '',
      cameraSecondary: data['camera_secondary'] ?? '',
      cameraVideo: data['camera_video'] ?? '',
      displayType: data['display_type'] ?? '',
      screenSize: data['screen_size'] ?? '',
      gpu: data['GPU'] ?? '',
      cpu: data['CPU'] ?? '',
      ram: data['RAM'] ?? '',
      rom: data['ROM'] ?? '',
      chipSet: data['chip_set'] ?? '',
      nfc: data['NFC'] ?? '',
      gps: data['GPS'] ?? '',
      internet: data['internet'] ?? '',
      accessories: data['accessories'] ?? '',
      model: data['model'] ?? '',
      jack35mm: data['jack_3.5mm'] ?? '',
      simType: data['sim_type'] ?? '',
      chargingPort: data['charging_port'] ?? '',
      weight: data['weight'] ?? '',
      wifi: data['wifi'] ?? '',
    );
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;
    List<String> processFirestoreImageUrls() {
      var imageData = data['ImageUrls'];
      if (imageData == null) return [];
      if (imageData is List) {
        return List<String>.from(
            imageData.where((url) => url != null && url.toString().isNotEmpty));
      }
      if (imageData is String) {
        return imageData
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
      }
      return [];
    }

    return ProductModel(
      id: document.id,
      name: data['Name'] ?? '',
      brand: data['Brand'] ?? '',
      price: double.tryParse(data['Price'] ?? '0') ?? 0.0,
      originalPrice: double.tryParse(data['OriginalPrice'] ?? '0') ?? 0.0,
      reviewCount: int.tryParse(data['ReviewCount'] ?? '0') ?? 0,
      ratingAverage: data['RatingAverage'] ?? '',
      discount: data['Discount'] ?? '',
      urls: data['Urls'] ?? '',
      imageUrls: processFirestoreImageUrls(),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      trademarkModel: TrademarkModel.fromSnapshot(data['Source']),
    );
  }
}
