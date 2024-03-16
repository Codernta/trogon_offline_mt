// To parse this JSON data, do
//
//     final feedPageModel = feedPageModelFromJson(jsonString);

import 'dart:convert';

FeedPageModel feedPageModelFromJson(String str) => FeedPageModel.fromJson(json.decode(str));

String feedPageModelToJson(FeedPageModel data) => json.encode(data.toJson());

class FeedPageModel {
  final int status;
  final String message;
  final List<Datum> data;

  FeedPageModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FeedPageModel.fromJson(Map<String, dynamic> json) => FeedPageModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final String feedId;
  final String title;
  final String content;
  final String image;
  final String categoryId;
  final dynamic courseId;
  final FileType fileType;
  final String videoUrl;
  final String? thumbnail;
  final DateTime updatedOn;
  final Category category;
  final String file;
  final String videoThumbnail;
  final int isBookmarked;
  final int isLiked;
  final String date;
  final int likeCount;

  Datum({
    required this.feedId,
    required this.title,
    required this.content,
    required this.image,
    required this.categoryId,
    required this.courseId,
    required this.fileType,
    required this.videoUrl,
    required this.thumbnail,
    required this.updatedOn,
    required this.category,
    required this.file,
    required this.videoThumbnail,
    required this.isBookmarked,
    required this.isLiked,
    required this.date,
    required this.likeCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    feedId: json["feed_id"],
    title: json["title"],
    content: json["content"],
    image: json["image"],
    categoryId: json["category_id"],
    courseId: json["course_id"],
    fileType: fileTypeValues.map[json["file_type"]]!,
    videoUrl: json["video_url"],
    thumbnail: json["thumbnail"],
    updatedOn: DateTime.parse(json["updated_on"]),
    category: categoryValues.map[json["category"]]!,
    file: json["file"],
    videoThumbnail: json["video_thumbnail"],
    isBookmarked: json["is_bookmarked"],
    isLiked: json["is_liked"],
    date: json["date"],
    likeCount: json["like_count"],
  );

  Map<String, dynamic> toJson() => {
    "feed_id": feedId,
    "title": title,
    "content": content,
    "image": image,
    "category_id": categoryId,
    "course_id": courseId,
    "file_type": fileTypeValues.reverse[fileType],
    "video_url": videoUrl,
    "thumbnail": thumbnail,
    "updated_on": updatedOn.toIso8601String(),
    "category": categoryValues.reverse[category],
    "file": file,
    "video_thumbnail": videoThumbnail,
    "is_bookmarked": isBookmarked,
    "is_liked": isLiked,
    "date": date,
    "like_count": likeCount,
  };
}

enum Category {
  EXAMS,
  NEET_EXAM_2023
}

final categoryValues = EnumValues({
  "Exams": Category.EXAMS,
  "NEET EXAM 2023": Category.NEET_EXAM_2023
});

enum FileType {
  IMAGE
}

final fileTypeValues = EnumValues({
  "image": FileType.IMAGE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
