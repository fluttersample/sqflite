import 'package:flutter/material.dart';
import 'package:phone_book/models/phone_book_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book/screens/home/bloc/home_bloc.dart';
import 'package:phone_book/screens/home/views/bottom_sheet_widget.dart';
import 'package:phone_book/screens/home/views/dialog_delete_item.dart';

class ItemListWidget extends StatelessWidget {
  final PhoneBookModel data;
  const ItemListWidget({Key? key,required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc= context.watch<HomeBloc>();
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0,end: 1.0),
      duration: const Duration(seconds: 1),
      builder: (BuildContext context, double opacity, Widget? child){
        return Opacity(opacity: opacity,
          child: SizedBox(
            height: 105,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    maxRadius: 25,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(Icons.person,
                        color:  Colors.white,
                        size: 30),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children:  [
                      Text(data.name!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          )),
                      const SizedBox(height: 8,),
                      Text(data.number.toString())


                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Card(
                          color:  Colors.grey.shade300,
                          child: InkWell(
                            onTap: () {
                              showButtonSheet(context, bloc, data);
                            },
                            child: const Icon(
                              Icons.edit,
                              size: 22,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Card(
                          color:  Colors.grey.shade300,
                          child: InkWell(
                            onTap: () {
                              showMyDialog(context,bloc,data);
                              //bloc.add(DeleteDataEvent());
                            },
                            child: const Icon(
                              Icons.delete_forever,
                              size: 22,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),);
      },


    );
  }

  void showMyDialog(BuildContext context,HomeBloc bloc, PhoneBookModel model)
  {

    showDialog(context: context,
      builder: (context) => BlocProvider.value(
          value: bloc,
          child:  DialogDeleteItem(model)),);
  }

  void showButtonSheet(BuildContext context,HomeBloc bloc,PhoneBookModel model) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (_) =>
            BlocProvider.value(
              value: bloc,
              child:  BottomSheetWidget(
                isAddContact: false,
                data: model,
              ),
            ));


  }

}

