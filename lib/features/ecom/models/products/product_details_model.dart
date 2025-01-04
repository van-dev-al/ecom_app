import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailsModel {
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

  ProductDetailsModel({
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

  static ProductDetailsModel empty() => ProductDetailsModel();

  toJson() {
    return {
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

  factory ProductDetailsModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductDetailsModel.empty();
    return ProductDetailsModel(
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

  factory ProductDetailsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductDetailsModel(
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
    } else {
      return ProductDetailsModel.empty();
    }
  }
}
