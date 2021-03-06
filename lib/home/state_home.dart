import 'package:equatable/equatable.dart';
import 'package:flickr_app/service/model.dart';

enum EnumStateHome {
  IntitState,
  Loading,
  Success,
  Err,
  Loadmore,
  LoadMoreSearch,
}

class StateHome extends Equatable {
  final List<Photo>? list;
  final EnumStateHome enumStateHome;

  const StateHome({this.list, this.enumStateHome = EnumStateHome.IntitState});

  StateHome copyWith(
      {List<Photo>? list, required EnumStateHome enumStateHome,int? page}) {
    return StateHome(
        list: list,
        enumStateHome: enumStateHome,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [enumStateHome];
}
