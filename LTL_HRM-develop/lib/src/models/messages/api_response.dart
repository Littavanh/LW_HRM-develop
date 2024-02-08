class ApiResponse {
  bool hasError;
  bool authorized;
  dynamic data;

  ApiResponse({this.hasError, this.authorized, this.data});
}
