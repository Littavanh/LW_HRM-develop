import 'dart:typed_data';

import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/screens/home/components/photo_viewer.dart';
import 'package:LTL_HRM/src/services/request_service.dart';
import 'package:flutter/material.dart';

class DocViewScreen extends StatefulWidget {
  final String reqDetailId;

  DocViewScreen(this.reqDetailId);

  @override
  _DocViewScreenState createState() => _DocViewScreenState();
}

class _DocViewScreenState extends State<DocViewScreen> {
  final RequestService _leaveService = RequestService();
  bool _loading = false;
  List<Map<String, dynamic>> _docList = [];
  Uint8List imgBytes;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    setState(() {
      _loading = true;
    });
    ApiResponse response =
        await _leaveService.fetchRequestDocument(widget.reqDetailId);
    setState(() {
      Map data = response.data;
      _docList.add(data);
      // imgBytes = Base64Codec().decode(_docList[0]['imageFile']);
    });
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Document'),
        ),
        body: _loading ? LoadingView() : PhotoViewer(_docList));
  }
}
