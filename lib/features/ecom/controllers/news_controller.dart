import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/news/new_repository.dart';
import 'package:ecom_app/features/ecom/models/news_model.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  static NewsController get instance => Get.find();

  final isLoading = false.obs;
  final newsRepository = Get.put(NewRepository());
  RxList<NewsModel> featuredNews = <NewsModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedNews();
  }

  Future<void> fetchFeaturedNews() async {
    try {
      isLoading.value = true;

      final news = await newsRepository.fetchNews();

      featuredNews.assignAll(news);
    } catch (e) {
      ELoader.errorSnackBar(
          title: 'Opp! Something went wrong.', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
