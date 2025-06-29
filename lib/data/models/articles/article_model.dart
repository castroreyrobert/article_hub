
import 'package:article_hub/domain/entities/articles/article_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel extends ArticleEntity {
  final int ? albumId;
  final int ? id;
  final String ? title;
  final String ? url;
  final String ? thumbnailUrl;

  const ArticleModel({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  @override
  List<Object?> get props => [albumId!, id!, title!, url!, thumbnailUrl!];

  factory ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

}