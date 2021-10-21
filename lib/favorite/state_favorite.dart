import 'package:equatable/equatable.dart';
import 'package:flickr_app/service/model.dart';

enum EnumStateFavorite{
  IntitState,
  Loading,
  Success,
  Err,
  LoadMore,
}

class StateFavorite extends Equatable{
  List<Photo>? list;
  EnumStateFavorite enumStateFavorite;

  StateFavorite({this.list, this.enumStateFavorite = EnumStateFavorite.IntitState});

  StateFavorite copyWith({List<Photo>? list, required EnumStateFavorite enumStateFavorite}){
    return StateFavorite(
      list: list,
      enumStateFavorite: enumStateFavorite
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [enumStateFavorite];
}