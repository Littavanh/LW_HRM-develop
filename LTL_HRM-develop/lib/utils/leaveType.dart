import 'package:LTL_HRM/models/leaveTypes.dart';

class LeaveTypesResponse {
  final List<LeaveTypes> leaveTypes;
  LeaveTypesResponse(this.leaveTypes);
}

class Token {
  final String token;
  Token(this.token);
}