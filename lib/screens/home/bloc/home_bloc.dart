import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:phone_book/db/db.dart';
import 'package:phone_book/models/phone_book_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(HomeInitial()) {
    on<LoadFromDb>(_onLoadData);
    on<AddDataEvent>(_onAddData);
    on<DeleteDataEvent>(_onDeleteData);
    on<EditDataEvent>(_onEditData);
    on<SearchDataEvent>(_searchInList);
  }
  final TextEditingController cntName=TextEditingController();
  final TextEditingController cntNumber = TextEditingController();
  final TextEditingController cntSearch = TextEditingController();

  void _onLoadData(LoadFromDb event,Emitter<HomeState> emit)async{

    emit(
     PhoneBookDataState(model: await PhoneBookDateBase.instance.readAllPhoneBook())
    );

  }

  void _onAddData(AddDataEvent event,Emitter<HomeState> emit)async{

    await PhoneBookDateBase.instance.create(event.model);
    add(LoadFromDb());
    cntNumber.clear();
    cntName.clear();
  }
  void _onDeleteData(DeleteDataEvent event,Emitter<HomeState> emit)async{
    print("asdsadsaaadsa");


    await PhoneBookDateBase.instance.delete(event.id);
    add(LoadFromDb());
  }
  void _onEditData(EditDataEvent event,Emitter<HomeState> emit)async{
    print('Id : '+event.data.id.toString());
    print('Name : '+event.data.name.toString());
    print('Number : '+event.data.name.toString());
    await PhoneBookDateBase.instance.update(event.data);
    add(LoadFromDb());
  }

 void _searchInList(SearchDataEvent event,Emitter<HomeState> emit)async{
    final resultList = <PhoneBookModel>[];
    final listPhoneBook = state as PhoneBookDataState;

   if(event.value.isEmpty)
     {
     emit(PhoneBookDataState(model:  await PhoneBookDateBase.instance.readAllPhoneBook()));
     return;
     }
   for (var element in listPhoneBook.model) {
     if(element.name!.contains(event.value)){
       resultList.add(element);
     }
   }

    emit(
      PhoneBookDataState(
        model:  resultList
      )
    );
  }







}
