import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/select_return_date.dart';
import 'package:LTL_HRM/src/screens/AddRequest/leave_form_vm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SelectFullDay extends StatelessWidget {
  final LeaveFormVM model;
  SelectFullDay(this.model);

  final dateFormat = DateFormat("yyyy-MM-dd");
  final TextEditingController _totalDaysCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final strDate = model.strDate;
    final endDate = model.endDate;

    return Column(
      children: [
        _selectDates(context, strDate, endDate),
        _inputTotalDays(context),
      ],
    );
  }

  _selectDates(context, strDate, endDate) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      child: Column(children: [
        GestureDetector(
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
        GestureDetector(
          onTap: () async {
            final DateTime pickedDate = await showDatePicker(
                context: context,
                initialDate: model.endDate,
                firstDate: model.strDate,
                lastDate: DateTime(model.endDate.year + 1));
            if (pickedDate != null) {
              model.updateEndDate(dateFormat.parse(pickedDate.toString()));
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getTranslated(context, 'EndDate'),
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
                  child: Text('${endDate.day}/${endDate.month}/${endDate.year}',
                      style: TextStyle(fontSize: 16))),
              SelectReturnDate(),
            ],
          ),
        ),
      ]),
    );
  }

  _inputTotalDays(context) {
    return Selector<LeaveFormVM, double>(
        selector: (_, model) => model.totalDays,
        builder: (_, totalDays, __) {
          _totalDaysCtrl.text = totalDays.toString();
          return Container(
            margin: EdgeInsets.all(8),
            child: TextFormField(
              controller: _totalDaysCtrl,
              // maxLength: 4,
              decoration: InputDecoration(
                // hintText: 'Applying for  ${totalDays.toString()} days',
                labelText: getTranslated(context, 'TotalLeaveDays'),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                filled: true,
                contentPadding:
                    EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
              ),
              // keyboardType: TextInputType.,
              onChanged: (value) => model.updateTotalDays(double.parse(value)),
            ),
          );
        });
  }
}
