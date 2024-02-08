import 'package:provider/provider.dart';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import '../add_request_vm.dart';

class OTStartEndTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddRequestVM>();

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 6,
            child: DateTimePicker(
              locale: Locale('en'),
              type: DateTimePickerType.dateTime,
              // use24HourFormat: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                  labelText: getTranslated(context, "OTstartfrom")),
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(Duration(days: 150)),
              lastDate: DateTime.now().add(Duration(days: 150)),
              dateLabelText: getTranslated(context, "OTstartfrom"),
              // style: Theme.of(context).textTheme.caption,
              onChanged: (val) => model.updateOtStartDate(val),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          child: SizedBox(
            child: DateTimePicker(
              locale: Locale('en'),
              type: DateTimePickerType.dateTime,
              // use24HourFormat: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                  labelText: getTranslated(context, "OTendson")),
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(Duration(days: 150)),
              lastDate: DateTime.now().add(Duration(days: 150)),
              dateLabelText: getTranslated(context, "OTendson"),
              // style: Theme.of(context).textTheme.caption,
              onChanged: (val) => model.updateOtEndDate(val),
              // onSaved: (val) => print(val),
            ),
          ),
        ),
      ],
    );
  }
}
