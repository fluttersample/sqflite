import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book/models/phone_book_model.dart';
import 'package:phone_book/screens/home/bloc/home_bloc.dart';


class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    return Container(
      margin: const EdgeInsets.only(right: 0,left: 0,
          top: 10,
          bottom: 10),
      height: 42,
      child: TextField(
        controller: bloc.cntSearch,
        cursorColor: Colors.black,
        onChanged: (value){
          bloc.add(SearchDataEvent(value));
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.all(0),
            hintText: 'Search by name',
            prefixIcon:   Icon(Icons.search,
              color: Colors.grey.shade600,),
            labelStyle: const TextStyle(
                color: Colors.black
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:  BorderSide(
                    color: Colors.blueAccent.shade400,
                    width: 2
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:  const BorderSide(
                    color: Colors.white,
                    width: 2
                )
            )


        ),
      ),
    );
  }
  // void searchAlgorithm(String value,HomeBloc bloc)
  // {
  //   final resultList = <PhoneBookModel>[];
  //   if(bloc.state is PhoneBookDataState)
  //     {
  //
  //     }
  // }
}