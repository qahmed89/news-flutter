import 'package:news/model/data_response.dart';
import 'package:news/model/sorces_resonse_entity.dart';
import 'package:news/repository/news_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetSourcesBloc {
  final NewRepository _repository = NewRepository();
  final BehaviorSubject<DataResponse<SorcesResonseEntity>> _subject =
  BehaviorSubject<DataResponse<SorcesResonseEntity>>();

  getSources() async {
    DataResponse<SorcesResonseEntity>  response = await _repository.getSources();
    print(response.res.sources);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<DataResponse<SorcesResonseEntity>> get subject => _subject;

}
final getSourcesBloc = GetSourcesBloc();