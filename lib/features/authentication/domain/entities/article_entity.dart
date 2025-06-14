import 'package:equatable/equatable.dart';


class ArticleEntity extends Equatable {

  final int ? albumId;
  final int ? id;
  final String ? title;
  final String ? url;
  final String ? thumbnailURL;

  const ArticleEntity({this.albumId, this.id, this.title, this.url, this.thumbnailURL});

  @override
  List<Object?> get props => [
    albumId,
    id,
    title,
    url,
    thumbnailURL
  ];

}