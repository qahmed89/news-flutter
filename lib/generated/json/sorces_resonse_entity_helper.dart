import 'package:news/model/sorces_resonse_entity.dart';

sorcesResonseEntityFromJson(SorcesResonseEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['sources'] != null) {
		data.sources = new List<SorcesResonseSource>();
		(json['sources'] as List).forEach((v) {
			data.sources.add(new SorcesResonseSource().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> sorcesResonseEntityToJson(SorcesResonseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	if (entity.sources != null) {
		data['sources'] =  entity.sources.map((v) => v.toJson()).toList();
	}
	return data;
}

sorcesResonseSourceFromJson(SorcesResonseSource data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['description'] != null) {
		data.description = json['description'].toString();
	}
	if (json['url'] != null) {
		data.url = json['url'].toString();
	}
	if (json['category'] != null) {
		data.category = json['category'].toString();
	}
	if (json['language'] != null) {
		data.language = json['language'].toString();
	}
	if (json['country'] != null) {
		data.country = json['country'].toString();
	}
	return data;
}

Map<String, dynamic> sorcesResonseSourceToJson(SorcesResonseSource entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['description'] = entity.description;
	data['url'] = entity.url;
	data['category'] = entity.category;
	data['language'] = entity.language;
	data['country'] = entity.country;
	return data;
}