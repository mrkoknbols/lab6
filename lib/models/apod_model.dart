class APODModel {
  final String? copyright;
  final String date;
  final String explanation;
  final String hdurl;
  final String mediaType;
  final String title;
  final String url;
  final String? thumbnailUrl;

  APODModel({
    this.copyright,
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.title,
    required this.url,
    this.thumbnailUrl,
  });

  factory APODModel.fromJson(Map<String, dynamic> json) {
    return APODModel(
      copyright: json['copyright'],
      date: json['date'],
      explanation: json['explanation'],
      hdurl: json['hdurl'] ?? json['url'],
      mediaType: json['media_type'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnail_url'],
    );
  }
}