class DataResponse<T> {
  Status status;
  T res; //dynamic
  String loadingMessage;
  String error;

  DataResponse.init() : status = Status.Init;

  DataResponse.loading({this.loadingMessage}) : status = Status.Loading;

  DataResponse.success(this.res) : status = Status.Success;

  DataResponse.error(this.error) : status = Status.Error;


  @override
  String toString() {
    return "Status : $status \n Message : $loadingMessage \n Data : $res";
  }
}

enum Status {
  Init,
  Loading,
  Success,
  Error,
}