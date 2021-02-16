import 'package:news/model/data_response.dart';
import 'package:news/model/news_response_entity.dart';
import 'package:news/repository/news_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
final NewRepository _repository = NewRepository();
final BehaviorSubject<DataResponse<NewsResponseEntity>> _subject =
BehaviorSubject<DataResponse<NewsResponseEntity>>();

search(String value) async {
  DataResponse<NewsResponseEntity> response = await _repository.search(value);
  _subject.sink.add(response);
}

dispose() {
  _subject.close();
}

BehaviorSubject<DataResponse<NewsResponseEntity>> get subject => _subject;

}
final searchBloc = SearchBloc();