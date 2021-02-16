import 'package:flutter/cupertino.dart';
import 'package:news/model/data_response.dart';
import 'package:news/model/news_response_entity.dart';
import 'package:news/model/sorces_resonse_entity.dart';
import 'package:news/repository/news_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetSourceNewsBloc {
  final NewRepository   _repository = NewRepository();
  final BehaviorSubject<DataResponse<NewsResponseEntity>> _subject = BehaviorSubject<DataResponse<NewsResponseEntity>> ();

  getSourceNews (String sourceId) async {
    DataResponse<NewsResponseEntity>  response = await _repository.getSourceNews(sourceId);
    _subject.add(response);
  }

  void drainStream()=> _subject.value = null;
  @mustCallSuper
  void dispose ()async{
    await _subject.drain();
    _subject.close();
  }
  BehaviorSubject<DataResponse<NewsResponseEntity>> get subject =>_subject ;

}
final getSourceNewsBloc = GetSourceNewsBloc();
