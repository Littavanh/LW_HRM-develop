import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/models/emp_person.dart';
import 'package:LTL_HRM/src/components/fetching_data_error.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/components/no_data_found.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/instant_search_page.dart';
import 'package:LTL_HRM/src/screens/AddRequest/leave_form_vm.dart';
import 'package:LTL_HRM/src/services/UtilsService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectDelegation extends StatelessWidget {
  _buildSearchEmployee(
    BuildContext context,
    List<String> empList,
    allEmpList,
  ) async {
    final result = await showSearch(
        context: context,
        delegate: InstantSearchPage(
            empList, getTranslated(context, 'EnterEmpName'), Icons.person));
    context.read<LeaveFormVM>().updateResponsiblePerson(result, allEmpList);
  }

  @override
  Widget build(BuildContext context) {
    print('Build Delegation');

    return FutureBuilder<ApiResponse>(
        future: UtilsService().fetchResponsiblePerson(),
        builder: (context, AsyncSnapshot<ApiResponse> response) {
          if (response.connectionState == ConnectionState.waiting)
            return LoadingView();
          if (response.hasError)
            return FetchingDataError(message: 'fetchResponsiblePerson');
          final apiResponse = response.data;
          if (apiResponse.hasError)
            return FetchingDataError(message: 'fetchResponsiblePerson');
          if (apiResponse.data == null) {
            return NoDataFound();
          }

          final List<EmpPerson> empPersons = response.data.data;

          //Add the responsible person to the ViewModel
          context.read<LeaveFormVM>().updateEmpOptionList(
              empPersons.map((EmpPerson e) => e.empName).toList());

          return Selector<LeaveFormVM, String>(
              selector: (_, model) => model.responsiblePerson,
              builder: (_, selectedPerson, __) {
                TextEditingController _responseEmpTextCtrl =
                    TextEditingController();
                _responseEmpTextCtrl.text = selectedPerson;
                return Container(
                  padding: const EdgeInsets.all(9),
                  child: TextFormField(
                    controller: _responseEmpTextCtrl,
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.grey)),
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          bottom: 10.0, left: 10.0, right: 10.0),
                      suffixIcon: Icon(Icons.keyboard_arrow_down),
                      labelText:
                          getTranslated(context, "SelectResponsiblePerson"),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return getTranslated(
                            context, "SelectResponsiblePerson");
                      } else {
                        return null;
                      }
                    },
                    onTap: () {
                      _buildSearchEmployee(
                          context,
                          context.read<LeaveFormVM>().empOptionList,
                          empPersons);
                    },
                  ),
                );
              });
        });
  }
}
