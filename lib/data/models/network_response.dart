class NetworkResponse{
  final int statusCode;
  final bool isSuccess;
  final Map<String, dynamic>? responseBody;

  NetworkResponse(this.isSuccess,this.statusCode, this.responseBody);


}