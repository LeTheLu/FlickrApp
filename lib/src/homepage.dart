import 'package:flickr_app/favorite/cubit_favorite.dart';
import 'package:flickr_app/favorite/state_favorite.dart';
import 'package:flickr_app/home/cubit_home.dart';
import 'package:flickr_app/home/state_home.dart';
import 'package:flickr_app/service/model.dart';
import 'package:flickr_app/widget/grid_view_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  late HomeCubit _cubitHome;
  late FavoriteCubit _cubitFavorite;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _cubitFavorite = FavoriteCubit(StateFavorite());
    _cubitHome = HomeCubit(const StateHome());
    _cubitHome.getDataHome();
    _cubitFavorite.getDataFavorite();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _cubitHome.getPhotoMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Photo> list =[];
    bool check = false;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<HomeCubit, StateHome>(
              bloc: _cubitHome,
              buildWhen: (pre, cur) =>
              pre.enumStateHome != cur.enumStateHome,
              builder: (context, state) {
                if (state.enumStateHome == EnumStateHome.Loading) {
                  return const Center(
                      child: CircularProgressIndicator());
                } else if (state.enumStateHome == EnumStateHome.Success) {
                  list = state.list!;
                  check = false;
                } else if (state.enumStateHome == EnumStateHome.Loadmore) {
                  check = true;
                } else if (state.enumStateHome == EnumStateHome.Err) {
                  return const Center(
                    child: Text(
                      "loi loadData",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return GridViewPhoto(check: check,list: list, onRefresh:() => _cubitHome.getDataHome(),scrollController: _scrollController,);
              },
            ),
          ),
          GNav(
            //rippleColor: Colors.green, // tab button ripple color when pressed
              hoverColor: Colors.grey, // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 50,
              //tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
              //tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
              //tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
              curve: Curves.easeOutExpo, // tab animation curves
              duration: const Duration(milliseconds: 500), // tab animation duration
              gap: 8, // the tab button gap between icon and text
              color: Colors.grey[800], // unselected icon color
              activeColor: Colors.white, // selected icon and text color
              iconSize: 24, // tab button icon size
              tabBackgroundColor: Colors.white10, // selected tab background color
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // navigation bar padding
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Flickr',
                  textStyle: GoogleFonts.italianno(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                GButton(
                    icon: Icons.star,
                    text: 'Likes',
                    textStyle: GoogleFonts.italianno(
                      fontSize: 24,
                      color: Colors.white,
                    )
                ),
                GButton(
                    icon: Icons.search,
                    text: 'Search',
                    textStyle: GoogleFonts.italianno(
                      fontSize: 24,
                      color: Colors.white,
                    )
                ),
                GButton(
                    icon: Icons.face,
                    text: 'Profile',
                    textStyle: GoogleFonts.italianno(
                      fontSize: 24,
                      color: Colors.white,
                    )
                )
              ]
          ),
        ],
      ),
    );
  }
}
