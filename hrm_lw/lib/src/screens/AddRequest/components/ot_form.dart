import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/screens/AddRequest/add_request_vm.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/ot_start_end_time.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/select_ot_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class OTForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.read<AddRequestVM>();
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

    return FormBuilder(
      key: _fbKey,
      child: ListView(
        children: [
          SelectOTType(),
          OTStartEndTime(),
          Container(
            padding: const EdgeInsets.all(9),
            // child: TextFormField(
            //   decoration: new InputDecoration(
            //     fillColor: Colors.white,
            //     border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(5.0)),
            //         borderSide: BorderSide(color: Colors.grey)),
            //     filled: true,
            //     contentPadding:
            //         EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
            //     // suffixIcon: Icon(Icons.keyboard_arrow_down),
            //     labelText: getTranslated(context, "Subject"),
            //   ),
            //   // controller: subjectController,
            //   onChanged: (value) => model.onSubjectChanged(value),
            //   validator: (String value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please Enter Subject';
            //     } else {
            //       return null;
            //     }
            //   },
            // ),
          ),
          Container(
            padding: const EdgeInsets.all(9),
            child: TextFormField(
              decoration: new InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                filled: true,
                contentPadding:
                    EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                // suffixIcon: Icon(Icons.keyboard_arrow_down),
                labelText: getTranslated(context, "Reason"),
              ),
              // controller: reasonController,
              onChanged: (value) => model.onReasonChanged(value),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Reason';
                } else {
                  return null;
                }
              },
            ),
          ),
          Consumer<AddRequestVM>(builder: (context, model, _) {
            if (model.loading) return LoadingView();
            return Container(
                // width: size.width * 0.9,
                margin:
                    EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                height: 50,
                child: ElevatedButton(
                  // color: Theme.of(context).primaryColor,
                  child: Text(
                    getTranslated(context, 'SendRequest'),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () => model.onSendRequest(_fbKey, context),
                ));
          }),
        ],
      ),
    );
  }
}
