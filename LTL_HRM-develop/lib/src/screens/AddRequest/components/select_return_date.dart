import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/screens/AddRequest/leave_form_vm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SelectReturnDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    final returnDate =
        context.select<LeaveFormVM, DateTime>((model) => model.returnDate);
    // final returnDate = model.returnDate;
    //  initialDate: selectedLeaveRadio == 1
    //                   ? endDate.add(Duration(days: 1))
    //                   : selecteddate,
    //               firstDate: selectedLeaveRadio == 1
    //                   ? endDate.add(Duration(days: 1))
    //                   : selecteddate,
    //               lastDate: dateFormat.parse(
    //                   DateTime(DateTime.now().year + 1).toString()));
    // final initDate = model.leaveType == 1 ? model.endDate.add(Duration(days: 1)) : ;

    return GestureDetector(
      onTap: () async {
        final DateTime pickedDate = await showDatePicker(
            context: context,
            initialDate: returnDate,
            firstDate: context.read<LeaveFormVM>().endDate,
            lastDate: returnDate.add(Duration(days: 30)));
        if (pickedDate != null) {
          context
              .read<LeaveFormVM>()
              .updateReturnDate(dateFormat.parse(pickedDate.toString()));
        }
      },
      child: Container(
        // margin: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getTranslated(context, 'Returntoworkdate'),
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
              child: Text(
                '${returnDate.day}/${returnDate.month}/${returnDate.year}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
