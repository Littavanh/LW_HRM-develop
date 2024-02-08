import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewer extends StatelessWidget {
  final List<Map<String, dynamic>> docImgList;

  PhotoViewer(this.docImgList);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider:
              MemoryImage(Base64Codec().decode(docImgList[0]['imageFile'])),
          initialScale: PhotoViewComputedScale.contained * 0.8,
          heroAttributes:
              PhotoViewHeroAttributes(tag: docImgList[index]['imageFile']),
        );
      },
      itemCount: docImgList.length,
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes,
          ),
        ),
      ),
      // backgroundDecoration: widget.backgroundDecoration,
      // pageController: widget.pageController,
      // onPageChanged: onPageChanged,
    ));
  }
}
