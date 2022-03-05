part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class LoadFromDb extends HomeEvent{}

class AddDataEvent extends HomeEvent{
  final PhoneBookModel model ;
  AddDataEvent({required this.model,});
}

class DeleteDataEvent extends HomeEvent{
  final int id;

  DeleteDataEvent(this.id);
}

class EditDataEvent extends HomeEvent{
  final PhoneBookModel data;

  EditDataEvent(this.data);
}
class SearchDataEvent extends HomeEvent{
  final String value;

  SearchDataEvent(this.value);
}


