import 'package:news/generated/json/base/json_convert_content.dart';

class SorcesResonseEntity with JsonConvert<SorcesResonseEntity> {
	String status;
	List<SorcesResonseSource> sources;

}



class SorcesResonseSource with JsonConvert<SorcesResonseSource> {
	String id;
	String name;
	String description;
	String url;
	String category;
	String language;
	String country;
}
