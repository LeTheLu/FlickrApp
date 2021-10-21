import 'package:flickr_app/home/state_home.dart';
import 'package:flickr_app/service/model.dart';
import 'package:flickr_app/service/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<StateHome>{
  HomeCubit(StateHome initialState) : super(StateHome());
  int a = 1;
  List<Photo> list = [];
  Future<void> getDataHome() async {
    try{
      emit(state.copyWith(enumStateHome: EnumStateHome.Loading));
      list = await NetWorkHome.getPhoto();
      emit(state.copyWith(enumStateHome: EnumStateHome.Success, list: list));
    }catch(e){
      emit(state.copyWith(enumStateHome: EnumStateHome.Err));
    }
  }
  Future<void> getPhotoMore() async {
    try{
      emit(state.copyWith(enumStateHome: EnumStateHome.Loadmore));
      List<Photo> _list = await NetWorkHome.getPhotoMore(++a);
      list.addAll(_list);
      emit(state.copyWith(enumStateHome: EnumStateHome.Success, list: list));
    }catch(e){
      emit(state.copyWith(enumStateHome: EnumStateHome.Err));
    }
  }

  int page = 1;

  Future<void> getDataSearch({String txt =""})  async {
    try{
      emit(state.copyWith(enumStateHome:  EnumStateHome.Loading));
      list =  await NetWorkSearch.search(txt);
      emit(state.copyWith(enumStateHome:  EnumStateHome.Success , list: list));
    }catch(e){
      emit(state.copyWith(enumStateHome:  EnumStateHome.Err));
    }
  }

  Future<void> getPhotoMoreSearch() async {
    try{
      emit(state.copyWith(enumStateHome:  EnumStateHome.LoadMoreSearch));
      List<Photo> _list =  await NetWorkSearch.loadMoreSearch(++page);
      list.addAll(_list);
      emit(state.copyWith(enumStateHome:  EnumStateHome.Success,list: list));
    }catch(e){
      emit(state.copyWith(enumStateHome:  EnumStateHome.Err));
    }
  }

}