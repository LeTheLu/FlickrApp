import 'package:flickr_app/service/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:flickr_app/widget/img.dart';

class GridViewPhoto extends StatelessWidget {
  final bool check;
  final List<Photo> list;
  final ScrollController scrollController;
  final VoidCallback onRefresh;

  const GridViewPhoto(
      {Key? key,
      required this.check,
      required this.list,
      required this.scrollController,
      required this.onRefresh})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, right: 18, left: 18),
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async => onRefresh.call(),
            child: StaggeredGridView.countBuilder(
              controller: scrollController,
              crossAxisCount: 4,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ImgItem(photo: list[index]))),
                child: Image.network(
                  list[index].urlO ??
                      list[index].urlC ??
                      list[index].urlL ??
                      list[index].urlM ??
                      "",
                  fit: BoxFit.cover,
                  errorBuilder: (context, exception, stackTrace) {
                    return Text('Err');
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.count(2, index.isEven ? 2 : 1),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          ),
          Positioned(
              bottom: 10,
              right: MediaQuery.of(context).size.width * 0.41,
              child: Visibility(
                  visible: check,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ))),
        ],
      ),
    );
  }
}
