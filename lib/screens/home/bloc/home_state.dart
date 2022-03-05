part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadingState extends HomeState{
  final bool isLoading ;
  LoadingState({this.isLoading= false});
}


class PhoneBookDataState extends HomeState{
  final List<PhoneBookModel> model;
   PhoneBookDataState({ this.model = const <PhoneBookModel>[]});

}
// class SearchDataState extends HomeState{
//   final bool isLoading ;
//   SearchData();
// }