import 'package:news/generated/json/base/json_convert_content.dart';

class NewsResponseEntity with JsonConvert<NewsResponseEntity> {
	String status;
	int totalResults;
	List<NewsResponseArticle> articles;




}

class NewsResponseArticle with JsonConvert<NewsResponseArticle> {
	NewsResponseArticlesSource source;
	String author;
	String title;
	String description;
	String url;
	String urlToImage;
	String publishedAt;
	String content;
}

class NewsResponseArticlesSource with JsonConvert<NewsResponseArticlesSource> {
	String id;
	String name;
}
