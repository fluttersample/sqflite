import 'package:flutter/material.dart';
import 'package:phone_book/models/phone_book_model.dart';
import 'package:phone_book/screens/home/bloc/home_bloc.dart';
import 'package:phone_book/screens/home/views/bottom_sheet_widget.dart';
import 'package:phone_book/screens/home/views/item_list.dart';
import 'package:phone_book/screens/home/views/search_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class HomeSc extends StatelessWidget {
  const HomeSc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const SearchWidget(),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(

        builder: (context, state) {
          if (state is HomeInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PhoneBookDataState) {
            if (state.model.isEmpty) {
              return const Center(
                child: Text('No Contact '),
              );
            }
            return ListView.separated(
                itemCount: state.model.length,
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                itemBuilder: (context, index) {
                  final PhoneBookModel data = state.model[index];
                  return ItemListWidget(data: data,);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                      height: 1,
                      color: Colors.grey.shade300,)

            );
          }

          return const Center(
            child: Text("SomeThing went wrong!"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
         showButtonSheet(context,
         bloc);
        },
      ),
    );
  }

  void showButtonSheet(BuildContext context,HomeBloc bloc) {
  showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (_) =>
            BlocProvider.value(
              value: bloc,
              child: const BottomSheetWidget(
              ),
            ));

  }

}
