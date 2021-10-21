
import 'dart:core';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flickr_app/service/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImgItem extends StatefulWidget {
  final Photo photo;
  const ImgItem({Key? key, required this.photo}) : super(key: key);

  @override
  State<ImgItem> createState() => _ImgItemState();
}

class _ImgItemState extends State<ImgItem> {

  bool pressAttention = true;

  _save(String url) async {
      bool check = false;

      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
        content: Text("Đang Tải xuống"),
        duration: Duration(seconds: 1),
        backgroundColor:Colors.blue,
      ));

      var response = await Dio().get(
          url,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "hello");
      check = result.toString().contains("true");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(check ? 'Đã tải xuống': "Tải xuống thất bại"),
        duration: const Duration(seconds: 2),
        backgroundColor: check ? Colors.green : Colors.red,
      ));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            //mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: PhotoView(
                    loadingBuilder: (context, progress) => const Center(
                      child: SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    imageProvider: NetworkImage(
                      widget.photo.urlM ??
                          widget.photo.urlO ??
                              widget.photo.urlC ??
                              widget.photo.urlL ?? '',
                        ),
                  ),
                )
                ),
            ],
          ),
          Positioned(
              bottom: 10,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _save(widget.photo.urlM ?? widget.photo.urlO ??
              widget.photo.urlC ??
              widget.photo.urlL ??
              widget.photo.urlM ?? '');
        },
        child: const  Icon(Icons.download),
      )
    );
  }
}
