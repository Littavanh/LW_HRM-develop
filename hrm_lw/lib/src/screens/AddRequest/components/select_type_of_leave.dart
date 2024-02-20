import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/models/leave_type.dart';
import 'package:LTL_HRM/src/components/fetching_data_error.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/components/no_data_found.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/instant_search_page.dart';
import 'package:LTL_HRM/src/screens/AddRequest/leave_form_vm.dart';
import 'package:LTL_HRM/src/services/UtilsService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class SelectTypeOfLeave extends StatelessWidget {
  final UtilsService _utilsService = UtilsService();
  // final TextEditingController _typeOfLeaveTextCtrl = TextEditingController();

  _buildSearchTypeOfLeaves(BuildContext context, List<String> dataList,
      List<LeaveType> leaveTypes) async {
    final result = await showSearch(
        context: context, delegate: InstantSearchPage(dataList,'', null));
    context.read<LeaveFormVM>().updateTypeOfLeave(result, leaveTypes);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse>(
        future: _utilsService.fetchTypeOfLeave(),
        builder: (context, AsyncSnapshot<ApiResponse> response) {
          if (response.connectionState == ConnectionState.waiting)
            return LoadingView();
          if (response.hasError)
            return FetchingDataError(message: 'Fetching type of leavedata!');
          final apiResponse = response.data;
          if (apiResponse.hasError)
            return FetchingDataError(message: 'Fetching type of leave data!');
          if (apiResponse.data == null) {
            return NoDataFound();
          }

          final List<LeaveType> leaveTypes = response.data.data;
          // final typeOfLeaveList = leaveType.resultObject;
          List<String> leaveTypeList =
              leaveTypes.map((e) => e.typeName).toList();
List<String> leaveTypeList1 =
              leaveTypes.map((e) => e.typeShotname).toList();
          return Selector<LeaveFormVM, String>(
              selector: (_, model) => model.typeOfLeave,
              builder: (_, type, __) {
                TextEditingController _typeOfLeaveTextCtrl =
                    TextEditingController();
                _typeOfLeaveTextCtrl.text = type;
                return Container(
                    padding: const EdgeInsets.all(9),
                    child: TextFormField(
                      controller: _typeOfLeaveTextCtrl,
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.grey)),
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            bottom: 10.0, left: 10.0, right: 10.0),
                        suffixIcon: Icon(Icons.keyboard_arrow_down),
                        labelText: getTranslated(context, "Selecttypeofleave"),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please Select Type of Leave';
                        } else {
                          return null;
                        }
                      },
                      onTap: () {
                        _buildSearchTypeOfLeaves(
                            context, leaveTypeList, leaveTypes);
                      },
                    ));
              });
        });
  }
}
