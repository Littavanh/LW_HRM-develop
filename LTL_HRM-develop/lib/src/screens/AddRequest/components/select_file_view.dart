import 'dart:io';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/screens/AddRequest/leave_form_vm.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SelectFileView extends StatelessWidget {
  Future<void> _showMyDialog(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(context);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromGallery(BuildContext context) async {
    final imageFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 10);
    if (imageFile != null) {
      context.read<LeaveFormVM>().onChooseFile(imageFile);
    }
  }

  _imgFromCamera(BuildContext context) async {
    final imageFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 10);
    if (imageFile != null) {
      context.read<LeaveFormVM>().onChooseFile(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imgFile =
        context.select<LeaveFormVM, PickedFile>((model) => model.pickedFile);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            child: Text(getTranslated(context, 'ChooseFile')),
            onPressed: () => _showMyDialog(context),
          ),
          imgFile != null
              ? Container(
                  child: Image.file(
                    File(imgFile.path),
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
