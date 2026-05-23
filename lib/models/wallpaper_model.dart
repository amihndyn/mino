class WallpaperModel {
  final String id;
  final String title;
  final String image;

  WallpaperModel({
    required this.id,
    required this.title,
    required this.image,
  });

  factory WallpaperModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return WallpaperModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }
}