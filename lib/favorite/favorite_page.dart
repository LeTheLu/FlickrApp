import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flickr_app/favorite/cubit_favorite.dart';
import 'package:flickr_app/favorite/state_favorite.dart';
import 'package:flickr_app/service/model.dart';
import 'package:flickr_app/widget/grid_view_photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';

class Favorite extends StatefulWidget {
  final FavoriteCubit _favoriteCubit;
  const Favorite(this._favoriteCubit, {Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {

  final ScrollController _scrollController = ScrollController();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        if ('ConnectivityResult.none' == result.toString()) {
          showSimpleNotification(
            const Text("Không có internet"),
            background: Colors.red,
          );
        }
        else{
          widget._favoriteCubit.getDataFavorite();
        }
      });
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
          widget._favoriteCubit.getDataFavoriteMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  @override
  @override
  Widget build(BuildContext context) {
    List<Photo> list = [];
    bool check = false;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF355C7D),
        elevation: 0,
        title: Text(
          "Favorite",
          style: GoogleFonts.italianno(
            fontSize: 40,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios),),
      ),
      body: Column(
        children: [
          const Text("(Here are your favorite photos from the Flickr website)", style: TextStyle(color: Colors.white70),),
          Expanded(
            child: BlocBuilder<FavoriteCubit, StateFavorite>(
              bloc: widget._favoriteCubit,
                buildWhen: (pre, cur) => pre.enumStateFavorite != cur.enumStateFavorite ,
                builder: (context, state){
                  if(state.enumStateFavorite == EnumStateFavorite.Loading){
                    return const Center(child: CircularProgressIndicator(),);
                  }else if(state.enumStateFavorite == EnumStateFavorite.Success){
                    list = state.list!;
                    check = false;
                  }else if(state.enumStateFavorite == EnumStateFavorite.LoadMore){
                    check = true;
                  }
                  return GridViewPhoto(check: check,list: list,scrollController: _scrollController,onRefresh: () => widget._favoriteCubit.getDataFavorite(),);
                  }),
          ),
        ],
      ),
    );
  }
}

