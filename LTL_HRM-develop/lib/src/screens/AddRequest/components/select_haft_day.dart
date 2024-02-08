import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/screens/AddRequest/leave_form_vm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SelectHaftDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat("yyyy-MM-dd");
    final model = context.watch<LeaveFormVM>();
    final strDate = model.strDate;

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio(
                          value: 1,
                          groupValue: context.read<LeaveFormVM>().leaveHalfDay,
                          onChanged: (value) {
                            model.updateLeaveHalfDay(value);
                          }),
                      Text(getTranslated(context, 'FirstHalf'))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                          value: 2,
                          groupValue: context.read<LeaveFormVM>().leaveHalfDay,
                          onChanged: (value) =>
                              model.updateLeaveHalfDay(value)),
                      Text(getTranslated(context, 'SecondHalf'))
                    ],
                  ),
                ],
              ),
            )),
        Container(
          margin: EdgeInsets.only(left: 8, right: 8),
          child: GestureDetector(
            onTap: () async {
              final DateTime pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 150)),
                  lastDate: DateTime.now().add(Duration(days: 120)));
              if (pickedDate != null) {
                model.updateStrDate(dateFormat.parse(pickedDate.toString()));
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(getTranslated(context, 'StartDate'),
                    style: TextStyle(fontSize: 12)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Text('${strDate.day}/${strDate.month}/${strDate.year}',
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
