import 'package:flutter/material.dart';
import 'package:phone_book/db/db.dart';
import 'package:phone_book/models/phone_book_model.dart';
import 'package:phone_book/screens/home/bloc/home_bloc.dart';
import 'package:phone_book/widgets/text_field_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';


class BottomSheetWidget extends StatelessWidget {
  final bool isAddContact;
  final PhoneBookModel? data;
  const BottomSheetWidget({Key? key
  , this.isAddContact=true
  ,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc= context.watch<HomeBloc>();
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: mediaQueryData.viewInsets+
      const EdgeInsets.only(
        top: 15,
        bottom: 30
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 35,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(30)
            ),
          ),
           Text(isAddContact?'Add Contact':'Edit Contact',
          style: const TextStyle(
            color: Colors.black45,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),),
          const SizedBox(
            height: 50,
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 8,right: 8) ,
                        child:  const Icon(Icons.phone,
                        color: Colors.blue,)),
                    Expanded(
                      child:
                        TextFieldWidget(
                          controller: bloc.cntNumber,
                          textEdit: data?.number.toString(),
                          hintText: 'Phone Number',
                          inputType: TextInputType.phone,
                        )
                    )

                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 8,right: 5) ,
                        child:  const Icon(Icons.person_outline_outlined,
                        color: Colors.blue,)),
                    Expanded(
                      child:
                        TextFieldWidget(
                          controller: bloc.cntName,
                          hintText: 'Name',
                          textEdit: data?.name,
                        )
                    )

                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 50,),
          SizedBox(
            height: 40,
            width: 150,
            child: ElevatedButton(
                onPressed: () {
                  _addOrUpdateContact(context,
                  bloc,
                  data);
                },
                 child:  Text(isAddContact?'Save':'Edit',
                 style: const TextStyle(
                   fontWeight: FontWeight.bold
                 ),)),
          )

        ],
      ),
    );
  }
  void _addOrUpdateContact(BuildContext context,HomeBloc bloc,
      PhoneBookModel? phoneBookModel)async
  {
    if(bloc.cntName.text.isEmpty || bloc.cntNumber.text.isEmpty)
      {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in the boxes'))
        );
        return;
      }
    if(isAddContact)
      {
        var uuid = const Uuid();
        final id =uuid.v4().replaceAll(RegExp(r'[^0-9]'), '').take(8);
        final data = PhoneBookModel(
          id: int.parse(id),
          name: bloc.cntName.text,
          number: int.parse(bloc.cntNumber.text)
        );
        bloc.add(AddDataEvent(model: data));
        Navigator.of(context).pop(true);
      }else {

      final data = const PhoneBookModel().copyWith(
        id: phoneBookModel!.id,
          name: bloc.cntName.text,
          number: int.parse(bloc.cntNumber.text)
      );
      bloc.add(EditDataEvent(data));
      Navigator.of(context).pop(true);
    }
  }
}

extension StringX on String {
  String take(int nbChars) => substring(0, nbChars.clamp(0, length));
}

