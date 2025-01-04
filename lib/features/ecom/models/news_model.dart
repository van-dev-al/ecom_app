class NewsModel {
  final String author;
  final String description;
  final String imageUrl;
  final String published;
  final String title;
  final String url;

  NewsModel({
    required this.author,
    required this.description,
    required this.imageUrl,
    required this.published,
    required this.title,
    required this.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> data) {
    return NewsModel(
      author: data['author'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['image_url'] ?? '',
      published: data['published'] ?? '',
      title: data['title'] ?? '',
      url: data['url'] ?? '',
    );
  }
}
