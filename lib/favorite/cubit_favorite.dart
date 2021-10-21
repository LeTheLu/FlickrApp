import 'package:flickr_app/favorite/state_favorite.dart';
import 'package:flickr_app/service/model.dart';
import 'package:flickr_app/service/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<StateFavorite>{
  FavoriteCubit(StateFavorite initialState) : super(StateFavorite());

  int page = 1;
  List<Photo> list = [];
  Future<void> getDataFavorite() async {
    try{
      emit(state.copyWith(enumStateFavorite: EnumStateFavorite.Loading));
      list =  await NetWorkFavorite.getPhotoFavorite();
      emit(state.copyWith(enumStateFavorite: EnumStateFavorite.Success,list: list));
    }catch(e){
      emit(state.copyWith(enumStateFavorite: EnumStateFavorite.Err));
    }
  }

  Future<void> getDataFavoriteMore() async {
    try{
      emit(state.copyWith(enumStateFavorite: EnumStateFavorite.LoadMore));
      List<Photo> _list =  await NetWorkFavorite.getPhotoMore(++page);
      list.addAll(_list);
      emit(state.copyWith(enumStateFavorite: EnumStateFavorite.Success,list: list));
    }catch(e){
      emit(state.copyWith(enumStateFavorite: EnumStateFavorite.Err));
    }
  }
}