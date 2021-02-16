import 'dart:math';

import 'package:news/model/news_response_entity.dart';

newsResponseEntityFromJson(NewsResponseEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['totalResults'] != null) {
		data.totalResults = json['totalResults'] is String
				? int.tryParse(json['totalResults'])
				: json['totalResults'].toInt();

	}
	if (json['articles'] != null) {
		data.articles = new List<NewsResponseArticle>();
		(json['articles'] as List).forEach((v) {
			data.articles.add(new NewsResponseArticle().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> newsResponseEntityToJson(NewsResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;

	data['totalResults'] = entity.totalResults;
	if (entity.articles != null) {
		data['articles'] =  entity.articles.map((v) => v.toJson()).toList();
	}
	return data;
}

newsResponseArticleFromJson(NewsResponseArticle data, Map<String, dynamic> json) {
	if (json['source'] != null) {
		data.source = new NewsResponseArticlesSource().fromJson(json['source']);
	}
	if (json['author'] != null) {
		data.author = json['author'].toString();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['description'] != null) {
		data.description = json['description'].toString();
	}
	if (json['url'] != null) {
		data.url = json['url'].toString();
	}
	if (json['urlToImage'] != null) {
		data.urlToImage = json['urlToImage'].toString();
	}
	if (json['publishedAt'] != null) {
		data.publishedAt = json['publishedAt'].toString();
	}
	if (json['content'] != null) {
		data.content = json['content'].toString();
	}
	return data;
}

Map<String, dynamic> newsResponseArticleToJson(NewsResponseArticle entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.source != null) {
		data['source'] = entity.source.toJson();
	}
	data['author'] = entity.author;
	data['title'] = entity.title;
	data['description'] = entity.description;
	data['url'] = entity.url;
	data['urlToImage'] = entity.urlToImage;
	data['publishedAt'] = entity.publishedAt;
	data['content'] = entity.content;
	return data;
}

newsResponseArticlesSourceFromJson(NewsResponseArticlesSource data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	return data;
}

Map<String, dynamic> newsResponseArticlesSourceToJson(NewsResponseArticlesSource entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	return data;
}
