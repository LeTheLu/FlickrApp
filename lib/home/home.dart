import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flickr_app/favorite/cubit_favorite.dart';
import 'package:flickr_app/favorite/favorite_page.dart';
import 'package:flickr_app/favorite/state_favorite.dart';
import 'package:flickr_app/home/cubit_home.dart';
import 'package:flickr_app/home/state_home.dart';
import 'package:flickr_app/service/model.dart';
import 'package:flickr_app/widget/grid_view_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeCubit _cubitHome = HomeCubit(const StateHome());
  final FavoriteCubit _cubitFavorite = FavoriteCubit(StateFavorite());
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;


  @override
  void initState() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        if ('ConnectivityResult.none' == result.toString()) {
          showSimpleNotification(
              const Text("Không có internet"),
              background: Colors.red,
          );
        }
        else{
          _cubitHome.getDataHome();
        }
      });
    });
    _cubitHome.getDataHome();
    _cubitFavorite.getDataFavorite();
    _textEditingController.text = _textEditingController.text;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_textEditingController.text == '') {
          _cubitHome.getPhotoMore();
        } else {
          _cubitHome.getPhotoMoreSearch();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    List<Photo> list = [];
    bool check = false;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF355C7D),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.solidStar, size: 20),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => Favorite(_cubitFavorite)));
            },
          ),
          const SizedBox(
            width: 18,
          )
        ],
        title: Text(
          "Flickr",
          style: GoogleFonts.italianno(
            fontSize: 40,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 30,
                decoration: const BoxDecoration(
                    color: Color(0xFF355C7D),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              ),
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xfff5f8fd),
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                            hintText: "search", border: InputBorder.none),
                      )),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _cubitHome.getDataSearch(
                                txt: _textEditingController.text);
                          });
                        },
                        child: const Icon(Icons.search),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(
              child: BlocBuilder<HomeCubit, StateHome>(
            bloc: _cubitHome,
            buildWhen: (pre, cur) => pre.enumStateHome != cur.enumStateHome,
            builder: (context, state) {
              if (state.enumStateHome == EnumStateHome.Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.enumStateHome == EnumStateHome.Success) {
                list = state.list!;
                check = false;
              } else if (state.enumStateHome == EnumStateHome.Loadmore) {
                check = true;
              }
              if (state.enumStateHome == EnumStateHome.Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.enumStateHome == EnumStateHome.Success) {
                list = state.list!;
                check = false;
              } else if (state.enumStateHome == EnumStateHome.LoadMoreSearch) {
                check = true;
              } else if (state.enumStateHome == EnumStateHome.Err) {
                _cubitHome.getDataHome();
              } else if (state.enumStateHome == EnumStateHome.Err) {
                return const Center(
                  child: Text(
                    "loi loadData",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return GridViewPhoto(
                check: check,
                list: list,
                onRefresh: () => _cubitHome.getDataHome(),
                scrollController: _scrollController,
              );
            },
          )),
        ],
      ),
    );
  }
}
